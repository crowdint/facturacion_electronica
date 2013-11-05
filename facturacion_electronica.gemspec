# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'facturacion_electronica/version'

Gem::Specification.new do |spec|
  spec.name          = "facturacion_electronica"
  spec.version       = FacturacionElectronica::VERSION
  spec.authors       = ["Ulices Barajas"]
  spec.email         = ["ulices.barajas@crowdint.com"]
  spec.description   = %q{Processing electronic invoices and ring through a PAC}
  spec.summary       = %q{Processing electronic invoices and ring through a PAC}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
