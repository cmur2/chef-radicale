
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

if not node['radicale']['users'].empty?
  htpasswd_content = []
  
  node['radicale']['users'].each do |user,password|
    htpasswd_content << "#{user}:#{password}"
  end

  htpasswd_content << ''

  file node['radicale']['config']['auth']['htpasswd_filename'] do
    content htpasswd_content.join("\n")
    owner "root"
    group "root"
    mode 00640
    notifies :restart, "service[radicale]"
  end
end

if not node['radicale']['rights'].empty?
  file node['radicale']['config']['rights']['file'] do
    content generate_radicale_rights(node['radicale']['rights'])
    owner "root"
    group "root"
    mode 00644
    # no restart required as per doc
  end
end

execute "systemctl-daemon-reload" do
  command "systemctl daemon-reload || true"
  action :nothing
end

template "/etc/init.d/radicale" do
  source "radicale.init.erb"
  owner "root"
  group "root"
  mode 00755
  variables ({
    :daemon => node['radicale']['daemon_binary']
  })
  notifies :run, "execute[systemctl-daemon-reload]", :immediately
  notifies :restart, "service[radicale]"
end

service "radicale" do
  action [:enable, :start]
end

