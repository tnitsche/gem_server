
listen 8808 # default gem server port 
worker_processes 2 # this should be >= nr_cpus
pid "./tmp/pids/unicorn.pid"
stderr_path "./log/unicorn.log"
stdout_path "./log/unicorn.log"
