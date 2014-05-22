class AgentHelpers::Detector
  attr_reader :browser, :title, :version
  
  def initialize(args)
    @user_agent = args[:user_agent]
    raise "No user agent was given." if @user_agent.to_s.trim.empty?
  end
  
private
  
  def parse
    if match = @user_agent.match(/chrome\/(\d+\.\d+)/)
      @browser = :chrome
      @title = "Google Chrome"
      @version = match[1]
    elsif match = @user_agent.match(/firefox\/(\d+\.\d+)/)
      @browser = :firefox
      @title = "Mozilla Firefox"
      @version = match[1]
    elsif servervar["HTTP_ACCEPT"] == "*/*" && servervar["HTTP_ACCEPT_LANGUAGE"] == "zh-cn,zh-hk,zh-tw,en-us" && servervar["HTTP_USER_AGENT"] == "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)" && (servervar["REMOTE_ADDR"][0,10] == "114.80.93." || servervar["HTTP_X_FORWARDED_FOR"][0, 10] == "114.80.93.")
      @browser = :bot
      @title = "bot"
      @version = "(unknown annoying bot from China)"
    elsif match = @user_agent.match(/msie\s*(\d+\.\d+)/)
      @browser = :ie
      @title = "Microsoft Internet Explorer"
      @version = match[1]
    elsif match = @user_agent.match(/opera\/([\d+\.]+)/)
      @browser = :opera
      @title = "Opera"
      @version = match[1]
    elsif match = @user_agent.match(/wget\/([\d+\.]+)/)
      @browser = :bot
      @title = "Bot"
      @version = "Wget #{match[1]}"
    elsif agent.include?("baiduspider")
      @browser = :bot
      @title = "Bot"
      @version = "Baiduspider"
    elsif agent.include?("googlebot")
      @browser = :bot
      @title = "Bot"
      @version = "Googlebot"
    elsif agent.include?("gidbot")
      @browser = :bot
      @title = "Bot"
      @version = "GIDBot"
    elsif match = @user_agent.match(/android\s+([\d\.]+)/)
      @browser = :android
      @title = "Android"
      @version = match[1]
    elsif match = @user_agent.match(/safari\/(\d+)/)
      @browser = :safari
      @title = "Safari"
      @version = match[1]
    elsif agent.include?("iPad")
      @browser = :safari
      @title = "Safari (iPad)"
      @version = "ipad"
    elsif agent.include?("bingbot")
      @browser = :bot
      @title = "Bot"
      @version = "Bingbot"
    elsif agent.include?("yahoo! slurp")
      @browser = :bot
      @title = "Bot"
      @version = "Yahoo! Slurp"
    elsif agent.include?("hostharvest")
      @browser = :bot
      @title = "Bot"
      @version = "HostHarvest"
    elsif agent.include?("exabot")
      @browser = :bot
      @title = "Bot"
      @version = "Exabot"
    elsif agent.include?("dotbot")
      @browser = :bot
      @title = "Bot"
      @version = "DotBot"
    elsif agent.include?("msnbot")
      @browser = :bot
      @title = "Bot"
      @version = "MSN bot"
    elsif agent.include?("yandexbot")
      @browser = :bot
      @title = "Bot"
      @version = "Yandex Bot"
    elsif agent.include?("mj12bot")
      @browser = :bot
      @title = "Bot"
      @version = "Majestic12 Bot"
    elsif agent.include?("facebookexternalhit")
      @browser = :bot
      @title = "Bot"
      @version = "Facebook Externalhit"
    elsif agent.include?("sitebot")
      @browser = :bot
      @title = "Bot"
      @version = "SiteBot"
    elsif match = @user_agent.match(/java\/([\d\.]+)/)
      @browser = :bot
      @title = "Java"
      @version = match[1]
    elsif match = @user_agent.match(/ezooms\/([\d\.]+)/)
      @browser = :bot
      @title = "Ezooms"
      @version = match[1]
    elsif match = @user_agent.match(/ahrefsbot\/([\d\.]+)/)
      @browser = :bot
      @title = "AhrefsBot"
      @version = match[1]
    elsif agent.include?("sosospider")
      @browser = :bot
      @title = "Bot"
      @version = "Sosospider"
    else
      @browser = :unknown
      @title = "(unknown browser)"
      @version = "(unknown version)"
    end
  end
end
