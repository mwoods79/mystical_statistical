class Input
  attr_accessor :value, :weight, :neuron

  def initialize()
    @neuron = Neuron.new(Sigmoid.new)
    @weight = (rand*1.0)-0.5
  end

  def weight=(value)
    @weight = value
    #puts "Input W set to #{value}"
  end

  def read
    @value * @weight
  end

end
