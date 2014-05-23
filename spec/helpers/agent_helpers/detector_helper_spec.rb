require 'spec_helper'

describe AgentHelpers::DetectorHelper do
  it "works for bots" do
    @request.user_agent = "baiduspider"
    helper.agent_robot?.should eq true
  end
  
  it "works for humans" do
    @request.user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1944.0 Safari/537.36"
    helper.agent_human?.should eq true
    helper.agent_robot?.should eq false
  end
  
  it "should detect chrome" do
    @request.user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1944.0 Safari/537.36"
    helper.agent_browser.should eq :chrome
    helper.agent_chrome?.should eq true
    helper.agent_human?.should eq true
  end
  
  it "should detect iphone" do
    @request.user_agent = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_0 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7A341 Safari/528.16"
    helper.agent_mobile?.should eq true
    helper.agent_device.should eq :iphone
    helper.agent_browser.should eq :safari
    helper.agent_safari?.should eq true
    helper.agent_human?.should eq true
  end
  
  it "should detect ipad" do
    @request.user_agent = "Mozilla/5.0(iPad; U; CPU iPhone OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B314 Safari/531.21.10"
    helper.agent_mobile?.should eq true
    helper.agent_device.should eq :ipad
    helper.agent_browser.should eq :safari
    helper.agent_safari?.should eq true
    helper.agent_human?.should eq true
  end
  
  it "should detect android" do
    @request.user_agent = "Mozilla/5.0 (Linux; U; Android 2.2; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"
    helper.agent_mobile?.should eq true
    helper.agent_device.should eq :android
    helper.agent_human?.should eq true
  end
  
  it "should detect googlebot" do
    @request.user_agent = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
    helper.agent_robot?.should eq true
    helper.agent_human?.should eq false
    helper.agent_browser.should eq :bot
    helper.agent_title.should eq "Googlebot"
    helper.agent_version.should eq "2.1"
  end
end
