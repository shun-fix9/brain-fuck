require "minitest/autorun"

require "brain_fuck/input"

module BrainFuck
  class InputTest < Minitest::Test
    def test_null_input
      assert_raises(Input::EOFError) do
        Input::Null.new.getc
      end
    end

    def test_stream_input
      input = Input::Stream.new(StringIO.new("abcde"))

      assert_equal("a", input.getc)
      assert_equal("b", input.getc)
      assert_equal("c", input.getc)
      assert_equal("d", input.getc)
      assert_equal("e", input.getc)

      assert_raises(Input::EOFError) do
        input.getc
      end
    end
  end
end
