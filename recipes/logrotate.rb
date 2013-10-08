
begin
  include_recipe "logrotate"

  logrotate_app "radicale" do
    cookbook "logrotate"
    path "/var/log/radicale.log"
    options ["missingok", "compress", "copytruncate"]
    frequency "weekly"
    create "644 radicale radicale"
    rotate 4
  end
rescue
  Chef::Log.error "radicale::logrotate requires the logrotate cookbook!"
end
