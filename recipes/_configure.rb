#
# Cookbook Name:: icinga
# Recipe:: _server_config_pnp4nagios
#
# Copyright 2012, Bigpoint GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'pnp4nagios::_define_services'

directory "#{node['apache']['dir']}/conf.d" do
  owner node[:apache][:user]
  group node[:apache][:group]
  recursive true
  mode 0744
end

# pnp4nagios templates
template "#{node['apache']['dir']}/conf.d/pnp4nagios.conf" do
  source 'pnp4nagios/pnp4nagios.conf.erb'
  owner 'root'
  group 'root'
  mode 0640
  notifies :reload, 'service[apache2]'
end
template '/etc/pnp4nagios/apache.conf' do
  source 'pnp4nagios/pnp4nagios.conf.erb'
  owner 'root'
  group 'root'
  mode 0640
end

template_path = value_for_platform_family(
  'rhel' => '/etc/sysconfig',
  'debian' => '/etc/default'
)
template "#{template_path}/npcd" do
  source 'pnp4nagios/npcd.erb'
  owner 'root'
  group 'root'
  mode 0640
  notifies :restart, 'service[npcd]'
end
template '/etc/pnp4nagios/process_perfdata.cfg' do
  source 'pnp4nagios/process_perfdata.cfg.erb'
  owner 'root'
  group 'root'
  mode 0644
end
template '/etc/pnp4nagios/config.php' do
  source 'pnp4nagios/pnp4nagios_config.php.erb'
  owner 'root'
  group node['apache']['user']
  mode 0640
end
