require 'sneakers'
Sneakers.configure  :connection => Bunny.new(:hostname => "rabbitmq")
