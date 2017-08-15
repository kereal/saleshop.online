# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

#every :day, :at => '03:00am' do
#  rake "app:import_all_goods"
#end

every :reboot do
  command 'cd /home/saleshop/saleshop.online/current && bundle exec puma -q -d -e production -b unix:///home/saleshop/saleshop.online/shared/tmp/sockets/puma.sock -S /home/saleshop/saleshop.online/shared/tmp/sockets/puma.state --pidfile /home/saleshop/saleshop.online/shared/tmp/pids/puma.pid --control unix:///home/saleshop/saleshop.online/shared/tmp/sockets/pumactl.sock'
end

every 3.hours do
  rake "app:import_all_goods"
end