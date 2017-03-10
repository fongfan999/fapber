require 'mechanize'
require 'json'
require 'faker'
# require 'watir'
# require_relative '../ext/progress_bar'
# require_relative '../application'
# require_relative '../like/application'
# require_relative '../like/photo'


# Configuration
Faker::Config.locale = :vi
# # # # #

emails = []

# 100.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Commerce.promotion_code.downcase + '@gmail.com'

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

  emails << email unless page.uri.to_s == "https://m.facebook.com/reg/"

  FacebookScraper::Like::Photo.new(
    "https://www.facebook.com/photo.php?fbid=929565857178554&set=a.183547535113727.43632.100003754453458&type=3&theater",
    email,
    email
  ).run

  # ProgressBar.display(n, 100)
# end

# File.open('res/5.json', 'w') do |f|
#   f.write(emails.to_json)
# end

# ProgressBar.finish
