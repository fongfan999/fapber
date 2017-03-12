module Fapber 
  module Share
    class Photo < Application  
      def run(options = {count: 1})
        self.sign_in

        # Share count times
        options[:count].times do
          begin
          # Open dropdown menu
          @browser.link(href: %r{/sharer.php})
                  .wait_until_present(timeout: 5)
                  .click
          # Share now
          @browser.link(css: '._56bz._54k8._55i1._58a0.touchable').click
          # Delay time for the next sharing
          sleep rand(5)
          rescue Watir::Wait::TimeoutError => e
            # Facebook require checkpoint, so like_button is not present
            # The timeout exception will be raised after 5 seconds
            next
          end
        end

        @browser.quit
      end
    end
  end
end
