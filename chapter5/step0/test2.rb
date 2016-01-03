
class Avenum
	def average1to10
		(1..10).inject(0) do |average, num| num + average
		end
	end
end

ave = Avenum.new
p ave.average1to10

