#
# Cookbook Name:: php-fpm
# Recipe:: manager
#
# Copyright 2012, Christian Häusler.
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

include_recipe "dotdeb::php53"

%w{php5-fpm php5-cgi}.each do |package|
  package "#{package}" do
    action :upgrade
  end
end

# This directory will contain the pid and socket files
directory "/var/run/php5/" do
  owner "root"
  mode "0755"
  action :create
end

file "/etc/php5/fpm/pool.d/*" do
  action :delete
end

cookbook_file "/etc/php5/fpm/php-fpm.conf" do
  source "php5-fpm.conf"
  mode 0644
  owner "root"
  group "root"
end

service "php5-fpm" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end