class Tanh
  def function(weightedVals)
    exp2x = Math.exp(weightedVals * 2.0)
    (exp2x - 1.0) / (exp2x + 1.0);
  end

  def derivative(weightedVals)
    val = 1.0 - function(weightedVals)**2
  end
end
