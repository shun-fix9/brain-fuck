require "minitest/autorun"

require "brain_fuck/engine"
require "brain_fuck/instruction"

module BrainFuck
  class InstructionTest < Minitest::Test
    def null_engine
      Engine.new(Input::Null.new){|output| nil}
    end
    def input_engine(str)
      Engine.new(Input::StringStream.new(StringIO.new(str))){|output| nil}
    end
    def output_engine(&block)
      Engine.new(Input::Null.new, &block)
    end

    def test_increment
      engine = null_engine
      Instruction::Increment.new.process!(engine)

      assert_equal(1, engine.array[0])
    end

    def test_decrement
      engine = null_engine
      Instruction::Decrement.new.process!(engine)

      assert_equal(-1, engine.array[0])
    end

    def test_shift_right
      engine = null_engine
      Instruction::ShiftRight.new.process!(engine)
      Instruction::Increment.new.process!(engine)

      assert_equal(1, engine.array[1])
    end

    def test_shift_left
      engine = null_engine
      Instruction::ShiftRight.new.process!(engine)
      Instruction::ShiftRight.new.process!(engine)
      Instruction::ShiftLeft.new.process!(engine)
      Instruction::Increment.new.process!(engine)

      assert_equal(1, engine.array[1])
    end

    def test_get
      engine = input_engine("A")
      Instruction::Get.new.process!(engine)

      assert_equal("A".ord, engine.array[0])
    end

    def test_put
      outputs = []
      engine = output_engine{|output|
        outputs.push output
      }
      "A".ord.times do
        Instruction::Increment.new.process!(engine)
      end

      Instruction::Put.new.process!(engine)

      assert_equal(["A".ord], outputs)
    end

    def test_group
      engine = null_engine
      [
        Instruction::Increment.new,
        Instruction::Increment.new,
        Instruction::Group.new([
          Instruction::ShiftRight.new,
          Instruction::Increment.new,
          Instruction::Increment.new,
          Instruction::Increment.new,
          Instruction::ShiftLeft.new,
          Instruction::Decrement.new,
        ])
      ].each do |instruction|
        instruction.process!(engine)
      end

      assert_equal(6, engine.array[1])
    end
  end
end
