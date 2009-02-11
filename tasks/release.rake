require 'rubygems'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'lib/session_dump'

PKG_NAME = 'session_dump'
PKG_VERSION = SessionDump::Version.to_s
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"
RUBY_FORGE_PROJECT = PKG_NAME
RUBY_FORGE_USER = ENV['RUBY_FORGE_USER'] || 'valo'

RELEASE_NAME  = PKG_VERSION
RUBY_FORGE_GROUPID = '1337'
RUBY_FORGE_PACKAGEID = '1638'

RDOC_TITLE = "Session dump"
RDOC_EXTRAS = ["README"]

namespace 'session_dump' do
  spec = Gem::Specification.new do |s|
    s.name = PKG_NAME
    s.version = PKG_VERSION
    s.author = "Valentin Mihov"
    s.email = "valentin.mihov@gmail.com"
    s.homepage = "http://github.com/valo/session_dump"
    s.summary = 'A small gem, which allows the controllers to easily dump the current session at each request.'
    s.description = "A small gem, which allows the controllers to easily dump the current session at each request."
    s.rubyforge_project = RUBY_FORGE_PROJECT
    s.platform = Gem::Platform::RUBY
    s.has_rdoc = true
    s.rdoc_options << '--title' << RDOC_TITLE << '--line-numbers' << '--main' << 'README'
    s.extra_rdoc_files = RDOC_EXTRAS
    files = FileList['**/*']
    files.exclude 'session_dump.gemspec'
    files.exclude 'pkg'
    files.exclude 'pkg/**/*'
    s.files = files.to_a
  end

  Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
  end

  task :gemspec do
    File.open('session_dump.gemspec', 'w') {|f| f.write spec.to_ruby }
  end

  namespace :gem do
    desc "Uninstall Gem"
    task :uninstall do
      sh "gem uninstall #{PKG_NAME}" rescue nil
    end
  
    desc "Build and install Gem from source"
    task :install => [:package, :uninstall] do
      chdir("#{File.dirname(__FILE__)}/../pkg") do
        latest = Dir["#{PKG_NAME}-*.gem"].last
        sh "gem install #{latest}"
      end
    end
  end

  desc "Publish the release files to RubyForge."
  task :release => [:gem, :package] do
    files = ["gem", "tgz", "zip"].map { |ext| "pkg/#{PKG_FILE_NAME}.#{ext}" }

    system %{rubyforge login --username #{RUBY_FORGE_USER}}
  
    files.each do |file|
      system %{rubyforge add_release #{RUBY_FORGE_GROUPID} #{RUBY_FORGE_PACKAGEID} "#{RELEASE_NAME}" #{file}}
    end
  end
end
