
class Computer
  attr_accessor :input, :output, :memory_index, :programme

  def initialize(programme)
    @programme = programme
    @output = []
    @memory_index = 0
  end

  def run(input = 0)
    @relative_base_offset = 0
    @input = input

    while @programme[memory_index] != '99'
      opcode = @programme[memory_index]
      @opcode, @modes = split_opcode_instruction(opcode.dup)
      number_of_params = 0

      case @opcode
      when '1'
        number_of_params = 4
        set(3, (value(1) + value(2)).to_s)
      when '2'
        number_of_params = 4
        set(3, (value(1) * value(2)).to_s)
      when '3'
        number_of_params = 2
        set(1, @input)
      when '4'
        number_of_params = 2
        output << value(1)
        @memory_index += number_of_params
        return output.last
      when '5'
        if value(1) != 0
          @memory_index = value(2)
        else
          number_of_params = 3
        end
      when '6'
        if value(1) == 0
          @memory_index = value(2)
        else
          number_of_params = 3
        end
      when '7'
        number_of_params = 4
        set(3, value(1) < value(2) ? '1' : '0')
      when '8'
        number_of_params = 4
        set(3, value(1) == value(2) ? '1' : '0')
      when '9'
        number_of_params = 2
        @relative_base_offset += value(1)
      else
        raise "Bad opcode #{@opcode}"
      end

      @memory_index += number_of_params
    end
  end

  def set(index, value)
    #@programme[value(index)].to_i
    mode = @modes[-index]
    params = @programme[memory_index + index]

    if mode == '0' || mode.nil?
      @programme[params.to_i] = value
    elsif mode == '2'
      @programme[params.to_i + @relative_base_offset] = value
    else
      raise "Bad set mode #{mode}"
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

  def value(index)
    fetch_values(@modes[-index], @programme[memory_index + index]).to_i
  end

  def fetch_values(mode, params)
    if mode == '0' || mode.nil?
      @programme[params.to_i].to_i
    elsif mode == '1'
      params.to_i
    elsif mode == '2'
      @programme[params.to_i + @relative_base_offset].to_i
    else
      raise "Bad mode #{mode}"
    end
  end
end

permutation = (5..9).to_a.permutation


#OPCODE = '3,225,1,225,6,6,1100,1,238,225,104,0,1102,35,92,225,1101,25,55,225,1102,47,36,225,1102,17,35,225,1,165,18,224,1001,224,-106,224,4,224,102,8,223,223,1001,224,3,224,1,223,224,223,1101,68,23,224,101,-91,224,224,4,224,102,8,223,223,101,1,224,224,1,223,224,223,2,217,13,224,1001,224,-1890,224,4,224,102,8,223,223,1001,224,6,224,1,224,223,223,1102,69,77,224,1001,224,-5313,224,4,224,1002,223,8,223,101,2,224,224,1,224,223,223,102,50,22,224,101,-1800,224,224,4,224,1002,223,8,223,1001,224,5,224,1,224,223,223,1102,89,32,225,1001,26,60,224,1001,224,-95,224,4,224,102,8,223,223,101,2,224,224,1,223,224,223,1102,51,79,225,1102,65,30,225,1002,170,86,224,101,-2580,224,224,4,224,102,8,223,223,1001,224,6,224,1,223,224,223,101,39,139,224,1001,224,-128,224,4,224,102,8,223,223,101,3,224,224,1,223,224,223,1102,54,93,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,1008,677,677,224,1002,223,2,223,1005,224,329,101,1,223,223,7,677,677,224,102,2,223,223,1006,224,344,101,1,223,223,108,677,677,224,1002,223,2,223,1006,224,359,1001,223,1,223,7,677,226,224,1002,223,2,223,1005,224,374,1001,223,1,223,1107,677,226,224,1002,223,2,223,1005,224,389,1001,223,1,223,107,226,677,224,102,2,223,223,1005,224,404,1001,223,1,223,1108,226,677,224,1002,223,2,223,1006,224,419,101,1,223,223,107,226,226,224,102,2,223,223,1005,224,434,1001,223,1,223,108,677,226,224,1002,223,2,223,1006,224,449,101,1,223,223,108,226,226,224,102,2,223,223,1006,224,464,1001,223,1,223,1007,226,226,224,1002,223,2,223,1005,224,479,101,1,223,223,8,677,226,224,1002,223,2,223,1006,224,494,101,1,223,223,1007,226,677,224,102,2,223,223,1006,224,509,101,1,223,223,7,226,677,224,1002,223,2,223,1005,224,524,101,1,223,223,107,677,677,224,102,2,223,223,1005,224,539,101,1,223,223,1008,677,226,224,1002,223,2,223,1005,224,554,1001,223,1,223,1008,226,226,224,1002,223,2,223,1006,224,569,1001,223,1,223,1108,226,226,224,102,2,223,223,1005,224,584,101,1,223,223,1107,226,677,224,1002,223,2,223,1005,224,599,1001,223,1,223,8,226,677,224,1002,223,2,223,1006,224,614,1001,223,1,223,1108,677,226,224,102,2,223,223,1005,224,629,1001,223,1,223,8,226,226,224,1002,223,2,223,1005,224,644,1001,223,1,223,1107,677,677,224,1002,223,2,223,1005,224,659,1001,223,1,223,1007,677,677,224,1002,223,2,223,1005,224,674,101,1,223,223,4,223,99,226'.split(',')
OPCODE = "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5".split(',').freeze
outputs = []
permutation.each do |phase_settings|
  computers = Array.new(5).map { { c: Computer.new(OPCODE.dup), initiated: false, finish: false } }
  output = 0
  while !computers.last[:finish]
    phase_settings.each_with_index do |phase_setting, index|
      input =
        if computers[index][:initiated]
          output
        else
          computers[index][:initiated] = true
          phase_setting
        end
      if OPCODE[computers[index][:c].memory_index] == '99'
        computers[index][:finish] = true
      else
        output = computers[index][:c].run(input)
        outputs << output
      end
    end
  end
end
p outputs
puts outputs.compact.max



