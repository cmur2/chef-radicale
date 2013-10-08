
begin
  include_recipe "logrotate"

  logrotate_app "radicale" do
    cookbook "logrotate"
    path "/var/log/radicale.log"
    options ["missingok", "compress", "copytruncate"]
    frequency "weekly"
    create "640 radicale radicale"
    rotate 4
    postrotate "invoke-rc.d radicale restart > /dev/null"
  end
rescue
  Chef::Log.error "radicale::logrotate requires the logrotate cookbook!"
end
