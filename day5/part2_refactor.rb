
class Computer
  attr_accessor :input, :output, :memory_index

  def initialize(programme)
    @programme = programme
    @output = []
  end

  def run
    @memory_index = 0
    @input = 5

    while @programme[memory_index] != '99'
      opcode = @programme[memory_index]
      opcode, modes = split_opcode_instruction(opcode.dup)
      number_of_params = 0
      case opcode
      when '1'
        number_of_params = 4
        @programme[@programme[memory_index + 3].to_i] =
          (fetch_values(modes[-1], @programme[memory_index + 1]).to_i + fetch_values(modes[-2], @programme[memory_index + 2])).to_s
      when '2'
        number_of_params = 4
        @programme[@programme[memory_index + 3].to_i] =
          (fetch_values(modes[-1], @programme[memory_index + 1]).to_i * fetch_values(modes[-2], @programme[memory_index + 2])).to_s
      when '3'
        number_of_params = 2
        @programme[@programme[memory_index + 1].to_i] = @input
      when '4'
        number_of_params = 2
        output << @programme[@programme[memory_index + 1].to_i]
      when '5'
        if fetch_values(modes[-1], @programme[memory_index + 1]) != 0
          @memory_index = fetch_values(modes[-2], @programme[memory_index + 2])
        else
          number_of_params = 3
        end
      when '6'
        if fetch_values(modes[-1], @programme[memory_index + 1]).to_i == 0
          @memory_index = fetch_values(modes[-2], @programme[memory_index + 2])
        else
          number_of_params = 3
        end
      when '7'
        number_of_params = 4
        if fetch_values(modes[-1], @programme[memory_index + 1]).to_i < fetch_values(modes[-2], @programme[memory_index + 2]).to_i
          @programme[@programme[memory_index + 3].to_i] = '1'
        else
          @programme[@programme[memory_index + 3].to_i] = '0'
        end
      when '8'
        number_of_params = 4
        if fetch_values(modes[-1], @programme[memory_index + 1]).to_i == fetch_values(modes[-2], @programme[memory_index + 2]).to_i
          @programme[@programme[memory_index + 3].to_i] = '1'
        else
          @programme[@programme[memory_index + 3].to_i] = '0'
        end
      else
        raise "Bad opcode #{opcode}"
      end

      @memory_index += number_of_params
    end
  end

  def split_opcode_instruction(opcode)
    modes = []
    if opcode.size == 1
      operator = opcode
    else
      operator = opcode.slice!(-2, 2)
      operator = operator[-1]
      modes = opcode.chars
    end
    [operator, modes]
  end

  def fetch_values(mode, params)
    if mode == '0' || mode.nil?
      @programme[params.to_i].to_i
    elsif mode == '1'
      params.to_i
    else
      raise "Bad mode #{mode}"
    end
  end
end


OPCODE = '3,225,1,225,6,6,1100,1,238,225,104,0,1102,35,92,225,1101,25,55,225,1102,47,36,225,1102,17,35,225,1,165,18,224,1001,224,-106,224,4,224,102,8,223,223,1001,224,3,224,1,223,224,223,1101,68,23,224,101,-91,224,224,4,224,102,8,223,223,101,1,224,224,1,223,224,223,2,217,13,224,1001,224,-1890,224,4,224,102,8,223,223,1001,224,6,224,1,224,223,223,1102,69,77,224,1001,224,-5313,224,4,224,1002,223,8,223,101,2,224,224,1,224,223,223,102,50,22,224,101,-1800,224,224,4,224,1002,223,8,223,1001,224,5,224,1,224,223,223,1102,89,32,225,1001,26,60,224,1001,224,-95,224,4,224,102,8,223,223,101,2,224,224,1,223,224,223,1102,51,79,225,1102,65,30,225,1002,170,86,224,101,-2580,224,224,4,224,102,8,223,223,1001,224,6,224,1,223,224,223,101,39,139,224,1001,224,-128,224,4,224,102,8,223,223,101,3,224,224,1,223,224,223,1102,54,93,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,1008,677,677,224,1002,223,2,223,1005,224,329,101,1,223,223,7,677,677,224,102,2,223,223,1006,224,344,101,1,223,223,108,677,677,224,1002,223,2,223,1006,224,359,1001,223,1,223,7,677,226,224,1002,223,2,223,1005,224,374,1001,223,1,223,1107,677,226,224,1002,223,2,223,1005,224,389,1001,223,1,223,107,226,677,224,102,2,223,223,1005,224,404,1001,223,1,223,1108,226,677,224,1002,223,2,223,1006,224,419,101,1,223,223,107,226,226,224,102,2,223,223,1005,224,434,1001,223,1,223,108,677,226,224,1002,223,2,223,1006,224,449,101,1,223,223,108,226,226,224,102,2,223,223,1006,224,464,1001,223,1,223,1007,226,226,224,1002,223,2,223,1005,224,479,101,1,223,223,8,677,226,224,1002,223,2,223,1006,224,494,101,1,223,223,1007,226,677,224,102,2,223,223,1006,224,509,101,1,223,223,7,226,677,224,1002,223,2,223,1005,224,524,101,1,223,223,107,677,677,224,102,2,223,223,1005,224,539,101,1,223,223,1008,677,226,224,1002,223,2,223,1005,224,554,1001,223,1,223,1008,226,226,224,1002,223,2,223,1006,224,569,1001,223,1,223,1108,226,226,224,102,2,223,223,1005,224,584,101,1,223,223,1107,226,677,224,1002,223,2,223,1005,224,599,1001,223,1,223,8,226,677,224,1002,223,2,223,1006,224,614,1001,223,1,223,1108,677,226,224,102,2,223,223,1005,224,629,1001,223,1,223,8,226,226,224,1002,223,2,223,1005,224,644,1001,223,1,223,1107,677,677,224,1002,223,2,223,1005,224,659,1001,223,1,223,1007,677,677,224,1002,223,2,223,1005,224,674,101,1,223,223,4,223,99,226'.split(',')
#OPCODE = "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9".split(',')
computer = Computer.new(OPCODE.dup)
computer.run
p computer.output # 9217546




