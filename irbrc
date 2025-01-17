require 'irb/completion'
#require 'irb/ext/save-history'

ARGV.concat [ "--readline",
              "--prompt-mode",
              "simple" ]

if IRB.singleton_methods.include?(:conf)
  IRB.conf[:PROMPT_MODE] = :SIMPLE
  IRB.conf[:AUTO_INDENT] = true
  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
end

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end


# load File.dirname(__FILE__) + '/.railsrc' if ($0 == 'irb' && ENV['RAILS_ENV']) || ($0 == 'script/rails' && Rails.env)
