# AgentHelpers

Detect if the client is a bot, which bot and which version. Also tells if it is a human, which browser, version and much more in Rails.

## Installation

First bundle it in your Gemfile:
```ruby
gem 'agent_helpers'
```

Run `bundle install`.

Include it in your `ApplicationHelper`:
```ruby
module ApplicationHelper
  include AgentHelpers::DetectorHelper
end
```

## Usage

In a view:
```erb
<% if agent_robot? %>
  You are a robot.
<% elsif agent_human? %>
  Welcome human!
<% end %>
```

In a controller:
```ruby
if view_context.agent_robot?
  redirect_to not_allowed_path
end
```

## List of helpers

- agent_robot?
- agent_human?
- agent_browser
- agent_title
- agent_version
- agent_device
- agent_chrome?
- agent_firefox?
- agent_ie?
- agent_safari?
- agent_opera?
- agent_mobile?
