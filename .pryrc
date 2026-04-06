if defined?(PryDebugger) || defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'

  # Hit Enter to repeat last command
  Pry::Commands.command /^$/, "repeat last command" do
    _pry_.run_command Pry.history.to_a.last
  end

  # Pry.config.history.file = "~/.irb-history"
  # Pry.config.history.should_save = true
end

module AwesomePrint
  class Formatter

    private

    def awesome_self(object, type)
      if @options[:raw] && object.instance_variables.any?
        awesome_object(object)
      elsif object.respond_to?(:to_hash)
        awesome_hash(object.to_hash)
      else
        colorize(object.inspect.to_s, type)
      end
    end
  end
end
