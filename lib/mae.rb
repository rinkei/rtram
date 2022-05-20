# frozen_string_literal: true

require_relative "mae/version"

module Mae
  ROOT_DIR = File.expand_path("../..", __FILE__)

  class Error < StandardError; end
end
