sleep 5
conn = Bunny.new(:hostname => "rabbitmq")
conn.start
BUNNY = conn.create_channel
