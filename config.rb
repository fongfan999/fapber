# Available modules
FAPBER_MODULES = %w(account page photo post)

# External gems
require 'json'
require 'watir'
require 'faker'
require 'mechanize'

# Load root module
require File.expand_path("application")

# Load all modules
FAPBER_MODULES.each do |mod|
  Dir["#{mod}/*.rb"].each do |filename| 
    require File.expand_path(filename)
  end
end

# Load specific configuration gem
Dir["initializers/*.rb"].each do |filename|
  require File.expand_path(filename)
end
