# frozen_string_literal: true

require "slim"
require "slim/include"
require "sass-embedded"

module RTram
  module Converter
    def convert(f, working_directory)
      extname = File.extname(f)
      if extname == '.slim'
        slim2html(f, working_directory)
      elsif extname == '.sass' || extname == '.scss'
        sass2css(f, working_directory)
      end
    end

    def slim2html(f, working_directory)
      basename = File.basename(f, ".*")
      html_name = basename + '.html'
      html = Slim::Template.new(f, { pretty: true }).render
      File.open("#{working_directory}/output/#{html_name}", 'w') do |f|
        f.write(html)
      end
    end

    def sass2css(f, working_directory)
      basename = File.basename(f, ".*")
      css_name = basename + '.css'
      sass = Sass.compile(f)
      File.open("#{working_directory}/output/css/#{css_name}", 'w') do |f|
        f.write(sass.css)
      end
    end

    module_function :convert, :slim2html, :sass2css
  end
end
