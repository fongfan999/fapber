module FacebookScraper
  class Application
    def initialize(url, email, pass)
      @url = "https://m.#{url[/f.+/]}"
      @email = email
      @pass = pass
      @browser = Watir::Browser.new :chrome
    end

    def like_and_share
      @browser.goto(@url)
      @browser.element(css: '#m_loginbar_login_button').click
      @browser.text_field(name: 'email').set(@email)
      @browser.text_field(name: 'pass').set(@pass)
      @browser.send_keys :enter

      # Like
      like_button = @browser.element(data_uri: %r{ufi/reaction/?}).wait_until_present
      unless @browser.link(css: '._2q8z').exists?
        like_button.click
      end

      # Share
      @browser.link(href: %r{/sharer.php}).wait_until_present.click
      @browser.link(css: '._56bz._54k8._55i1._58a0.touchable').click
      
      # Random sleep time from 1..20s
      sleep rand(20) + 1
      @browser.quit

    rescue
      return
    end
  end
end

