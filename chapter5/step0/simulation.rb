
require 'csv'
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


def initialize_data(additional_consumer_num)
	$producers = []

	NUM_OF_PRODUCERS.times do
		producer = Producer.new
		producer.price = COST + rand(MAX_STARTING_PROFIT) 
		producer.supply = rand(MAX_STARTING_SUPPLY) 
		$producers << producer
	end

	$consumers = []

	(NUM_OF_CONSUMERS + additional_consumer_num).times do
		$consumers << Consumer.new
	end

	$generated_demand = []
	SIMULATION_DURATION.times {|n| $generated_demand << ((Math.sin(n)+2)*20).round }
	$demand_supply, $price_demand = [], []
end

def execute_simulation(additional_consumer_count)
	initialize_data additional_consumer_count

	SIMULATION_DURATION.times do |t|
		$consumers.each do |consumer|
			consumer.demands = $generated_demand[t] 
		end
	
		$demand_supply << [t, Market.demand, Market.supply]
	
		$producers.each do |producer|
			producer.produce
		end
	
		$price_demand << [t, Market.average_price, Market.demand]
	
		until Market.demand == 0 or Market.supply == 0 do
			$consumers.each do |consumer|
				consumer.buy 
			end
		end
		write("demand_supply" + additional_consumer_count.to_s, $demand_supply)
		write("price_demand" + additional_consumer_count.to_s, $price_demand)
	end
end

def write(name,data)
	CSV.open("#{name}.csv", 'w') do |csv|
		data.each do |row|
			csv << row
		end 
	end
end

MAX_CONSUMERS = 20

(MAX_CONSUMERS - NUM_OF_CONSUMERS).times do |i|
	execute_simulation i
end



