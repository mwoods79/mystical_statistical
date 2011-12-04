require File.join(File.dirname(__FILE__), 'logictest.rb')

operator = 'XOR'
inputs = [[0,0],[0,1],[1,0],[1,1]]
outputs = [[0],[1],[1],[0]]
iterations = 2000
momentum = 0.001
learning_rate = 0.3
logicTest = LogicTest.new(operator, inputs, outputs, iterations, momentum, learning_rate)
logicTest.test