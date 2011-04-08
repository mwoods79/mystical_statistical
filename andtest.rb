require "network"

network = Network.new(2,1,2)
n = 1000000
p = n / 10
n.times do |i|
  outputvals = network.run([0,0])
  network.train(outputvals, [0])
  outputvals = network.run([1,0])
  network.train(outputvals, [0])
  outputvals = network.run([1,1])
  network.train(outputvals, [1])
  outputvals = network.run([0,1])
  network.train(outputvals, [0])
  if ((i % p)  == 0) then puts "#{(i.to_f/n.to_f)*100.0} %" end
end

puts 'Logical AND test'
puts '0 AND 0 = ' + network.run([0,0])[0].to_s
puts '0 AND 1 = ' + network.run([0,1])[0].to_s
puts '1 AND 0 = ' + network.run([1,0])[0].to_s
puts '1 AND 1 = ' + network.run([1,1])[0].to_s