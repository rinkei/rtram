# frozen_string_literal: true

RSpec.describe Tram::Converter do
  describe '.convert' do
    it 'calls .slim2html when a slim is passed.' do
      expect(Tram::Converter).to receive(:slim2html)
      Tram::Converter.convert('test.slim', '.')
    end

    it 'calls .sass2css when a scss is passed.' do
      expect(Tram::Converter).to receive(:sass2css)
      Tram::Converter.convert('test.scss', '.')
    end

    it 'calls nothing when a file of other type is passed.' do
      expect(Tram::Converter).not_to receive(:slim2html)
      expect(Tram::Converter).not_to receive(:sass2css)
      Tram::Converter.convert('test.png', '.')
    end
  end

  describe '.slim2html' do
    let(:working_directory) { '.' }

    before do
      @slim = "#{working_directory}/slim/test.slim"
      @html = "#{working_directory}/output/test.html"

      File.open(@slim, 'w') do |f|
        f.write <<~SLIM
        doctype html
        html lang="en"
          title Tram Converter
        body
          h1 Tram Converter
        SLIM
      end
    end

    after do
      File.delete(@slim) if File.exist?(@slim)
      File.delete(@html) if File.exist?(@html)
    end

    it 'creates html' do
      expect { Tram::Converter.slim2html(@slim, working_directory) }.to change { File.exist?(@html) }
    end

    it 'converts slim to html' do
      Tram::Converter.slim2html(@slim, working_directory)
      expect(File.open(@html, 'r') { |f| f.read }).to match /<h1>\n*\s*Tram Converter\n*\s*<\/h1>/
    end

    context 'when params are wrong' do
      it 'raises an error by passing the wrong slim.' do
        expect { Tram::Converter.slim2html('wrong_slim', working_directory) }.to raise_error Errno::ENOENT
      end

      it 'raises an error by passing the wrong working directory.' do
        expect { Tram::Converter.slim2html(@slim, 'wrong_directory') }.to raise_error Errno::ENOENT
      end
    end
  end

  describe '.sass2css' do
    let(:working_directory) { '.' }

    before do
      @scss = "#{working_directory}/sass/test.scss"
      @css = "#{working_directory}/output/css/test.css"

      File.open(@scss, 'w') do |f|
        f.write <<~SCSS
        $base: #123456;

        body {
          color: $base;
        }
        SCSS
      end
    end

    after do
      File.delete(@scss) if File.exist?(@scss)
      File.delete(@css) if File.exist?(@css)
    end


    it 'creates css' do
      expect { Tram::Converter.sass2css(@scss, working_directory) }.to change { File.exist?(@css) }
    end

    it 'converts scss to css' do
      Tram::Converter.sass2css(@scss, working_directory)
      expect(File.open(@css, 'r') { |f| f.read }).to match /color: #123456;/
    end

    context 'when params are wrong' do
      it 'raises an error by passing the wrong slim.' do
        expect { Tram::Converter.sass2css('wrong_scss', working_directory) }.to raise_error Sass::CompileError
      end

      it 'raises an error by passing the wrong working directory.' do
        expect { Tram::Converter.sass2css(@scss, 'wrong_directory') }.to raise_error Errno::ENOENT
      end
    end
  end
end
