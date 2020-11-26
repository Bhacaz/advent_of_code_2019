
class Computer
  attr_accessor :input, :output, :memory_index

  def initialize(programme)
    @programme = programme
    @output = []
    @memory_index = 0
    @relative_base_offset = 0

    def @programme.[](index)
      #p index if index < 0
      self[index] = '0' unless self.at(index)
      super
    end
  end

  def completed
    @programme[memory_index] == '99'
  end

  def run(input = 0)
    @input = input

    while !completed
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
    mode = @modes[-index]
    params = @programme[memory_index + index].to_i

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
