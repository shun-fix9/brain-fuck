require "brain_fuck"

source = "
  +++++++++[->++++++++>+++++++++++>+++++<<<]>.>++.+++++++..+++.>-.---------
  ---.<++++++++.--------.+++.------.--------.>+.
"
instructions = BrainFuck::Compiler::Standard.new.compile!(source)

input = BrainFuck::Input::Null.new
#input = BrainFuck::Input::StringStream.new($stdin)
engine = BrainFuck::Engine.new(input) do |output|
  $stdout.print "#{output.chr}"
end

instructions.each do |instruction|
  instruction.process!(engine)
end

$stdout.puts ""
