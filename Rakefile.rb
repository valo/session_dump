require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
 
unless Rake::Task.task_defined? "session_dump:release"
  Dir["#{File.dirname(__FILE__)}/tasks/**/*.rake"].sort.each { |ext| load ext }
end