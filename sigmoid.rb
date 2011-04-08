class Sigmoid
  def function(weightedVals)
    1.0 / (1.0 + Math.exp(weightedVals * -1.0));
  end
  
  def derivative(weightedVals)
    val = function(weightedVals)
    val*(1.0-val)
  end
end