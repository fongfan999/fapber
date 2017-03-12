module Fapber 
  module Like
    class Photo < Application  
      def run
        begin
          self.sign_in
          # Wait until the like button present
          like_button = @browser.element(data_uri: %r{ufi/reaction/?})
                                .wait_until_present(timeout: 5)

          # Click the like button when It's not been liked
          unless @browser.link(css: '._2q8z').exists?
            like_button.click
          end
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
