require 'rake'

Gem::Specification.new do |s|
  s.name        = 'leetchi-api'
  s.version     = '0.0.1'
  s.summary     = "Gem for interacting with the Leetchi API"
  s.description = <<-EOF
    The Leetchi API Gem makes interacting with Leetchi's API much easier.
    For any questions regarding the use of Leetchi's API feel free to contact us at http://www.leetchi.com/en/contact
    You can find more documentation about Leetchi's API at http://doc.api.leetchi.com/
  EOF
  s.authors     = ['Vincent Cogne', 'Geoffroy Lorieux']
  s.email       = 'geoffroy@leetchi.com'
  s.files       = FileList['lib/**/*.rb',
                           '[A-Z]*',
                           'test/**/*'].to_a
  s.homepage    = 'http://rubygems.org/gems/leetchi-api'
end
