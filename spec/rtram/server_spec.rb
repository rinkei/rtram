# frozen_string_literal: true

require 'fileutils'

RSpec.describe RTram::Converter do
  before do
    Dir.mkdir('test_directory')
    Dir.chdir('test_directory')
    RTram::Project.create('test_project')
  end

  after do
    Dir.chdir('..')
    FileUtils.rm_rf('test_directory')
  end

  describe '.start' do
    let(:webrick_double) { double(WEBrick::HTTPServer) }

    it 'starts WEBrick::HTTPServer.' do
      expect_any_instance_of(WEBrick::HTTPServer).to receive(:start)
      RTram::Server.start('test_project')
    end

    context '(when the webrick is stub on start)' do
      before do
        allow(webrick_double).to receive(:start)
        allow(WEBrick::HTTPServer).to receive(:new).and_return(webrick_double)
      end

      it 'calls listen_to_convert.' do
        expect(RTram::Server).to receive(:listen_to_convert)
        RTram::Server.start('test_project')
      end

      it 'converts existing entries.' do
        expect { RTram::Server.start('test_project') }
          .to change { File.exist?('test_project/output/css/main.css') }
      end

      it 'raises error when the working directory is invalid.' do
        FileUtils.rm_rf('test_project/output/css')
        expect { RTram::Server.start('test_project') }.to raise_error RTram::Project::Error
      end
    end
  end
end
