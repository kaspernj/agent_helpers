require "spec_helper"

describe AgentHelpers::Detector do
  it "detects chrome" do
    detector = Detector.new(:user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1944.0 Safari/537.36")
    detector.browser.should eq :chrome
    detector.version.should eq 36
  end
end
