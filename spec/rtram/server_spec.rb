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
    it 'starts WEBrick::HTTPServer.' do
      expect_any_instance_of(WEBrick::HTTPServer).to receive(:start)
      RTram::Server.start('test_project')
    end

    context '(when the webrick is stub on start)' do
      let(:webrick_double) { double(WEBrick::HTTPServer) }

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

=begin
  describe '.listen_to_convert' do
    let(:listener) { double(Listen) }

    before do
      allow(listener).to receive(:start)
    end

    it "listens to slim & sass directories' changes." do
      expect(Listen).to receive(:to).with('test_project/slim', 'test_project/sass', force_polling: true)
        .and_return(listener)

      RTram::Server.listen_to_convert('test_project')
    end
  end
=end
end
