require 'json'
require 'watir'
require 'faker'
require 'mechanize'

# Dir["like/*.rb"].each {|file| require_relative file }
require_relative 'reger'
require_relative 'application'
require_relative 'like/application'
require_relative 'like/photo'
require_relative 'share/application'
require_relative 'share/photo'

require_relative 'ext/progress_bar'

# Configuration
Faker::Config.locale = :vi
# # # # #

# email = Reger.get_new_user

# puts email
# if email
  FacebookScraper::Share::Photo.new(
    'https://www.facebook.com/1449089655132876/videos/1473692872672554/',
    '19704546300',
    'CTofLvH2016'
  ).run(count: 500)

  # FacebookScraper::Application.new(
  #   'https://www.facebook.com/DoanHoiKH.KTTT/photos/a.590828277749592.1073741827.586130224886064/729124740586611/?type=3&theater',
  #   'ngoduyan.3',
  #   'khongchunbuoc17'
  # ).like_and_share
# end
