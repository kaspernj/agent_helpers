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
    helper.agent_version_major.should eq 36
    helper.agent_version.should eq "36.0.1944.0"
    helper.agent_human?.should eq true
  end

  it "should detect iphone" do
    @request.user_agent = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_0 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7A341 Safari/528.16"
    helper.agent_mobile?.should eq true
    helper.agent_device.should eq :iphone
    helper.agent_browser.should eq :safari
    helper.agent_safari?.should eq true
    helper.agent_human?.should eq true
    helper.agent_version.should eq "528.16"
  end

  it "should detect ipad" do
    @request.user_agent = "Mozilla/5.0(iPad; U; CPU iPhone OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B314 Safari/531.21.10"
    helper.agent_mobile?.should eq true
    helper.agent_device.should eq :ipad
    helper.agent_browser.should eq :safari
    helper.agent_safari?.should eq true
    helper.agent_human?.should eq true
    helper.agent_version.should eq "531.21.10"
  end

  it "should detect android" do
    @request.user_agent = "Mozilla/5.0 (Linux; U; Android 2.2; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"
    helper.agent_mobile?.should eq true
    helper.agent_os.should eq :android
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

  it "should detect windows" do
    @request.user_agent = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; WOW64; Trident/4.0; SLCC2; Media Center PC 6.0; InfoPath.2; MS-RTC LM 8)"
    helper.agent_os.should eq :windows
    helper.agent_os_title.should eq "Windows XP"
    helper.agent_os_version.should eq "NT 5.1"
    helper.agent_windows?.should eq true
    helper.agent_linux?.should eq false
  end

  it "should detect linux" do
    @request.user_agent = "Mozilla/5.0 (X11; Linux x86_64; rv:28.0) Gecko/20100101 Firefox/28.0"
    helper.agent_os.should eq :linux
    helper.agent_os_title.should eq "Linux"
    helper.agent_linux?.should eq true
    helper.agent_windows?.should eq false
  end

  it "should detect osx" do
    @request.user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/537.13+ (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2"
    helper.agent_os.should eq :osx
    helper.agent_os_title.should eq "Mac OSX Snow Leopard"
    helper.agent_os_version.should eq "10.6.8"
    helper.agent_osx?.should eq true
    helper.agent_windows?.should eq false
  end
end
