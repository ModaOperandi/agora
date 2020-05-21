# Binlog Readers

There is one production binlogger stream, it can only support 20 consumers, we will likely need more than 20 for all the services, especially with multiple environments (SDLC-SANDBOX,DEV,STAGE,PROD)

Solution is to fan our binlogger, so entire stream is re-streamed per team, or per-function


~~~~
                               binlog-replica-marketing-email
binlog-mojo-db-events_prod --> binlog-replica-product-catalog 
                               binlog-replica-etc...

~~~~

There's an open source lambda that lets us fan out kinesis stream to multiple kinesis streams: https://github.com/aws-samples/aws-lambda-fanout

Managing lambda is described here: https://modaoperandi.atlassian.net/wiki/spaces/DEVOPS/pages/469270533/aws-lambda-fanout+for+binlogger+replicas
