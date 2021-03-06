module BrainFuck
  module Compiler
    class GroupUnmatchError < RuntimeError; end

    class Standard
      def initialize
        @instructions = []
        @groups = []
      end

      def clear
        @instructions.clear
        @groups.clear
      end

      def current_depth
        @groups.length
      end
      def group_proccessing?
        current_depth > 0
      end

      def compile(source)
        source.each_char.each{|char|
          parse(char)
        }
        nil
      end

      def compile!(source)
        compile(source)
        to_instructions!
      end

      def to_instructions!
        if group_proccessing?
          raise GroupUnmatchError, "too many group beginnings"
        end

        instructions = @instructions.dup
        clear

        instructions
      end

      private

        def parse(char)
          case char
          when "+" then instruction = Instruction.increment
          when "-" then instruction = Instruction.decrement
          when ">" then instruction = Instruction.shift_right
          when "<" then instruction = Instruction.shift_left
          when "," then instruction = Instruction.get
          when "." then instruction = Instruction.put
          when "[" then instruction = Instruction.group; is_group_start = true
          when "]"
            unless group_proccessing?
              raise GroupUnmatchError, "to many group endings"
            end

            @groups.pop
          end

          if instruction
            if group_proccessing?
              @groups.last.push instruction
            else
              @instructions.push instruction
            end
          end

          if is_group_start
            @groups.push instruction
          end
        end
    end
  end
end
