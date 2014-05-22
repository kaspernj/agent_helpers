Rails.application.routes.draw do

  mount AgentHelpers::Engine => "/agent_helpers"
end
