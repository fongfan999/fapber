module Fapber
  class Application
    def initialize(url, email, pass)
      # Visit login page and then redirect to expected page automatically
      # by using Facebook's referrer url functionality (next)
      @url = "https://m.facebook.com/login.php?next=#{url.sub('www', 'm')}"
      @email = email
      @pass = pass
      @browser = Watir::Browser.new :chrome
    end

    def sign_in
      # Visit login page and then fill form
      @browser.goto(@url)
      @browser.text_field(name: 'email').set(@email)
      @browser.text_field(name: 'pass').set(@pass)
      @browser.send_keys :enter
    end
  end
end
