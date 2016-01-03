require "../producer.rb"
require "../consumer.rb"
require "../market.rb"
require "../simulation.rb"

describe Producer do
 before do
 	initialize_data
 end
  
  it 'test_msg' do
    t = Producer.new
    expect(t.test_msg).to eq 'Hello'
  end
  
  it 'Market.average_price' do
  	expect( Market.average_price(:chickens)).to be > 0 
  	 p Market.average_price(:chickens)
  	 p Market.average_price(:ducks)
  	 SIMULATION_DURATION.times { |n| 
  	 	$generated_demand << ((Math.sin(n)+2)*20).round
  	 	p $generated_demand[n]
  	 }
  end
  	
end