
begin
  include_recipe "logrotate"

  if log
    logrotate_app "radicale" do
      cookbook "logrotate"
      path "/var/log/radicale.log"
      options ["missingok", "compress", "copytruncate"]
      frequency "weekly"
      create "644 radicale radicale"
      rotate 4
    end
  end
rescue
  Chef::Log.error "radicale::logrotate requires the logrotate cookbook!"
end
