#
# Cookbook Name:: php-fpm
# Definition:: fpm_pool
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
 
define :fpm_pool, :template => "fpm_pool.conf.erb" do
   
  pool_name = params[:name]
  pool_dir = "/etc/php5/fpm/pool.d"
  
  template "#{pool_dir}/#{pool_name}.conf" do
    source params[:template]
    owner "root"
    group "root"
    mode 0644
    if params[:cookbook]
      cookbook params[:cookbook]
    end
    variables(
      :pool_name => pool_name,
      :user => params[:user],
      :group => params[:group],
      :socket_dir => "/var/run/php5"
    )
    notifies :restart, resources(:service => "php5-fpm"), :delayed
  end
end