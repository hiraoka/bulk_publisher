#What is BulkPublisher

amqpに任意の数のメッセージをpublishするツール。

##Setting

`環境変数`
```
'PHX_AMQP_HOST'
'PHX_AMQP_PORT'
'PHX_AMQP_VHOST'
'PHX_AMQP_USER'
'PHX_AMQP_PASS'
'PHX_AMQP_SSL'
'PHX_ROUTING_KEY'
```

## How to Use
`commands`
```  
ruby bin/bulk_publisher.rb start
```

`require_param`
```
-m integer message count that number of per thread.
```

`options`
```
-t integer thread count.
-f string  pid file path.
```