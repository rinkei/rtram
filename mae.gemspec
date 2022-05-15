# frozen_string_literal: true

require_relative "lib/mae/version"

Gem::Specification.new do |spec|
  spec.name = "mae"
  spec.version = Mae::VERSION
  spec.authors = ["rinkei"]
  spec.email = ["kei.h.hayashi@gmail.com"]

  spec.summary = "static site generator"
  spec.description = "Mae is a static site generator using Slim & Sass."
  spec.homepage = "https://github.com/rinkei/mae"
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
