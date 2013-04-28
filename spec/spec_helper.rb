require 'simplecov'
require 'yaml'

SimpleCov.start do
  add_filter {|sf| sf.filename !~ /\/lib\//}
end

require 'whitepages_pro'

# Require the debugger, if present.
begin
  require 'debugger'
rescue LoadError
  module Kernel
    def debugger(*args, &block)
      STDERR.puts "*** Debugger not available."
    end
  end
end

class APIKey
  def APIKey.get_api_key
    YAML.load_file('apikey.yml')["whitepages_api_key"]
  end
end
