require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'app'
  t.pattern = 'test/**/*_test.rb'
end

task default: :test