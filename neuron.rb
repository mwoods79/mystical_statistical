class Neuron
  attr_accessor :dendrites, 
                :input, 
                :output, 
                :error, 
                :activation
  
  def initialize(activation)
    @activation = activation
    @dendrites = Array.new 
    @error = 0.0
    @output = 0.0
  end
  
  def activate
    @input = 0
    @dendrites.each do |d|
      @input += d.read
    end
    @output = @activation.function(@input + @bias)
  end
  
  def addDendrite(dendrite)
    @dendrites.push(dendrite)
  end
  
end