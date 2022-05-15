# frozen_string_literal: true

require_relative "mae/version"
require "slim"
require "slim/include"
require "sass-embedded"

module Mae
  class Error < StandardError; end

  def slim2html(f)
    basename = File.basename(f, ".*")
    html_name = basename + '.html'
    html = Slim::Template.new(f, { pretty: true }).render
    File.open("#{ROOT_DIR}/output/#{html_name}", 'w') do |f|
      f.write(html)
    end
  end

  def sass2css(f)
    basename = File.basename(f, ".*")
    css_name = basename + '.css'
    sass = Sass.compile(f)
    File.open("#{ROOT_DIR}/output/css/#{css_name}", 'w') do |f|
      f.write(sass.css)
    end
  end

  module_function :slim2html, :sass2css
end
