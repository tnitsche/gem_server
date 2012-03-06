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
