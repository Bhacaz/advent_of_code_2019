

class Moon
  attr_accessor :velocity, :position

  def initialize(position)
    @position = position
    @velocity = [0 ,0, 0]
  end

  def apply_velocity
    velocity.each_with_index do |v, index|
      position[index] += v
    end
  end

  def total_energy
    position.map(&:abs).sum * velocity.map(&:abs).sum
  end

  def to_s
    "pos=<x=#{position[0]}, y=#{position[1]}, z=#{position[2]}>, vel=<x=#{velocity[0]}, y=#{velocity[1]}, z=#{velocity[2]}>"
  end

  def self.parse_moon(input)
    input[0] = ''
    input[-1] = ''
    input.delete!(' ')
    position = []
    input.split(',').each do |i|
      position << i.split('=').last.to_i
    end
    Moon.new(position)
  end

  def self.apply_gravity(moon1, moon2)
    moon1.position.zip(moon2.position).each_with_index do |(p1, p2), index|
      if p1 > p2
        moon1.velocity[index] -= 1
        moon2.velocity[index] += 1
      elsif p1 < p2
        moon1.velocity[index] += 1
        moon2.velocity[index] -= 1
      end
    end
  end
end


INPUT = '<x=17, y=5, z=1>
<x=-2, y=-8, z=8>
<x=7, y=-6, z=14>
<x=1, y=-10, z=4>'.split("\n")

moons = INPUT.map { |i| Moon.parse_moon(i) }
puts moons
puts ''

(1..1000).each do |step|
  puts "#{step} steps"
  moons.combination(2) do |moon1, moon2|
    Moon.apply_gravity(moon1, moon2)
  end
  moons.each(&:apply_velocity)

  puts moons
end

p moons.map(&:total_energy).sum # 9876

