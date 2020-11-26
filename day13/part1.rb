
require_relative '../computer'

INPUT = File.open('input1.txt', 'r').read.split(",")

computer = Computer.new(INPUT)
outputs = []

while !computer.completed
  outputs << computer.run
end

outputs.pop

count = 0
outputs.each_slice(3) do |slice|
  count += 1 if slice.last == 2
end

p count # 329





