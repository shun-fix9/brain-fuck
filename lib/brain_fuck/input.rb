module BrainFuck
  module Input
    class EOFError < RuntimeError; end

    class Null
      def get
        raise EOFError
      end
    end

    class StringStream
      def initialize(stream)
        if stream.respond_to?(:getc) and stream.respond_to?(:eof?)
          @stream = stream
        else
          raise ArgumentError, "arg must respond_to getc and eof?"
        end
      end

      def get
        if @stream.eof?
          raise EOFError
        end

        @stream.getc.ord
      end
    end
  end
end
