#!/usr/bin/env ruby

require 'thrift'
$:.push('gen-rb')
require 'hello_svc'

begin
  trans_ep = Thrift::Socket.new('localhost', 9095)
  trans_buf = Thrift::BufferedTransport.new(trans_ep)
  proto = Thrift::BinaryProtocol.new(trans_buf)
  client = HelloSvc::Client.new(proto)

  trans_ep.open()
  res = client.getMessage('world')
  puts 'Message from server: ' + res
  trans_ep.close()
rescue Thrift::Exception => tx
  print 'Thrift::Exception: ', tx.message, "\n"
end

