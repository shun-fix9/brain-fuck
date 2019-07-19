module BrainFuck
  class Engine
    def initialize(input, &output)
      @input = input
      @output = output

      @array = []
      @pointer = 0
    end

    attr_reader :array, :pointer

    def increment
      @array[@pointer] ||= 0
      @array[@pointer] += 1
    end
    def decrement
      @array[@pointer] ||= 0
      @array[@pointer] -= 1
    end

    def shift
      @pointer += 1
    end
    def unshift
      @pointer -= 1
    end

    def get_char
      @array[@pointer] = @input.getc.ord
    end
    def put_char
      @output.call @array[@pointer]
    end

    def current
      @array[@pointer].to_i
    end
  end
end
