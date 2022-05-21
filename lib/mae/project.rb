# frozen_string_literal: true

require "mae"

module Mae
  module Project
    class Error < StandardError; end

    def create(project_name)
      Dir.mkdir(project_name)
      Dir.mkdir("#{project_name}/slim")
      Dir.mkdir("#{project_name}/sass")
      Dir.mkdir("#{project_name}/output")
      Dir.mkdir("#{project_name}/output/css")
      Dir.mkdir("#{project_name}/output/image")
    end

    def valid?(project_name)
      none_directories = []
      none_directories << project_name unless Dir.exist?(project_name)
      none_directories << "#{project_name}/slim" unless Dir.exist?("#{project_name}/slim")
      none_directories << "#{project_name}/sass" unless Dir.exist?("#{project_name}/sass")
      none_directories << "#{project_name}/output" unless Dir.exist?("#{project_name}/output")
      none_directories << "#{project_name}/output/css" unless Dir.exist?("#{project_name}/output/css")

      if none_directories.length > 0
        raise Error.new <<~EOS
          \nThe project does not have working directories: #{none_directories.join(', ')}.
          Use `mae new {project_name}` command to create working directories.
        EOS
      else
        return true
      end
    end

    module_function :create, :valid?
  end
end
