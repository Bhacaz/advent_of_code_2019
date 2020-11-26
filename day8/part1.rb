
data = File.open('data.txt', 'r').read.chars

image = []

data.each_slice(25*6) do |slice|
  row_data = []
  slice.each_slice(6) do |row|
    row_data << row
  end
  image << row_data
end

min_zero = image.min do |layer, layer2|
  layer.flatten.count('0') <=> layer2.flatten.count('0')
end

p min_zero.flatten.count('1') * min_zero.flatten.count('2')
