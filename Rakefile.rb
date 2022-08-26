task default: %w[test]

desc 'Run tests'
task :test do
  sh 'bundle exec rspec spec'
end
