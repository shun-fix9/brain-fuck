require "minitest/autorun"

require "brain_fuck/input"

module BrainFuck
  class InputTest < Minitest::Test
    def test_null_input
      assert_raises(Input::EOFError) do
        Input::Null.new.get
      end
    end

    def test_stream_input
      input = Input::StringStream.new(StringIO.new("abcde"))

      assert_equal("a".ord, input.get)
      assert_equal("b".ord, input.get)
      assert_equal("c".ord, input.get)
      assert_equal("d".ord, input.get)
      assert_equal("e".ord, input.get)

      assert_raises(Input::EOFError) do
        input.get
      end
    end
  end
end
