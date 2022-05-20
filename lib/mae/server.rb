# frozen_string_literal: true

require "webrick"
require "listen"
require "mae"
require "mae/converter"

module Mae
  module Server
    def start
      listen_to_convert

      srv = WEBrick::HTTPServer.new({
        DocumentRoot:   './output',
        BindAddress:    '127.0.0.1',
        Port:           5000,
      })
      srv.start
    end

    def listen_to_convert
      converting = Proc.new do |f|
        extname = File.extname(f)
        if extname == '.slim'
          Mae::Converter.slim2html(f)
        elsif extname == '.sass' || extname == '.scss'
          Mae::Converter.sass2css(f)
        end
      end

      listener = Listen.to(Mae::ROOT_DIR + "/slim", Mae::ROOT_DIR + "/sass", force_polling: true) do |modified, added, removed|
        modified.each &converting
        added.each &converting
      end

      listener.start
    end

    module_function :start, :listen_to_convert
    private_class_method :listen_to_convert
  end
end
