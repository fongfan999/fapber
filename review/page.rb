module Fapber 
  module Review
    class Page < Application  
      def run(options = {})
        begin
          # Review need to be at least 25 characters     
          options[:msg] = '<3 ' * 20 if options[:msg].length < 25
          
          self.sign_in
          # Click the 5th star
          @browser.links(data_ajaxify_href: '/netego/click')
                  .wait_until_present(timeout: 5)
                  .last
                  .click
                  
          # Write content review amd submit
          @browser.textarea(css: '.composerInput').set options[:msg]
          @browser.button(data_sigil: 'touchable submit_composer').click
        rescue Watir::Wait::TimeoutError => e
          # Facebook require checkpoint, so like_button is not present
          # The timeout exception will be raised after 5 seconds
          @browser.quit
        end

        @browser.quit
      end
    end
  end
end
