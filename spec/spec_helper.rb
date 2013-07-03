require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  require 'vcr'
  require 'webmock/rspec'
  require 'capybara'
  require 'capybara/rspec'
  require 'capybara-webkit'

  Capybara.javascript_driver = :webkit
  Capybara.default_driver = :webkit

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.hook_into :webmock
    c.default_cassette_options = { :record => :new_episodes }
    c.allow_http_connections_when_no_cassette = true
    c.configure_rspec_metadata!
  end

  RSpec.configure do |c|
    c.treat_symbols_as_metadata_keys_with_true_values = true
    c.order = "random"
  end
end

Spork.each_run do
  require_relative '../lib/mangopay'
  # This code will be run each time you run your specs.
  MangoPay.configure do |c|
    c.preproduction = true
    c.partner_id = 'example'
    c.key_path = './spec/support-files/example.pem'
    c.key_password = ''
  end
end
