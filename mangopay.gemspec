require 'rake'

Gem::Specification.new do |s|
  s.name        = 'mangopay'
  s.version     = '2.0.0'
  s.summary     = "Gem for interacting with the Mango Pay API"
  s.description = <<-EOF
  The mangopay Gem makes interacting with MangoPay Services much easier.
  For any questions regarding the use of MangoPay's Wallet Services feel free to contact us at http://www.mangopay.com/contact-us/
  You can find more documentation about MangoPay Services at http://www.mangopay.com/
  EOF
  s.authors     = ['Geoffroy Lorieux', 'Vincent Cogne', 'Eric Larch']
  s.email       = 'it-support@mangopay.com'
  s.files       = FileList['lib/**/*.rb',
                           '[A-Z]*',
                           'spec/**/*'].to_a
  s.homepage    = 'http://www.mangopay.com/'
  s.license = 'MIT'
  s.required_ruby_version = '>= 1.9.2'
  s.add_dependency('json', '~> 1.8.0')
  s.add_dependency('multipart-post', '~> 1.2.0')
  s.add_development_dependency('rake', '~> 10.0.4')
  s.add_development_dependency('spork', '~> 0.9.2')
  s.add_development_dependency('rspec', '~> 2.13.0')
  s.add_development_dependency('vcr', '~> 2.4.0')
  s.add_development_dependency('webmock', '~> 1.11.0')
  s.add_development_dependency('capybara', '~> 2.0.2')
  s.add_development_dependency('capybara-webkit', '~> 0.14.2')
end
