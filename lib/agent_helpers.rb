require "agent_helpers/engine"
require "string-cases"

module AgentHelpers
  # Solves issue when bundled as a dep the helpers wont get loaded. So don't remove this autoloader...
  path = File.realpath(File.dirname(__FILE__) + "/../")
  autoload :DetectorHelper, "#{path}/app/helpers/agent_helpers/detector_helper"

  def self.const_missing(name)
    filepath = "#{File.dirname(__FILE__)}/agent_helpers/#{::StringCases.camel_to_snake(name)}.rb"

    if File.exists?(filepath)
      require filepath
      raise LoadError, "Still not defined: #{name}" unless ::AgentHelpers.const_defined?(name)
      return ::AgentHelpers.const_get(name)
    end

    super
  end
end
