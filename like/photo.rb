module FacebookScraper 
  module Like
    class Photo < Application  
      def run
        @browser.goto(@url)
        @browser.element(css: '#m_loginbar_login_button').click
        @browser.text_field(name: 'email').set(@email)
        @browser.text_field(name: 'pass').set(@pass)
        @browser.send_keys :enter

        like_button = @browser.element(data_uri: %r{ufi/reaction/?}).wait_until_present
        unless @browser.link(css: '._2q8z').exists?
          like_button.click
        end

        @browser.quit
      end
    end
  end
end
