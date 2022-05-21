# frozen_string_literal: true

require "webrick"
require "listen"
require "mae"
require "mae/converter"

module Mae
  module Server
    def start(working_directory)
      listen_to_convert(working_directory)

      srv = WEBrick::HTTPServer.new({
        DocumentRoot:   "#{working_directory}/output",
        BindAddress:    '127.0.0.1',
        Port:           5000,
      })
      srv.start
    end

    def listen_to_convert(working_directory)
      converting = Proc.new do |f|
        extname = File.extname(f)
        if extname == '.slim'
          Mae::Converter.slim2html(f, working_directory)
        elsif extname == '.sass' || extname == '.scss'
          Mae::Converter.sass2css(f, working_directory)
        end
      end

      directories = ["#{working_directory}/slim", "#{working_directory}/sass"]

      listener = Listen.to(*directories, force_polling: true) do |modified, added, removed|
        modified.each &converting
        added.each &converting
      end

      listener.start
    end

    module_function :start, :listen_to_convert
    private_class_method :listen_to_convert
  end
end
