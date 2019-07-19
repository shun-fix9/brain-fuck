module BrainFuck
  module Compiler
    class Base
      def initialize
        @instructions = []
        @groups = []
      end

      def compile!(source)
        compile(source)
        flatten!
      end

      private

        def flatten!
          if @groups.length > 0
            raise GroupUnmatchError, "there is no end of group"
          end

          @instructions
        end
    end

    class Standard < Base
      class GroupUnmatchError < RuntimeError; end

      def compile(source)
        source.each_char.each{|char|
          parse(char)
        }
        nil
      end

      private

        def parse(char)
          case char
          when "+" then instruction = Instruction::Increment.new
          when "-" then instruction = Instruction::Decrement.new
          when ">" then instruction = Instruction::Shift.new
          when "<" then instruction = Instruction::Unshift.new
          when "," then instruction = Instruction::GetChar.new
          when "." then instruction = Instruction::PutChar.new
          when "[" then instruction = Instruction::Group.new; is_group = true
          when "]"
            if @groups.length > 0
              @groups.pop
            else
              raise GroupUnmatchError, "] is not matched"
            end
          end

          if instruction
            if @groups.length > 0
              @groups.last.push instruction
            else
              @instructions.push instruction
            end
          end

          if is_group
            @groups.push instruction
          end
        end
    end
  end
end
