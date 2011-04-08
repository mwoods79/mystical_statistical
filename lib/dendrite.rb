class Dendrite
  attr_accessor :weight, :neuron

  def initialize(neuron)
    @neuron = neuron
    @weight = (rand*1.5)-0.5
  end

  def read
    @neuron.output * @weight
  end

end
