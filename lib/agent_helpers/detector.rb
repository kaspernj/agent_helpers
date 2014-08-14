class AgentHelpers::Detector
  attr_reader :browser, :title, :version, :device, :os, :os_title, :os_version

  WINDOWS_VERSIONS = {
    "NT 5.0" => "Windows 2000",
    "NT 5.01" => "Windows 2000 SP1",
    "NT 5.1" => "Windows XP",
    "NT 5.2" => "Windows XP 64bit",
    "NT 6.0" => "Windows Vista",
    "NT 6.1" => "Windows 7",
    "NT 6.2" => "Windows 8",
    "NT 6.3" => "Windows 8.1"
  }

  MAC_OSX_VERSIONS = {
    "10.0" => "Cheetah",
    "10.1" => "Puma",
    "10.2" => "Juguar",
    "10.3" => "Panther",
    "10.4" => "Tiger",
    "10.5" => "Leopard",
    "10.6" => "Snow Leopard",
    "10.7" => "Lion",
    "10.8" => "Mountain Lion",
    "10.9" => "Mavericks",
    "10.10" => "Yosemite"
  }

  def initialize(args)
    @request = args[:request]
    raise "No request was given." unless @request
    @env = @request.env
    @user_agent = @request.user_agent.to_s.downcase.strip
    raise "No user agent was given." if @user_agent.empty?

    browsers = [:chrome, :ie, :firefox, :opera, :safari]
    browsers.each do |browser|
      __send__("parse_#{browser}") unless @browser
    end

    parse_bots unless @browser
    parse_device
  end

  def version_major
    if match = version.to_s.match(/^(\d+)/)
      return match[1].to_i
    else
      return nil
    end
  end

private

  def parse_chrome
    if match = @user_agent.match(/chrome\/([\d+\.]+)/)
      @browser = :chrome
      @title = "Google Chrome"
      @version = match[1]
    end
  end

  def parse_ie
    if match = @user_agent.match(/msie\s*([\d+\.]+)/)
      @browser = :ie
      @title = "Microsoft Internet Explorer"
      @version = match[1]
    end
  end

  def parse_firefox
    if match = @user_agent.match(/firefox\/([\d+\.]+)/)
      @browser = :firefox
      @title = "Mozilla Firefox"
      @version = match[1]
    end
  end

  def parse_opera
    if match = @user_agent.match(/opera\/([\d+\.]+)/)
      @browser = :opera
      @title = "Opera"
      @version = match[1]
    end
  end

  def parse_safari
    if match = @user_agent.match(/safari\/([\d+\.]+)/)
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
    regex_list = [/(googlebot)\/([\d\.]+)/, /(ezooms)\/([\d\.]+)/, /(ahrefsbot)\/([\d\.]+)/, /(baiduspider)/, /(gidbot)/, /(yahoo! slurp)/,
      /(hostharvest)/, /(exabot)/, /(dotbot)/, /(msnbot)/, /(yandexbot)/, /(sitebot)/, /(sosospider)/, /(bingbot)/]
    parse_regex_list(regex_list, :bot)
    return if @browser

    if @env["HTTP_ACCEPT"] == "*/*" && @env["HTTP_ACCEPT_LANGUAGE"] == "zh-cn,zh-hk,zh-tw,en-us" && @env["HTTP_USER_AGENT"] == "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)" && (@env["REMOTE_ADDR"][0,10] == "114.80.93." || @env["HTTP_X_FORWARDED_FOR"][0, 10] == "114.80.93.")
      @browser = :bot
      @title = "(unknown annoying bot from China)"
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
    elsif match = @user_agent.match(/windows (nt |)([\d\.]+)/)
      @os = :windows
      @os_version = match[2]
      @os_version = "NT #{@os_version}" if match[1] == "nt "
      @os_title = WINDOWS_VERSIONS[@os_version]
    elsif @user_agent.include?("linux")
      @os = :linux
      @os_title = "Linux"
    elsif match = @user_agent.match(/mac os x ([\d_\.]+)/)
      @os = :osx
      @os_version = match[1].gsub("_", ".")
      detect_osx_title
    end
  end

  def detect_osx_title
    major_version = @os_version.match(/^\d+\.\d+/)[0]
    @os_title = "Mac OSX"

    if title = MAC_OSX_VERSIONS[major_version]
      @os_title << " #{title}"
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
end
