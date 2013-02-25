require_relative '../lib/leetchi-wallet-services'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'
require 'capybara'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:timeout => 60})
end
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist

Turn.config do |c|
 # :outline  - turn's original case/test outline mode [default]
 c.format  = :outline
 # use humanized test names (works only with :outline format)
 c.natural = true
end

#VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/leetchi_cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

Leetchi.configure do |c|
    c.preproduction = true
    c.partner_id = 'example'
    c.key_path = './spec/support-files/example.pem'
    c.key_password = ''
end

