#What is BulkPublisher

amqpに任意の数のメッセージをpublishするツール。

##Setting

`設定が必要な環境変数`
```
'BP_AMQP_HOST'
'BP_AMQP_PORT'
'BP_AMQP_VHOST'
'BP_AMQP_USER'
'BP_AMQP_PASS'
'BP_AMQP_SSL'
'BP_ROUTING_KEY'
```

## How to Use
`最初に`
```
bundle installed
```


`commands`
```
ruby bin/bulk_publisher.rb start
```

`require_param`
```
-m (integer) #message count that number of per thread.
```

`options`
```
-t (integer) #thread count. (default 5)
-P (string)  #pid file path.
```

##MEMO
スレッド数(-t) * メッセージ数(-m) = publishする数
