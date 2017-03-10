module FacebookScraper 
  module Share
    class Photo < Application  
      def run(options = {count: 1})
        @browser.goto(@url)
        @browser.element(css: '#m_loginbar_login_button').click
        @browser.text_field(name: 'email').set(@email)
        @browser.text_field(name: 'pass').set(@pass)
        @browser.send_keys :enter

        options[:count].times do
          @browser.link(href: %r{/sharer.php}).wait_until_present.click
          @browser.link(css: '._56bz._54k8._55i1._58a0.touchable').click

          sleep rand(5)
        end

        @browser.quit
      end
    end
  end
end
