$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "agent_helpers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "agent_helpers"
  s.version     = AgentHelpers::VERSION
  s.authors     = ["Kasper Johansen"]
  s.email       = ["k@spernj.org"]
  s.homepage    = "https://www.github.com/kaspernj/agent_helpers"
  s.summary     = "Easily detect robots, browser, versions and more with convenient helpers."
  s.description = "Inspects the user agent for you and allows you to take action based on the users browser, if it is a detectable bot with one-line-helpers."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "string-cases"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "forgery"
  s.add_development_dependency "factory_girl_rails"
end
