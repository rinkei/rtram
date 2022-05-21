# frozen_string_literal: true

require_relative "tram/version"

module Tram
  class Error < StandardError; end

  def root
    File.dirname __dir__
  end

  module_function :root
end
