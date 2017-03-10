module FacebookScraper 
  module Review
    class Page < Application  
      def run(options = {})
        # Review need to be at least 25 letters     
        options[:msg] = '<3 '*20 if options[:msg].length < 25
        
        @browser.goto(@url)
        @browser.element(css: '#m_loginbar_login_button').click
        @browser.text_field(name: 'email').set(@email)
        @browser.text_field(name: 'pass').set(@pass)
        @browser.send_keys :enter

        @browser.goto(@url)
        @browser.links(data_ajaxify_href: '/netego/click').last.wait_until_present.click
        @browser.textarea(css: '.composerInput').set options[:msg]
        @browser.button(data_sigil: 'touchable submit_composer')
          .wait_until_present.click

        @browser.quit
      end
    end
  end
end
