require 'fileutils'

desc 'alias for init:all'
task :init => "init:all"

namespace :init do
  task :default => [ :all ]

  desc 'initialize everything'
  task :all => [ :tmp_dirs, :log_dirs, :gems_dirs ]

  desc 'create required directories in the tmp hierarchy'
  task :tmp_dirs do
    %w( tmp/pids).each do |d|
      unless File.exists?( d )
        mkdir_p d
      end
    end
  end

  desc 'create required directories for logging'
  task :log_dirs do
    %w( log ).each do |d|
      unless File.exists?( d )
        mkdir_p d
      end
    end
  end

  desc 'create directories for gem upload'
  task :gems_dirs do
    %w( public/system ).each do |d|
      unless File.exists?( d )
        mkdir_p d
      end
    end
  end
end

namespace :gem_server do
  desc 'start gem server'
  task :start do
    sh "bundle exec unicorn -c ./config/unicorn.rb -D -E production"
  end

  desc 'stop gem server'
  task :stop do
    sh %{ kill `cat tmp/pids/unicorn.pid` }
  end


  desc 'restart gem server'
  task :restart do
    Rake::Task["gem_server:stop"].execute
    Rake::Task["gem_server:start"].execute
  end

  desc 'reload gem server'
  task :reload do
    sh %{ kill -s USR2 `cat tmp/pids/unicorn.pid` }
  end

end 
