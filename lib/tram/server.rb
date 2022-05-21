# frozen_string_literal: true

require "webrick"
require "listen"
require "tram/converter"
require "tram/project"

module Tram
  module Server
    def start(working_directory)
      working_directory ||= "./"

      Tram::Project.valid?(working_directory)

      existing_entries = Dir.glob("#{working_directory}/{slim,sass}/**/*.{slim,sass,scss}")
      existing_entries.each { |f| Tram::Converter.convert(f, working_directory) }

      listen_to_convert(working_directory)

      srv = WEBrick::HTTPServer.new({
        DocumentRoot:   "#{working_directory}/output",
        BindAddress:    '127.0.0.1',
        Port:           5000,
      })
      srv.start
    end

    def listen_to_convert(working_directory)
      directories = ["#{working_directory}/slim", "#{working_directory}/sass"]

      listener = Listen.to(*directories, force_polling: true) do |modified, added, removed|
        modified.each { |f| Tram::Converter.convert(f, working_directory) }
        added.each { |f| Tram::Converter.convert(f, working_directory) }
      end

      listener.start
    end

    module_function :start, :listen_to_convert
    private_class_method :listen_to_convert
  end
end
