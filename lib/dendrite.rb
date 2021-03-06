class Dendrite
  attr_accessor :weight, :neuron, :lastweight

  def initialize(neuron)
    @neuron = neuron
    @weight = (rand*2.0)-1.0
    @lastweight = 0.0
  end

  def weight=(value)
    @lastweight = @weight
    @weight = value
  end

  def read
    @neuron.output * @weight
  end

end
