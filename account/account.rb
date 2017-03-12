module Fapber
  class Account
    def self.create
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Commerce.promotion_code.downcase + '@vps911.net'

      agent = Mechanize.new
      agent.user_agent_alias = 'Android'
      page = agent.get('https://m.facebook.com/reg')
      reg_form = page.forms.first

      reg_form.lastname = last_name
      reg_form.firstname = first_name
      reg_form.reg_email__ = email
      reg_form.radiobuttons_with(name: 'sex')[1].check
      reg_form.birthday_day = 10
      reg_form.birthday_month = 10
      reg_form.birthday_year = 1990
      reg_form.reg_passwd__ = email
      page = agent.submit(reg_form)

      page.uri.to_s == "https://m.facebook.com/reg/" ? nil : email
    end
  end
end
