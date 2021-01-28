# GraphQL Server

### Goals
1. Indirection of calls to backend to smooth dependent API changes.
2. Authentiacation controlled in single place.
3. Selectively caching data, where appropriate.
4. Normalizing connections - same client and approach used across codebase to connect to backends.
5. Change payload when it's required.

### GraphQL Server
Overview of architecture using GraphQL server:
<img src="/images/gql-overview.png">

Below under GQL Server Apollo Server is assumed though other implementataions could provide similar functionality and even architecture.
How goals are achieved:
1. As long as GQL types stay the same, clients (frontend and mobile) do not need to be modified even when backend API is changing. If changes are affecting structure of responses then change of GQL resolvers would be needed.
2. Authentication validation could be embeeded to each resolver and code could be reused. There's also possibility to protect each individual GQL Type. We can use code to validate token via call to `user-api`. All backend services will be turned to `publicAccess: office` or lower to gurantee that no connections are made from outside directly to backend services.
3. Caching is implemented in GQL Server at different levels: most basic is caching at GQL Type level (aka static caching). Caching could be scoped: private or public. Private means requestor specific (for Moda use-case this might be overkill). Another ability to cache is provided at resolver level (aka dynamic caching). It's not clear which type of caching is better in case of Moda (TBD).
4. All connections made from frontend and mobile would be made the same way - via GQL query and generated (from query) code.
5. Changing backend JSON payload is discussed [here](#changing-backend-json-payload).

### Current Usage of GQL

GraphQL is everywhere already:
1. Stylist server side `antechamber` is implemented as Apollo Server. On the cliend side in `underground` there's a code generation based on GQL queries. Few things that are not done in stylist: no codegeneration for HTTP clients used (though most of clients are to Mojo), no codegen for GQL Types and resolvers (though some of them are doing data "shuffle").
2. Algolia is implemented as GQL Server therefore all parts of the system that request `search-api` API are using GQL queries with codegen, users are: `discovery` and `mobile-app`.
3. `discovery` is doing REST requests via GQL queries + rest link in them. This leads to lack of code generation from GQL query. Here's an example:
```ts
export type DesignerAffinitiesQuery = { // this is handcrafted VS generated
  designerAffinities: {
    __typename: 'DesignerAffinities';
    top: number[];
    similar: number[];
  };
};

export type DesignerAffinitiesQueryVariables = { // this is handcrafted VS generated
  userId: string;
  limit: number;
};

export const DESIGNER_AFFINITIES_QUERY: TypedDocumentNode<
  DesignerAffinitiesQuery,
  DesignerAffinitiesQueryVariables
> = gql`
  query DesignerAffinitiesQuery($userId: String!, $limit: Int!) {
    designerAffinities(userId: $userId, limit: $limit)
      @rest(
        type: "DesignerAffinities"
        endpoint: "recommendations"
        path: "/designer_affinities/top_designers/{args.userId}?limit={args.limit}"
      ) {
      top
      similar
    }
  }
`;
```

### Codegen with GraphQL Server

Here's diagram showing what parts could be code generated in and outside of GraphQL Server:
<img src="/images/gql-codegen.png">

### Changing backend JSON payload

Here's an example of changing JSON payload from Stylist `antechamber`:
```ts
export const OrderType = new GraphQLObjectType<TOrder, ResolverContext>({
  name: 'Order',
  fields: () => ({
    adminLinks: {
      type: OrderAdminLinksType,
      resolve: ({ admin_links }) => admin_links
    },
    // ....
    createdAt: dateField<TOrder>({ resolve: ({ created_at }) => created_at }),
    updatedAt: dateField<TOrder>({ resolve: ({ updated_at }) => updated_at }),
    deliveryStart: {
      type: GraphQLString,
      resolve: ({ order_items }) => {
        const today = new Date();
        const deliveryDateList = order_items.map(oi => {
          const delivery_starts_on =
            oi.product && oi.product.Product?.customer_delivery_starts_on
              ? oi.product.Product?.customer_delivery_starts_on
              : null;
          if (delivery_starts_on && new Date(delivery_starts_on) > today) {
            return delivery_starts_on;
          }
          return null;
        });
        return deliveryDateList
          .filter(item => !!item)
          .sort(function (a, b) {
            const dateA = a || '0';
            const dateB = b || '0';
            return Date.parse(dateA) - Date.parse(dateB);
          })[0];
      }
    },
    // ....
    client: {
      type: new GraphQLNonNull(ClientType),
      resolve: ({ client }, _args, { services: { stylist } }) => stylist.client(client.id)
    },
    // ....
  })
});
```

Advantages of changing payload:
1. Enables real decoupling of clients from backend.
2. Allows fixing broken API (Mojo).

Disadvantages:
1. Kills potential codegeneration of GQL Types from backend schema. At least complicates it for user.
2. Opens GraphQL Server for implementing pieces of business logic.
