
require_relative '../computer'

INPUT = File.open('input1.txt', 'r').read.split(",")
INPUT[0] = '2'

# 0 EMPTY
# 1 wall
# 2 block
# 3 horizontal paddle
# 4 ball

# x 44
# y 22
require 'set'

class Game
  attr_accessor :map, :programme, :ball_position
  def initialize(programme)
    @map = Array.new(23).map { Array.new(45, ' ')}
    @programme = programme
    @outputs = []
    @current_score = 0
    @ball_position = nil
    @bricks = Set.new
    @paddle_position = nil
  end

  def step
    @outputs << 3.times.map { @programme.run(paddle_direction) }
    update_map
    sleep(0.001)
  end

  def update_map
    slice = @outputs.last

    if slice[0] == -1
      @current_score = slice.last
    else
      case slice[2]
      when 0
        @map[slice[1]][slice[0]] = ' '
      when 1
        @map[slice[1]][slice[0]] = '|'
      when 2
        @map[slice[1]][slice[0]] = '#'
        @bricks << [slice[0], slice[1]]
      when 3
        @map[slice[1]][slice[0]] = '-'
        @paddle_position = [slice[0], slice[1]]
      when 4
        # Replace last ball position
        #@map[@ball_position[1]][@ball_position[0]] = ' ' if @ball_position
        @map[slice[1]][slice[0]] = 'o'
        # Save the new one

        @last_ball_position = @ball_position
        self.ball_position = [slice[0], slice[1]]
      end
    end

    system("clear")
    puts "\n"
    puts "Score: #{@current_score}"
    @map.each { |r| puts r.join }
  end

  def paddle_direction
    return 0 unless @last_ball_position
    next_ball = @ball_position.dup
    next_ball[0] +=  @last_ball_position[0] < @ball_position[0] ? 1 : -1
    next_ball[1] +=  @last_ball_position[1] < @ball_position[1] ? 1 : -1
    if next_ball[1] < @paddle_position[1]
      next_ball[0] -=  @last_ball_position[0] < @ball_position[0] ? 1 : -1
    end


    if next_ball[1] == @paddle_position[1] && next_ball[0] == @paddle_position[0]
      0
    elsif next_ball[0] < @paddle_position[0]
      -1
    elsif next_ball[0] > @paddle_position[0]
      1
    else
      0
    end
  end
end



computer = Computer.new(INPUT)
game = Game.new(computer)

while !game.programme.completed
  game.step
end

# 15973






