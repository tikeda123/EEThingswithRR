
require 'csv'
require "./consumer.rb"
require "./market.rb"
require "./producer.rb"


SIMULATION_DURATION = 150
NUM_OF_PRODUCERS = 10
NUM_OF_CONSUMERS = 10

MAX_STARTING_SUPPLY = Hash.new
MAX_STARTING_SUPPLY[:ducks] = 20
MAX_STARTING_SUPPLY[:chickens] = 20
SUPPLY_INCREMENT = 60

COST = Hash.new
COST[:ducks] = 20
COST[:chickens] = 12

MAX_ACCEPTABLE_PRICE = Hash.new
MAX_ACCEPTABLE_PRICE[:ducks] = COST[:ducks] * 10
MAX_ACCEPTABLE_PRICE[:chickens] = COST[:chickens] * 10

MAX_STARTING_PROFIT = Hash.new
MAX_STARTING_PROFIT[:ducks] = 15
MAX_STARTING_PROFIT[:chickens] = 15
PRICE_INCREMENT = 1.1
PRICE_DECREMENT = 0.9


def write(name,data)
	CSV.open("#{name}.csv", 'w') do |csv|
		data.each do |row|
			csv << row
		end 
	end
end

def initialize_data( )

	$producers = []
	NUM_OF_PRODUCERS.times do
		producer = Producer.new
		producer.price[:chickens] = COST[:chickens] + rand(MAX_STARTING_PROFIT[:chickens])
		producer.price[:ducks]    = COST[:ducks] + rand(MAX_STARTING_PROFIT[:ducks])
		producer.supply[:chickens] = rand(MAX_STARTING_SUPPLY[:chickens])
		producer.supply[:ducks]    = rand(MAX_STARTING_SUPPLY[:ducks])
		$producers << producer
	end

	$consumers = [] 
	NUM_OF_CONSUMERS.times do
		$consumers << Consumer.new
	end

	$generated_demand = []	
	SIMULATION_DURATION.times { |n| $generated_demand << ((Math.sin(n)+2)*20).round }
end

def execute_simulation()
	price_data, supply_data = [], [] 
	
	SIMULATION_DURATION.times do |t|
		$consumers.each do |consumer|
			consumer.demands = $generated_demand[t]
		end
	
		supply_data << [t, Market.supply(:chickens), Market.supply(:ducks)]
	
		$producers.each do |producer| 
			producer.produce
		end
	
		cheaper_type = Market.cheaper(:chickens, :ducks)
	
		until Market.demands == 0 or Market.supply(cheaper_type) == 0 do 
			$consumers.each do |consumer|
				consumer.buy cheaper_type 
			end
		end
	
		price_data << [t, Market.average_price(:chickens), Market.average_price(:ducks)] 
	end
	write("price_data", price_data)
	write("supply_data", supply_data)
end

initialize_data
execute_simulation


