network = Network.new(2,1,3)
network.learningrate = 0.9
network.momentum = 0.001
n = 10000
p = n / 10
plot = n / 20
errorX = Array.new
errorY00 = Array.new
errorY10 = Array.new
errorY11 = Array.new
errorY01 = Array.new

avgError = 1.0
i = 0
while (i < n and avgError > 0)
  
  outputvals00 = network.run([0.0,0.0])
  network.train(outputvals00, [0.0])
  
  outputvals10 = network.run([1.0,0.0])
  network.train(outputvals10, [1.0])
  
  outputvals01 = network.run([0.0,1.0])
  network.train(outputvals01, [1.0])
  
  outputvals11 = network.run([1.0,1.0])
  network.train(outputvals11, [0.0])
  
  error00=0.0-outputvals00[0]
  error10=1.0-outputvals10[0]
  error11=0.0-outputvals11[0]
  error01=1.0-outputvals01[0]
  
  avgError = (error00.abs + error10.abs + error11.abs + error01.abs).to_f
  avgError = avgError/4.0
  
  if ((i % plot)  == 0) then  
    errorX.push(i)
    errorY00.push(error00)
    errorY10.push(error10)
    errorY11.push(error11)
    errorY01.push(error01)
  end
   
  if ((i % p)  == 0) then 
    puts " 0,0 = #{outputvals00[0]} " 
    puts " 0,1 = #{outputvals01[0]} "
    puts " 1,0 = #{outputvals10[0]} "
    puts " 1,1 = #{outputvals11[0]} "
    puts " avg error = #{avgError.abs}"
    puts "#{(i.to_f/n.to_f)*100.0} %"
  end 
  i += 1
end

network.toGraphViz

lines = [errorY00, errorY10, errorY11, errorY01]
chart = NeuroChart.new(errorX, lines)
chart.createSVGChart

puts 'Logical XOR test'
puts '0 XOR 0 = ' + network.run([0,0])[0].to_s
puts '0 XOR 1 = ' + network.run([0,1])[0].to_s
puts '1 XOR 0 = ' + network.run([1,0])[0].to_s
puts '1 XOR 1 = ' + network.run([1,1])[0].to_s
