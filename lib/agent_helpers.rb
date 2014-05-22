require "agent_helpers/engine"
require "string-cases"

module AgentHelpers
  def self.const_missing(name)
    require_relative "agent_helpers/#{::StringCases.camel_to_snake(name)}"
    raise LoadError, "Still not defined: #{name}" unless ::AgentHelpers.const_defined?(name)
    return ::AgentHelpers.const_get(name)
  end
end
