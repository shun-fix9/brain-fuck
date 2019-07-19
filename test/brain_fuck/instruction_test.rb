require "minitest/autorun"

require "brain_fuck/engine"
require "brain_fuck/instruction"

module BrainFuck
  class InstructionTest < Minitest::Test
    def null_engine
      Engine.new(Input::Null.new){|output| nil}
    end
    def input_engine(str)
      Engine.new(Input::Stream.new(StringIO.new(str))){|output| nil}
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

    def test_shift
      engine = null_engine
      Instruction::Shift.new.process!(engine)
      Instruction::Increment.new.process!(engine)

      assert_equal(1, engine.array[1])
    end

    def test_unshift
      engine = null_engine
      Instruction::Shift.new.process!(engine)
      Instruction::Shift.new.process!(engine)
      Instruction::Unshift.new.process!(engine)
      Instruction::Increment.new.process!(engine)

      assert_equal(1, engine.array[1])
    end

    def test_get_char
      engine = input_engine("A")
      Instruction::GetChar.new.process!(engine)

      assert_equal("A".ord, engine.array[0])
    end

    def test_put_char
      outputs = []
      engine = output_engine{|output|
        outputs.push output
      }
      "A".ord.times do
        Instruction::Increment.new.process!(engine)
      end

      Instruction::PutChar.new.process!(engine)

      assert_equal(["A".ord], outputs)
    end

    def test_group
      engine = null_engine
      [
        Instruction::Increment.new,
        Instruction::Increment.new,
        Instruction::Group.new([
          Instruction::Shift.new,
          Instruction::Increment.new,
          Instruction::Increment.new,
          Instruction::Increment.new,
          Instruction::Unshift.new,
          Instruction::Decrement.new,
        ])
      ].each do |instruction|
        instruction.process!(engine)
      end

      assert_equal(6, engine.array[1])
    end
  end
end
