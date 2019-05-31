#
# Cookbook:: nginx_proxy
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.


include_recipe 'nginx'

package 'nginx'

service 'nginx' do
  action [:enable, :start]
end

template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  variables proxy_port: node['nginx']['proxy_port']
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default;' do
  notifies :restart, 'service[nginx]'
  action :delete
end
