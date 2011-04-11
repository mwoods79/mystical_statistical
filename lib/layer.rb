class Layer
  attr_accessor :neurons

  def initialize(neurons, biasNeuron)
    @neurons = neurons
    @biasNeuron = biasNeuron
  end

  def connect(layer)
    @neurons.each_with_index do |n|
      layer.neurons.each do |m|
        n.addDendrite(Dendrite.new(m))
      end
      n.addDendrite(Dendrite.new(@biasNeuron))
    end
  end

  def attachInput
    @neurons.each_with_index do |n|
      n.addDendrite(Input.new)
    end
  end

  def fire
    @neurons.each do |n|
      n.activate
    end
  end

end
