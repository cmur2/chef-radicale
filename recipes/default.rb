
include_recipe "python"

python_pip 'radicale' do
  action :install
end

user "radicale"
group "radicale" do
  members ["radicale"]
end

directory "/opt/radicale" do
  owner "root"
  group "root"
  mode 00755
  recursive true
end

directory "/opt/radicale/collections" do
  owner "radicale"
  group "radicale"
  mode 00755
  recursive true
end

# rights users cert+key

file "/opt/radicale/config" do
  content node.generate_radicale_ini(node['radicale']['config'])
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[radicale]"
end

file "/opt/radicale/logging" do
  content node.generate_radicale_ini(node['radicale']['logging'])
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[radicale]"
end

template "/etc/init.d/radicale" do
  source "radicale.init.erb"
  owner "root"
  group "root"
  mode 00755
  variables ({
    :daemon => node['radicale']['daemon_binary']
  })
  notifies :restart, "service[radicale]"
end

service "radicale" do
  action [:enable, :start]
end

