#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'development'
require File.expand_path('../../config/boot',  __FILE__)
require Rails.root.join("config", "environment")

class ResqueSchedulerDaemon < DaemonSpawn::Base
  def start(args)
    Resque::Scheduler.verbose = true
    Resque::Scheduler.run
  end

  def stop
    Resque::Scheduler.shutdown
  end
end

ResqueSchedulerDaemon.spawn!({
  :log_file => File.join(RAILS_ROOT, "log", "resque_scheduler.log"),
  :pid_file => File.join(RAILS_ROOT, 'tmp', 'pids', 'resque_scheduler.pid'),
  :sync_log => true,
  :working_dir => RAILS_ROOT,
  :singleton => true
})
