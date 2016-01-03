require "./consumer.rb"
require "./market.rb"
require "./producer.rb"


SIMULATION_DURATION = 150
NUM_OF_PRODUCERS = 10 
NUM_OF_CONSUMERS = 10
MAX_STARTING_SUPPLY = 20
SUPPLY_INCREMENT = 80
COST = 5
MAX_ACCEPTABLE_PRICE = COST * 10
MAX_STARTING_PROFIT = 5 
PRICE_INCREMENT = 1.1 
PRICE_DECREMENT = 0.9


$producers = []

NUM_OF_PRODUCERS.times do
	producer = Producer.new
	producer.price = COST + rand(MAX_STARTING_PROFIT)
	producer.supply = rand(MAX_STARTING_SUPPLY) 
	$producers << producer
	p producer.price
end

$consumers = []

NUM_OF_CONSUMERS.times do
	$consumers << Consumer.new
end

p Market.average_price
