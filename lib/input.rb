class Input
  attr_accessor :value, :weight, :neuron, :lastweight

  def initialize()
    num = Random.rand(2)
    @function = Sigmoid.new if num == 0
    @function = Tanh.new if num == 1
    @neuron = Neuron.new(@function)
    @weight = (rand*2.0)-1.0
    @lastweight = 0.0
  end

  def weight=(value)
    @lastweight = @weight
    @weight = value
  end

  def read
    @value * @weight
  end

end
