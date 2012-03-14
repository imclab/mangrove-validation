#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'development'
require File.expand_path('../../config/boot',  __FILE__)
require Rails.root.join("config", "environment")
class ResqueWorkerDaemon < DaemonSpawn::Base
  def start(args)
    @worker = Resque::Worker.new('*') # Specify which queues this worker will process
    @worker.verbose = 1 # Logging - can also set vverbose for 'very verbose'
    @worker.work
  end

  def stop
    @worker.try(:shutdown)
  end
end

ResqueWorkerDaemon.spawn!({
  :processes => 5,
  :log_file => File.join(RAILS_ROOT, "log", "resque_worker.log"),
  :pid_file => File.join(RAILS_ROOT, 'tmp', 'pids', 'resque_worker.pid'),
  :sync_log => true,
  :working_dir => RAILS_ROOT,
  :singleton => true
})
