module BrainFuck
  module Input
    class EOFError < RuntimeError; end

    class Null
      def getc
        raise EOFError
      end
    end

    class Stream
      def initialize(stream)
        if stream.respond_to?(:getc) and stream.respond_to?(:eof?)
          @stream = stream
        else
          raise ArgumentError, "arg must respond_to getc and eof?"
        end
      end

      def getc
        if @stream.eof?
          raise EOFError
        end

        @stream.getc
      end
    end
  end
end
