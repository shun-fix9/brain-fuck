require "minitest/autorun"

require "brain_fuck/engine"
require "brain_fuck/input"

module BrainFuck
  class EngineTest < Minitest::Test
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
      engine.increment

      assert_equal(1, engine.array[0])
    end

    def test_decrement
      engine = null_engine
      engine.decrement

      assert_equal(-1, engine.array[0])
    end

    def test_shift
      engine = null_engine
      engine.shift
      engine.increment

      assert_equal(1, engine.array[1])
    end

    def test_unshift
      engine = null_engine
      engine.shift
      engine.shift
      engine.unshift
      engine.increment

      assert_equal(1, engine.array[1])
    end

    def test_get_char
      engine = input_engine("A")
      engine.get_char

      assert_equal("A".ord, engine.array[0])
    end

    def test_put_char
      outputs = []
      engine = output_engine{|output|
        outputs.push output
      }
      "A".ord.times do
        engine.increment
      end

      engine.put_char

      assert_equal(["A".ord], outputs)
    end
  end
end
