require 'sneakers'
Sneakers.configure  :connection => Bunny.new(:hostname => "rabbitmq")
Sneakers.logger.level = Logger::INFO
