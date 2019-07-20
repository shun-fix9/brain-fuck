require "minitest/autorun"

require "brain_fuck/engine"
require "brain_fuck/input"

module BrainFuck
  class EngineTest < Minitest::Test
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
      engine.increment

      assert_equal(1, engine[0])
    end

    def test_decrement
      engine = null_engine
      engine.decrement

      assert_equal(-1, engine[0])
    end

    def test_shift_right
      engine = null_engine
      engine.shift_right
      engine.increment

      assert_equal(1, engine[1])
    end

    def test_shift_left
      engine = null_engine
      engine.shift_right
      engine.shift_right
      engine.shift_left
      engine.increment

      assert_equal(1, engine[1])
    end

    def test_get
      engine = input_engine("A")
      engine.get

      assert_equal("A".ord, engine[0])
    end

    def test_put
      outputs = []
      engine = output_engine{|output|
        outputs.push output
      }
      "A".ord.times do
        engine.increment
      end

      engine.put

      assert_equal(["A".ord], outputs)
    end
  end
end
