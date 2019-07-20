module BrainFuck
  class Engine
    class InvalidInputError < RuntimeError; end
    class NullOutputError < RuntimeError; end

    def initialize(input, &output)
      unless input.respond_to?(:get)
        raise ArgumentError, "input must respond to `get`"
      end

      @input = input
      @output = output

      @array = []
      @pointer = 0
    end

    attr_reader :pointer

    def [](index)
      @array[index]
    end

    def current
      @array[@pointer].to_i
    end

    def increment
      @array[@pointer] ||= 0
      @array[@pointer] += 1
    end
    def decrement
      @array[@pointer] ||= 0
      @array[@pointer] -= 1
    end

    def shift_right
      @pointer += 1
    end
    def shift_left
      @pointer -= 1
    end

    def get
      value = @input.get

      unless value.is_a?(Integer)
        raise InvalidInputError
      end

      @array[@pointer] = value
    end

    def put
      unless @output
        raise NullOutputError
      end

      @output.call current
    end
  end
end
