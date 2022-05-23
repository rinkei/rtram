# frozen_string_literal: true

require 'fileutils'

RSpec.describe RTram::Project do
  describe '.create' do
    before do
      Dir.mkdir('test_directory')
      Dir.chdir('test_directory')
    end

    after do
      Dir.chdir('..')
      FileUtils.rm_rf('test_directory')
    end

    context 'when project_name is passed as the working directory' do
      after do
        FileUtils.rm_f('test_project')
      end

      it 'creates test_project directories passed as param.' do
        expect { RTram::Project.create('test_project') }
          .to change { Dir.exist?('test_project') }
          .and change { Dir.exist?('test_project/slim') }
          .and change { File.exist?('test_project/slim/index.slim') }
          .and change { Dir.exist?('test_project/sass') }
          .and change { File.exist?('test_project/sass/main.scss') }
          .and change { Dir.exist?('test_project/output') }
          .and change { Dir.exist?('test_project/output/css') }
          .and change { Dir.exist?('test_project/output/image') }
      end
    end

    context 'when the current directory is the working directory' do
      it 'creates directories in the current directory' do
        expect { RTram::Project.create(nil) }
          .to change { Dir.exist?('./slim') }
          .and change { File.exist?('./slim/index.slim') }
          .and change { Dir.exist?('./sass') }
          .and change { File.exist?('./sass/main.scss') }
          .and change { Dir.exist?('./output') }
          .and change { Dir.exist?('./output/css') }
          .and change { Dir.exist?('./output/image') }
      end
    end
  end
end
