[![Code Climate](https://codeclimate.com/github/kaspernj/agent_helpers.png)](https://codeclimate.com/github/kaspernj/agent_helpers)

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

```ruby
agent_robot? #=> true, false
agent_human? #=> true, false
agent_browser #=> :ie, :firefox, :chrome, :ie, :opera etc.
agent_title #=> "Firefox", "Chrome", "Opera" etc.
agent_version #=> "23.0" etc.
agent_device #=> :iphone, :ipad, :android etc.
agent_chrome? #=> true, false
agent_firefox? #=> true, false
agent_ie? #=> true, false, maybe it crashes?
agent_safari? #=> true, false
agent_opera? #=> true, false
agent_mobile? #=> true, false
```
