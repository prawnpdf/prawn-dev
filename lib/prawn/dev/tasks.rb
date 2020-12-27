# frozen_string_literal: true

require 'rubygems/package_task'

unless Kernel.const_defined?('GEMSPEC')
  raise StandardError, 'GEMSPEC is not defined'
end

package_task = Gem::PackageTask.new(Gem::Specification.load(GEMSPEC))
package_task.define

built_gem_path = "pkg/#{package_task.package_name}.gem"
checksum_path = "checksums/#{File.basename built_gem_path}.sha512"

file built_gem_path do
  Rake::Task['package'].invoke
end

file checksum_path => built_gem_path do
  require 'digest/sha2'
  checksum = Digest::SHA512.new.hexdigest(File.read(built_gem_path))
  Dir.mkdir('checksums') unless Dir.exist?('checksums')
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

YARD::Rake::YardocTask.new do |t|
  t.options = ['--output-dir', 'doc/html']
end
task docs: :yard

require 'rubocop/rake_task'

RuboCop::RakeTask.new
