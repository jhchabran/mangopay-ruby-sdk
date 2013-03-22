require 'rake'

Gem::Specification.new do |s|
  s.name        = 'leetchi-wallet-services'
  s.version     = '1.0.0'
  s.summary     = "Gem for interacting with the Leetchi Wallet Services"
  s.description = <<-EOF
  The Leetchi API Gem makes interacting with Leetchi's Wallet Services much easier.
  For any questions regarding the use of Leetchi's Wallet Services feel free to contact us at http://www.leetchi-api.com/contact-us/
  You can find more documentation about Leetchi's Wallet Services at http://www.leetchi-api.com/
  EOF
  s.authors     = ['Geoffroy Lorieux', 'Vincent Cogne']
  s.email       = 'it-support@leetchi.com'
  s.files       = FileList['lib/**/*.rb',
                           '[A-Z]*',
                           'spec/**/*'].to_a
  s.homepage    = 'http://www.leetchi-api.com/'
  s.required_ruby_version = '>= 1.9.2'
  s.add_dependency('json', '~> 1.7.7')
  s.add_development_dependency('rake', '~> 10.0.3')
  s.add_development_dependency('spork', '~> 0.9.2')
  s.add_development_dependency('rspec', '~> 2.13.0')
  s.add_development_dependency('vcr', '~> 2.4.0')
  s.add_development_dependency('webmock', '~> 1.11.0')
  s.add_development_dependency('capybara', '~> 2.0.2')
  s.add_development_dependency('capybara-webkit', '~> 0.14.2')
 end
