network = Network.new(2,1,3)
n = 100000
p = n / 10
plot = n / 20
errorX = Array.new
errorY00 = Array.new
errorY10 = Array.new
errorY11 = Array.new
errorY01 = Array.new

n.times do |i|
  
  outputvals00 = network.run([0,0])
  network.train(outputvals00, [0])
  
  outputvals10 = network.run([1,0])
  network.train(outputvals10, [0])
  
  outputvals11 = network.run([1,1])
  network.train(outputvals11, [1])
  
  outputvals01 = network.run([0,1])
  network.train(outputvals01, [0])
  
  if ((i % plot)  == 0) then  
    errorX.push(i)
    errorY00.push(0-outputvals00[0])
    errorY10.push(0-outputvals10[0])
    errorY11.push(1-outputvals11[0])
    errorY01.push(0-outputvals01[0])
  end
   
  if ((i % p)  == 0) then 
    puts " 0,0 = #{outputvals00} %" 
    puts " 1,0 = #{outputvals10} %"
    puts " 1,1 = #{outputvals11} %"
    puts " 0,1 = #{outputvals01} %"
    puts "#{(i.to_f/n.to_f)*100.0} %"
  end 
end

network.toGraphViz

lines = [errorY00, errorY10, errorY11, errorY01]
chart = NeuroChart.new(errorX, lines)
chart.createSVGChart

puts 'Logical AND test'
puts '0 AND 0 = ' + network.run([0,0])[0].to_s
puts '0 AND 1 = ' + network.run([0,1])[0].to_s
puts '1 AND 0 = ' + network.run([1,0])[0].to_s
puts '1 AND 1 = ' + network.run([1,1])[0].to_s
