module BrainFuck
  module Instruction
    class Increment
      def process!(engine)
        engine.increment
      end
      def to_s
        "+"
      end
    end

    class Decrement
      def process!(engine)
        engine.decrement
      end
      def to_s
        "-"
      end
    end

    class Shift
      def process!(engine)
        engine.shift
      end
      def to_s
        ">"
      end
    end

    class Unshift
      def process!(engine)
        engine.unshift
      end
      def to_s
        "<"
      end
    end

    class GetChar
      def process!(engine)
        engine.get_char
      end
      def to_s
        ","
      end
    end

    class PutChar
      def process!(engine)
        engine.put_char
      end
      def to_s
        "."
      end
    end

    class Group
      def initialize(instructions=[])
        @instructions = instructions
      end
      def push(instruction)
        @instructions.push instruction
      end

      def process!(engine)
        while engine.current > 0
          @instructions.each do |instruction|
            instruction.process!(engine)
          end
        end
      end
      def to_s
        "[#{@instructions.map(&:to_s).join("")}]"
      end
    end
  end
end
