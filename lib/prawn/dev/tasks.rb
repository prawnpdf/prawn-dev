# frozen_string_literal: true

require 'fileutils'
require 'rubygems/package_task'

unless Kernel.const_defined?(:GEMSPEC)
  raise StandardError, 'GEMSPEC is not defined'
end

package_task = Gem::PackageTask.new(Gem::Specification.load(GEMSPEC))
package_task.define

built_gem_path = "pkg/#{package_task.package_name}.gem"
checksum_path = "checksums/#{File.basename(built_gem_path)}.sha512"

file built_gem_path do
  Rake::Task['package'].invoke
end

file checksum_path => built_gem_path do
  require 'digest/sha2'
  checksum = Digest::SHA512.new.hexdigest(File.read(built_gem_path))
  FileUtils.mkdir_p('checksums')
  File.write(checksum_path, checksum)
end

task checksum: checksum_path

task release: :checksum

require 'rspec/core/rake_task'

desc 'Run all rspec files'
RSpec::Core::RakeTask.new('spec') do |c|
  c.rspec_opts = '-t ~unresolved'
end

require 'yard'
YARD_OPTIONS = [
  '--output-dir', 'doc/html',
  '--verbose', '--debug',
  '--load', File.expand_path('yard_markup.rb', __dir__),
  '--markup', 'markdown',
  '--markup-provider', 'prawn/dev/yard_markup/document',
  '--use-cache',
].freeze

YARD::Rake::YardocTask.new do |t|
  t.options = YARD_OPTIONS + t.options
  t.stats_options = ['--list-undoc', '--compact']
end
task docs: :yard

require 'fileutils'
def stash_yardopts
  if File.exist?('.yardopts')
    begin
      original_opts = Shellwords.shellsplit(File.read('.yardopts'))
      require('securerandom')
      backup_file = ".yardopts-#{SecureRandom.alphanumeric(16)}.backup"
      FileUtils.move('.yardopts', backup_file)
      yield original_opts
    ensure
      FileUtils.move(backup_file, '.yardopts')
    end
  else
    yield []
  end
end

desc 'Generate YARD Documentation continuously'
task :yard_watch do
  yard_server = YARD::CLI::Server.new
  stash_yardopts do |original_opts|
    File.open('.yardopts', 'w') do |yardopts|
      yardopts.write((YARD_OPTIONS + original_opts).shelljoin)
      yardopts.fsync
      yard_server.run('--reload')
    end
  end
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new
