class AgentHelpers::Detector
  attr_reader :browser, :title, :version, :device, :os
  
  def initialize(args)
    @request = args[:request]
    raise "No request was given." unless @request
    @env = @request.env
    @user_agent = @request.user_agent.to_s.downcase.strip
    raise "No user agent was given." if @user_agent.empty?
    
    parse_browsers
    parse_bots unless @browser
    parse_device
  end
  
private
  
  def parse_browsers
    if match = @user_agent.match(/chrome\/(\d+\.\d+)/)
      @browser = :chrome
      @title = "Google Chrome"
      @version = match[1]
    elsif match = @user_agent.match(/firefox\/(\d+\.\d+)/)
      @browser = :firefox
      @title = "Mozilla Firefox"
      @version = match[1]
    elsif match = @user_agent.match(/msie\s*(\d+\.\d+)/)
      @browser = :ie
      @title = "Microsoft Internet Explorer"
      @version = match[1]
    elsif match = @user_agent.match(/opera\/([\d+\.]+)/)
      @browser = :opera
      @title = "Opera"
      @version = match[1]
    elsif match = @user_agent.match(/android\s+([\d\.]+)/)
      @browser = :android
      @title = "Android"
      @version = match[1]
    elsif match = @user_agent.match(/safari\/(\d+)/)
      @browser = :safari
      @title = "Safari"
      @version = match[1]
    end
  end
  
  def parse_apps
    if match = @user_agent.match(/wget\/([\d+\.]+)/)
      @browser = :app
      @title = "Wget"
      @version = match[1]
    elsif match = @user_agent.match(/java\/([\d\.]+)/)
      @browser = :app
      @title = "Java"
      @version = match[1]
    end
  end
  
  def parse_bots
    regex_list = [/(googlebot)\/([\d\.]+)/, /(ezooms)\/([\d\.]+)/, /(ahrefsbot)\/([\d\.]+)/]
    parse_regex_list(regex_list, :bot)
    return if @browser
    
    string_list = ["baiduspider", "gidbot", "yahoo! slurp", "hostharvest", "exabot",
      "dotbot", "msnbot", "yandexbot", "sitebot", "sosospider"]
    parse_string_list(string_list, :bot)
    return if @browser
    
    if @env["HTTP_ACCEPT"] == "*/*" && @env["HTTP_ACCEPT_LANGUAGE"] == "zh-cn,zh-hk,zh-tw,en-us" && @env["HTTP_USER_AGENT"] == "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)" && (@env["REMOTE_ADDR"][0,10] == "114.80.93." || @env["HTTP_X_FORWARDED_FOR"][0, 10] == "114.80.93.")
      @browser = :bot
      @title = "bot"
      @version = "(unknown annoying bot from China)"
    elsif @user_agent.include?("bingbot")
      @browser = :bot
      @title = "Bingbot"
    elsif @user_agent.include?("mj12bot")
      @browser = :bot
      @title = "Majestic12 Bot"
    elsif @user_agent.include?("facebookexternalhit")
      @browser = :bot
      @title = "Facebook Externalhit"
    end
  end
  
  def parse_device
    if @user_agent.include?("ipad")
      @device = :ipad
      @os = :ios
    elsif @user_agent.include?("iphone")
      @device = :iphone
      @os = :ios
    elsif @user_agent.include?("android")
      @os = :android
    end
  end
  
  def parse_regex_list(list, browser)
    list.each do |regex|
      if match = @user_agent.match(regex)
        @browser = browser
        @title = match[1].to_s.capitalize
        @version = match[2] if match[2]
        break
      end
    end
  end
  
  def parse_string_list(list, browser)
    list.each do |str|
      next unless @user_agent.include?(str)
      @browser = browser
      @title = str.capitalize
    end
  end
end
