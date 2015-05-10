require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'app' << File.expand_path('../test', __FILE__)
  t.pattern = 'test/**/*_test.rb'
end

task default: :test