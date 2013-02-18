require 'rake'

Gem::Specification.new do |s|
  s.name        = 'leetchi-wallet-services'
  s.version     = '0.0.1'
  s.summary     = "Gem for interacting with the Leetchi Wallet Services"
  s.description = <<-EOF
    The Leetchi API Gem makes interacting with Leetchi's Wallet Services much easier.
    For any questions regarding the use of Leetchi's Wallet Services feel free to contact us at http://www.leetchi.com/en/contact
    You can find more documentation about Leetchi's Wallet Services at http://doc.api.leetchi.com/
  EOF
  s.authors     = ['Vincent Cogne', 'Geoffroy Lorieux']
  s.email       = 'geoffroy@leetchi.com'
  s.files       = FileList['lib/**/*.rb',
                           '[A-Z]*',
                           'spec/**/*'].to_a
  s.homepage    = 'http://rubygems.org/gems/leetchi-wallet-services'
  s.required_ruby_version = '>= 1.9.2'
  s.add_dependency('json', '~> 1.7.7')
  s.add_development_dependency(['minitest', 'webmock', 'vcr', 'turn', 'rake'])
end
