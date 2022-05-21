# frozen_string_literal: true

require "mae"
require "fileutils"

module Mae
  module Project
    class Error < StandardError; end

    def create(project_name)
      if project_name
        working_directory = project_name
        Dir.mkdir(working_directory) unless Dir.exist?(working_directory)
      else
        working_directory = './'
      end

      unless Dir.exist?("#{working_directory}/slim")
        Dir.mkdir("#{working_directory}/slim")
        FileUtils.cp("#{Mae.root}/slim/index.slim", "#{working_directory}/slim")
      end

      unless Dir.exist?("#{working_directory}/sass")
        Dir.mkdir("#{working_directory}/sass")
        FileUtils.cp("#{Mae.root}/sass/main.scss", "#{working_directory}/sass")
      end

      Dir.mkdir("#{working_directory}/output") unless Dir.exist?("#{working_directory}/output")
      Dir.mkdir("#{working_directory}/output/css") unless Dir.exist?("#{working_directory}/output/css")
      Dir.mkdir("#{working_directory}/output/image") unless Dir.exist?("#{working_directory}/output/image")
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
