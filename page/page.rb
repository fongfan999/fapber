module Fapber 
  class Page < Application
    def like
      begin
        self.sign_in

        # Wait until the like button present
        like_button = @browser.link(href: /profile\.php\?fan/)
          .wait_until_present(timeout: 5)

        # Click the like button when It's not been liked
        like_button.click unless like_button.class_name.include?('_5kqs')
      rescue Watir::Wait::TimeoutError
        # Facebook require checkpoint, so like_button is not present
        # The timeout exception will be raised after 5 seconds
        @browser.quit
      end

      @browser.quit
    end

    def review(options = {})
      begin
        # Add '/reviews' to the end of @url
        @url << (@url[-1] == '/' ? 'reviews' : '/reviews')
        # Review message need to be at least 25 characters  
        if !options[:msg] || options[:msg].length < 25
          options[:msg] = '<3 ' * 20     
        end   
        
        self.sign_in
        # Click the 5th star
        @browser.links(data_ajaxify_href: '/netego/click')
          .last.wait_until_present(timeout: 5).click
        
        # Write content review amd submit
        @browser.textarea(css: '.composerInput').set options[:msg]
        @browser.button(data_sigil: 'touchable submit_composer').click
      rescue Watir::Wait::TimeoutError
        # Facebook require checkpoint, so review button is not present
        # Or this account has already reviewed
        # The timeout exception will be raised after 5 seconds
        @browser.quit
      end

      @browser.quit
    end
  end
end
