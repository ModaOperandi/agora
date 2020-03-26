# Binlog Readers

We have one production binlog stream.  Recently we realized that only 20 consumers can register with a kinesis stream.  With the way we're building microservices we will need more than 20 consumers of binlog.  What are our options?

1. Fan our binlogger, so entire stream is re-streamed per team, or per-function


~~~~
                               binlog-mojo-db-events_prod-consumer
binlog-mojo-db-events_prod --> binlog-mojo-db-events_prod-supply
                               binlog-mojo-db-events_prod-product-catalog
                               ... etc

~~~~

2. Have multiple binlog streams

3. Nag amazon to give us more consumers.  (I think we already asked and they said no)

4. Maybe do something clever with shards?

5. Binlogger is a "temporary" solution any way - every one should hurry up and buidl services with their own self-contained data.

6. Each team is only allowed one consumer: put more code into binloggers, don't just write one for the sake getting updates on 2-3 tables.

7. What else can we do?
