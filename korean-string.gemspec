# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "korean-string"
  spec.version       = '0.1.0'
  spec.licenses      = ['MIT']
  spec.authors       = ["Ben Humphreys"]
  spec.email         = ["benhumphreys@gmail.com"]

  spec.summary       = %q{Korean string join and split}
  spec.description   = %q{Split Korean characters to individual compontents, join components together to create characters}
  spec.homepage      = "https://github.com/bhumphreys/korean-string"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|example)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
