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

    def like
      begin
        self.sign_in
        # Wait until the like button present
        like_button = @browser.link(data_uri: %r{ufi/reaction/\?})
          .wait_until_present(timeout: 5)

        # Click the like button when It's not been liked
        like_button.click unless like_button.class_name.include?('._2q8z')
      rescue Watir::Wait::TimeoutError
        # Facebook require checkpoint, so like_button is not present
        # The timeout exception will be raised after 5 seconds
        @browser.quit
      end

      @browser.quit
    end

    def share(options = {count: 1})
      self.sign_in

      # Share count times
      options[:count].times do
        begin
          # Open dropdown menu
          @browser.link(href: %r{/sharer.php})
            .wait_until_present(timeout: 5).click
          # Share now
          @browser.link(data_sigil: /share-post-one-click-button/)
            .wait_until_present(timeout: 5).click

          # Delay time for the next sharing
          sleep rand(5)
        rescue Watir::Wait::TimeoutError
          # Facebook require checkpoint, so the share button is not present
          # The timeout exception will be raised after 5 seconds
          next
        end
      end

      @browser.quit
    end
  end
end
