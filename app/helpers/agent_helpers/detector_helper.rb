module AgentHelpers::DetectorHelper
  def agent_detector
    if !controller.instance_variable_get(:@agent_helpers_detector)
      controller.instance_variable_set(:@agent_helpers_detector, ::AgentHelpers::Detector.new(:request => request))
    end
    
    return controller.instance_variable_get(:@agent_helpers_detector)
  end
  
  def agent_robot?
    agent_detector.browser == :bot
  end
  
  def agent_human?
    agent_detector.browser != :bot && agent_detector.browser != :unknown
  end
  
  def agent_browser
    agent_detector.browser
  end
  
  def agent_title
    agent_detector.title
  end
  
  def agent_version
    agent_detector.version
  end
  
  def agent_device
    agent_detector.device
  end
  
  def agent_chrome?
    agent_detector.browser == :chrome
  end
  
  def agent_firefox?
    agent_detector.browser == :firefox
  end
  
  def agent_ie?
    agent_detector.browser == :ie
  end
  
  def agent_safari?
    agent_detector.browser == :safari
  end
  
  def agent_opera?
    agent_detector.browser == :opera
  end
  
  def agent_mobile?
    agent_detector.device == :android || agent_detector.device == :ipad || agent_detector.device == :iphone
  end
end
