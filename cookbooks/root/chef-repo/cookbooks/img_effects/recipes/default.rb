#
# Cookbook Name:: img_effects
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

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

package 'ffmpeg' do
 action :install
end

package 'imagemagick' do
 action :install
end

bash "getfiles" do
    user "root"
    cwd "/root/"
    code <<-EOH
    wget vm-110.alamo.futuregrid.org/rmq_rpc.py
    wget vm-110.alamo.futuregrid.org/sendphotostream.py
    chmod +x sendphotostream.py
    chmod +x rmq_rpc.py
    wget vm-110.alamo.futuregrid.org/images.tar.gz
    tar -xvf images.tar.gz
    mv sendvideo.py upload
    cd upload	
    convert image_%d.jpg[1-10] -sepia-tone 90% -mattecolor '#000000' -frame 15x15+15+0 image_%d.jpg[1-10] 
    ffmpeg -f image2 -r 1/5 -i "image_%d.jpg"  movie.mov
    python sendphotostream.py
    EOH
    notifies :create, "ruby_block[getfiles_run_flag]", :immediately
    not_if { node.attribute?("getfiles_complete") }
end

ruby_block "getfiles_run_flag" do
  block do
    node.set['getfiles_complete'] = true
    node.save
  end
  action :nothing
end



