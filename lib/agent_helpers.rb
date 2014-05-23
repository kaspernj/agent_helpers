require "agent_helpers/engine"
require "string-cases"

module AgentHelpers
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
