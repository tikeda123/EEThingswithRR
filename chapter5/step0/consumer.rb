class Consumer
  attr_accessor :demands

  def initialize
    @demands = 0
  end

  def buy
    until @demands <= 0 or Market.supply <= 0
      chepaest_producer = Market.cheapest_producer

      if chepaest_producer
        @demands *= 0.5 if chepaest_producer.price > MAX_ACCEPTABLE_PRICE
        chepaest_supply = chepaest_producer.supply

        if @demands > chepaest_supply
          @demands -= chepaest_supply
          chepaest_producer.supply = 0
        else
          chepaest_producer.supply -= @demands
          @demands = 0
        end
      end
    end
  end

end