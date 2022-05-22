# frozen_string_literal: true

require_relative "lib/tram/version"

Gem::Specification.new do |spec|
  spec.name = "tram"
  spec.version = Tram::VERSION
  spec.authors = ["rinkei"]
  spec.email = ["kei.h.hayashi@gmail.com"]

  spec.summary = "Tram is a static website generator using Slim & Sass."
  spec.description = "Tram provides a server to develop static websites while converting Slim and Sass into HTML and CSS."
  spec.homepage = "https://github.com/rinkei/tram"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "slim"
  spec.add_development_dependency "sass-embedded"
  spec.add_development_dependency "webrick"
  spec.add_development_dependency "listen"
end
