#
# Cookbook Name:: nginx
# Definition:: host
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
 
define :host, :template => "default-site.erb", :port => 80, :server_aliases => [], :indexes => %w{index.html index.htm} do
   
  name = params[:name]
  config_dir = "#{node[:nginx][:dir]}/sites-available"
  
  template "#{config_dir}/#{name}" do
    source params[:template]
    owner "root"
    group "root"
    mode 0644
    variables(
      :params => params
    )
    notifies :reload, resources(:service => "nginx"), :delayed
  end
  
  nginx_site name
end