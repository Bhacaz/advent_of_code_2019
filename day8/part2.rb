
data = File.open('data.txt', 'r').read.chars

image = []

data.each_slice(25*6) do |slice|
  row_data = []
  slice.each_slice(25) do |row|
    row_data << row
  end
  image << row_data
end


# BLACK = 0
# WHITE = 1
# TRANS = 2
require 'chunky_png'

png = ChunkyPNG::Image.new(25, 6, ChunkyPNG::Color::TRANSPARENT)
p image
(0..5).each do |y|
  (0..24).each do |x|
    image.each do |layer|
      pixel = layer[y][x]
      if pixel != '2'
        p pixel
        png[x, y] = ChunkyPNG::Color('black') if pixel == '0'
        png[x, y] = ChunkyPNG::Color('white') if pixel == '1'
        break
      end
    end
  end
end

png.save('filename.png', :interlace => true)

