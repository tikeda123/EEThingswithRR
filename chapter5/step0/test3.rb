class Test3
  def my_method(n)
    n+1 if n > 0
  end
end

t = Test3.new
p t.my_method(-1)
