
INPUT = File.open('input2.txt', 'r').read.split("\n").map { |row| row.chars }

LENGTH = INPUT.size - 1
WIDE = INPUT.first.size - 1

#([28, 29])
X = 28
Y = 29

class Asteroid
  attr_accessor :angle, :scale, :x, :y
  def initialize(x, y)
    @x = x
    @y = y
    @angle = ((Math.atan2(y, x) * 180 / Math::PI) + 90) % 360
    @scale = Math.sqrt(y**2 + x**2)
  end

  def to_s
    [x + X, y + Y, @angle, @scale].to_s
  end
end

asterois = []

(0..WIDE).each do |x|
  (0..LENGTH).each do |y|
    if INPUT[y][x] == '#'
      asterois << Asteroid.new(x - X, y - Y)
    end
  end
end


destroyed = []

all_angles = asterois.map(&:angle)
all_angles.uniq!
all_angles.sort!

while asterois.any?
  all_angles.each do |angle|
    selected = asterois.select { |a| a.angle == angle }
    selected = selected.min_by { |a| a.scale }
    destroyed << asterois.delete(selected) if selected
  end
end

p (destroyed[199].x + X) * 100 + (destroyed[199].y + Y)

