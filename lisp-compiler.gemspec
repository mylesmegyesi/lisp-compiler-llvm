Gem::Specification.new do |spec|
  spec.name          = 'lisp-compiler'
  spec.version       = '0.0.1'
  spec.authors       = ['Myles Megyesi']
  spec.email         = ['myles.megyesi@gmail.com']
  spec.summary       = %q{Compile lisp files to binary.}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/mylesmegyesi/lisp-compiler-ruby'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lisp-parser', '0.0.1.alpha1'
  spec.add_runtime_dependency 'ruby-llvm', '~> 3.4.1'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
end
