module BrainFuck
  module Instruction
    class << self
      def increment
        @increment ||= Increment.new
      end
      def decrement
        @decrement ||= Decrement.new
      end
      def shift_right
        @shift ||= ShiftRight.new
      end
      def shift_left
        @shift_left ||= ShiftLeft.new
      end
      def get
        @get ||= Get.new
      end
      def put
        @put ||= Put.new
      end
      def group(instructions=[])
        Group.new(instructions)
      end
    end

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

    class ShiftRight
      def process!(engine)
        engine.shift_right
      end
      def to_s
        ">"
      end
    end

    class ShiftLeft
      def process!(engine)
        engine.shift_left
      end
      def to_s
        "<"
      end
    end

    class Get
      def process!(engine)
        engine.get
      end
      def to_s
        ","
      end
    end

    class Put
      def process!(engine)
        engine.put
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
