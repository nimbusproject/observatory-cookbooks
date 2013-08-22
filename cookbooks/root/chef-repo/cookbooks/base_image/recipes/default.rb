#
# Cookbook Name:: base_image
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribu

#bash "enable rabbit apt repo" do
 #   user "root"
  #  cwd "/root/"
   # code <<-EOH
  #  wget vm-103.alamo.futuregrid.org/rmq.py
  #  python rmq.py
  #  EOH
#end

execute 'apt-get-update' do
 command 'apt-get update'
end

package 'python-pip' do
 action :install
end

package 'git-core' do
 action :install
end

execute 'pika' do
 command 'pip install pika==0.9.8'
end

package 'rabbitmq-server' do
action :install
end

package 'nano' do
 action :install
end

package 'python-MySQLdb' do
 action :install
end

bash "getfiles" do
    user "root"
    cwd "/root/"
    code <<-EOH
    wget vm-110.alamo.futuregrid.org/anl.py
    wget vm-110.alamo.futuregrid.org/rmq_rpc.py
    wget vm-110.alamo.futuregrid.org/kill.py
    chmod +x anl.py
    chmod +x rmq_rpc.py
    chmod +x kill.py
    EOH
    notifies :create, "ruby_block[getfiles_run_flag]", :immediately
    not_if { node.attribute?("getfiles_complete") }
end


bash "cron" do
    user "root"
    cwd "/root/"
    code <<-EOH
    crontab -l >> mycron
    echo "*/1 * * * * ./anl.py" > mycron
    echo "*/50 * * * * ./kill.py" >> mycron 
    crontab mycron
    rm mycron 
    EOH
    notifies :create, "ruby_block[cron_run_flag]", :immediately
    not_if { node.attribute?("cron_complete") }
end

ruby_block "cron_run_flag" do
  block do
    node.set['cron_complete'] = true
    node.save
  end
  action :nothing
end

ruby_block "cron_run_flag" do
  block do
    node.set['cron_complete'] = true
    node.save
  end
  action :nothing
end

ruby_block "getfiles_run_flag" do
  block do
    node.set['getfiles_complete'] = true
    node.save
  end
  action :nothing
end










