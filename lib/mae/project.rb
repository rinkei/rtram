# frozen_string_literal: true

require "mae"

module Mae
  module Project
    def create(project_name)
      Dir.mkdir("#{project_name}")
      Dir.mkdir("#{project_name}/slim")
      Dir.mkdir("#{project_name}/sass")
      Dir.mkdir("#{project_name}/output")
      Dir.mkdir("#{project_name}/output/css")
      Dir.mkdir("#{project_name}/output/image")
    end
  end
end
