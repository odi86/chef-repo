#
# Cookbook Name:: web_host
# Definition:: php_host
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

define :php_host do
   
  name = params[:name]
  
  host_user = params[:user] || "www-#{name}"
  host_group = params[:group] || "www-#{name}"
  
  host_dir = params[:root_dir] || "/srv/#{name}"
  
  user host_user do
    system true
    shell "/bin/false"
  end
  
  group host_group do
    members [host_user]
  end
  
  directory host_dir do
    owner host_user
    group host_group
    mode "0755"
    action :create
  end
  
  fpm_pool name do
    user  host_user
    group host_group
  end
  
  host name do
    template "php_site.erb"
    server_name params[:server_name] || name
    indexes %w{index.php}
    root_dir host_dir
  end
end