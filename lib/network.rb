class Network

  attr_accessor :learningrate, :inputs

  def initialize(numInputs, numOutputs, numLayers)

    @layers = Array.new
    @inputs = Array.new
    @learningrate = 0.15
    @biasNeuron = Neuron.new(Sigmoid.new)
    @biasNeuron.output = 1.0

    1.upto(numLayers) do |n|
      neurons = Array.new

      numNeurons = case n
        when 1 then numInputs
        when numLayers then numOutputs
        else numInputs + 2
      end

      numNeurons.times do |n|
        neurons.push(Neuron.new(Sigmoid.new))
      end

      layer = Layer.new(neurons, @biasNeuron)
      @layers.push(layer)

      layer.connect(@layers[n-2]) unless n == 1

    end
    @layers.first.attachInput

    @inputs.concat((@layers.first.neurons.map { |neuron| neuron.dendrites}).flatten)

  end

  def train(output, ideal)
    # compute output error
    outputerror = (Vector.[](*ideal) - Vector.[](*output)).to_a

    #puts "Error #{outputerror}"

    # clear error pass
    (@layers.length-1).downto(0) do |i|
      @layers[i].neurons.each do |neuron|
       neuron.dendrites.each do |dendrite|
          dendrite.neuron.error = 0.0
        end # dendrite
      end # neuron
    end # layer index


    # load last layers error
    @layers.last.neurons.each_with_index do |neuron, i|
      neuron.error = outputerror[i]
    end

    # start at output layer and propogate gradient back to input
    (@layers.length-1).downto(0) do |i|
      @layers[i].neurons.each do |neuron|
        # each output neuron computes local gradient - error * dirivative of activation
        localgradient = neuron.error * neuron.activation.derivative(neuron.input)
        # use local gradient to compute each parent neurons output error
        neuron.dendrites.each do |dendrite|
          dendrite.neuron.error += localgradient * dendrite.weight
          delta_w = @learningrate * localgradient * dendrite.neuron.output
          dendrite.weight = dendrite.weight + delta_w # 0.8 is the momentum
        end # dendrite
      end # neuron
    end # layer index

  end
  
  def toGraphViz
    g = GraphViz::new( "G" )
    prevLayer = Array.new
    
    @layers.first.neurons.each_with_index do |neuron, j|
      prevLayer.push(g.add_node("N_0_#{j}"))
    end
    
    1.upto(@layers.length-1) do |i|
      currentLayer = Array.new
      @layers[i].neurons.each_with_index do |neuron, j|
        newNode = g.add_node("N_#{i}_#{j}")
        currentLayer.push(newNode)
        prevLayer.each_with_index do |node, i|
          weight = neuron.dendrites[i].weight
          g.add_edge(node, newNode, :label => "#{weight}")
        end # previous layer nodes
      end # current layer neuron
      prevLayer = currentLayer
    end # layer index

    g.output( :png => "#{$0}.png" )
    g.save( :svg => "#{$0}.svg" )
  end

  def run(inputs)
    @inputs.each_with_index do |input, i|
      input.value = inputs[i]
    end

    @layers.each do |l|
      l.fire()
    end

    # return output array
    @layers.last.neurons.map { |n| n.output }

  end
end
