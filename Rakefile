task :play do
  sh './bin/gol'
end

task :bundle do
  sh 'bundle install'
end

task :cli do
  sh './bin/golc'
end

task default: %w(cli)
task install: %w(bundle default)
