require_relative "lib/contrib/auth/version"

Gem::Specification.new do |spec|
  spec.name        = "contrib-auth"
  spec.version     = Contrib::Auth::VERSION
  spec.authors     = ["Contribyard Developers"]
  spec.email       = ["developers@contribyard.com"]
  spec.homepage    = "https://github.com/contribyard/contrib-auth"
  spec.summary     = "Vendor-agnostic authentication component for Rails APIs"
  spec.description = "Vendor-agnostic authentication component for Rails APIs"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
  spec.add_dependency 'faraday'
end
