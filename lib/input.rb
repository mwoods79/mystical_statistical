class Input
  attr_accessor :value, :weight, :neuron, :lastweight

  def initialize()
    @neuron = Neuron.new(Sigmoid.new)
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
