# NetSuite

Moda is rearchitecting its system to put [NetSuite](https://3544490.app.netsuite.com/app/center/card.nl) at the core. In addition to Tech (and TechOps), both Finance and Ops will be using NetSuite for some of their processes. As such, it is important to be clear about which parts of NetSuite are Tech's responsibility.


## Defaults

Because NetSuite has a large number of techinical integrations with other parts of the Moda ecosystem, the default is that Tech owns a feature in NetSuite. This will enable us to keep watch over the system in order to ensure that unexpected changes do not have adverse downstream effects. Moda Tech must build in-house expertise in NetSuite in order to support this ownership.

At a high level, Tech will own the "infrastructure" (e.g. definitions, types, workflows, etc) in NetSuite and partners will own the "data" (e.g. transfer orders, purchase orders, GL entries, etc) in NetSuite; sometimes Tech will also be responsible for "data" (e.g. automated transfer order creation).

Additionally, TechOps will be responsible for user accounts and permissions.


## Governance

* Ownership will be defined and maintained by roles and permissions granted to those roles. If a department owns a part of NetSuite, the permissions should reflect that ownership and nothing more.
* The roles will be classified by the department that the role applies to, e.g. `finance/accountant`, `tech/developer`, `ops/packer`.
* Permissions will be assigned to departments, to represent which functionality in NetSuite that department owns.
* With the role naming structure combined with the list of permissions, we can automate checks to ensure that ownership borders are maintained.

Unfortunately, permission assignment to roles cannot be managed through automated processes (i.e. via the API or Restlets) and must be manually managed through the NetSuite UI. Furthermore, SCIM is only available when paying for [an additional security package](https://www.netsuite.com/portal/platform/infrastructure/operational-security.shtml) (estimated to cost $50k per year), so for now we will manage user-role assignment manually as well. With any manual process, it is good to [trust-but-verify](../core-tenets/collaboration.md#trust-but-verify). Our verification approach will be:

* Moda TechOps will create NetSuite-related groups in Okta.
  * Group/role name should be of the format `{department}/{role_name}`.
  * Group is not NetSuite-specific and should not be named as such - because those groups may also grant access to other tools.
  * The role in NetSuite should include the applicable permissions.
  * Any Okta group that corresponds to a NetSuite role should additionally be created in NetSuite.
* Moda TechOps will manually manage [role permissions](https://3544490.app.netsuite.com/app/common/search/search.nl?searchtype=Role) and [user role membership](https://3544490.app.netsuite.com/app/setup/listusers.nl).
  * When adding people to groups in Okta, TechOps will need to also add NetSuite users to the corresponding role in NetSuite.
* We will create and maintain a Google Sheet with permission ownership assignment. Columns: department, permission, type (view/create/edit/full).
* Google Sheet will be synced to Snowflake.
* Okta data (users, groups, group user membership) will be synced to Snowflake.
* NetSuite data (roles, role permissions, users, user roles) will be synced to Snowflake.
* Checks
  * Count of roles in NetSuite but not in Okta.
    * Alert if > 0.
    * Resolve by either creating the new role as a group in Okta or by deleting the NetSuite role.
    * Protects against someone adding a role in NetSuite that has no visibility in Okta.
    * May need to carve out an exception for perma-roles that can't be deleted from NetSuite.
  * Count of users in roles (other than Administrator) not in Okta.
    * Alert if > 0.
    * Resolve by removing the role from the user and instead identifying and assigning the user to an established role.
    * Protects against users being added to roles that are outside of this governance.
  * Count of NetSuite role permissions in each department that are not in the Google Sheet for that department.
    * Alert if > 0.
    * Resolve by either removing the permissions from the role or updating the Google Sheet if permissions are needed by that department.
    * Protects against a department getting permissions outside of its agreed-upon ownership.
  * Count of permissions in NetSuite that are not covered by the Google Sheet.
    * Alert if > 0.
    * Resolve by assigning ownership of that permission to a department in the Google Sheet.
    * Protects against new permissions in NetSuite being added without establishing the correct owner.
  * Optional: linter that checks NetSuite code for objects that are not in Tech's ownership.
    * May be difficult to implement.
    * Protects against Tech overstepping its ownership.


## Next steps + cleanup
Moda Tech has a list of roles and permissions from Finance.

First step will be to create roles in NetSuite. TechOps should own this. Once this is complete, it is the main thing the business needs from Tech.
* Create roles with correct permissions in NetSuite.
* Assign users to those roles.
* Remove users from legacy roles.
* Wait ~2 months for users to raise any issues (keeping in mind monthly Finance processes).
* Once the new roles have the correct permissions, delete existing roles that can be deleted. For any not-deletable-roles, make sure there are no users in them.

After the above, we should work to get the checks in place, with alerts going to TechOps (low priority, during business hours).


## Alternatives considered

### SCIM for user-role membership

As mentioned above, the cost seems to outweigh the benefit of a very occasional manual double-tap (adding employees to groups in Okta _and_ to roles in NetSuite).


### Workato recipe to sync Okta to NetSuite

The process would be something like this:
* Listen on [Okta events](https://docs.workato.com/en/connectors/okta/new-events-trigger.html#new-events-real-time) for add/remove users in group.
* Use the [Netsuite REST connector](https://docs.workato.com/en/connectors/netsuite-rest.html) to look up the group in NetSuite.
* If group not found, exit. If found, look up the user (using the connector)
* If user not found,
  * Create the user
  * Include the role id in the user creation
* If user found,
  * Append the role id to the list of roles (if not already present)
  * Update the user the the list of roles

This would replicate the SCIM process and would be essentially free in Workato (given the infrequency of user-group adds). But it is another piece of code that needs to be developed/owned/maintainer/monitored. It probably makes more sense to keep things simple (manual), consider standard SCIM in the future, and monitor the system in the interim.
