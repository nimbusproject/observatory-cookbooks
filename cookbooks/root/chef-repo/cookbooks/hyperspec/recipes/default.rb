#
# Cookbook Name:: photostream
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

### Core files required by HSCal:
### OpenEXR, NetCDF, SDL, OpenGL

package 'libopenexr6' do
 action :install
end

package 'libnetcdf6' do
 action :install
end

package 'libsdl1.2debian' do
 action :install
end

package 'libsdl-ttf2.0-0' do
 action :install
end

package 'libgl1-mesa-swx11' do
 action :install
end

package 'libgl1-mesa-glx' do
 action :install
end

# Download and install HSCal spectral calibrator program
bash "getfiles" do
    user "root"
    cwd "/root/"
    code <<-EOH
    wget vm-110.alamo.futuregrid.org/hscal_data.tar
    wget vm-110.alamo.futuregrid.org/hscal.tar.gz
    tar -xzf hscal.tar.gz
    tar -xf hscal_data.tar
    cd hscal
    make install
    EOH
    notifies :create, "ruby_block[getfiles_run_flag]", :immediately
    not_if { node.attribute?("getfiles_complete") }
end

ruby_block "getfiles_run_flag" do
  block do
    node.set['getfiles_complete'] = true
    node.save
  end

end

#bash "cron" do
    #user "root"
    #cwd "/root/"
    #code <<-EOH
    #crontab -l >> mycron
    #echo "*/2 * * * * cd upload; python sendphotostream2.py" > mycron
    #echo "*/3 * * * * cd upload; python sendphotostream3.py" >> mycron
    #crontab mycron
    #rm mycron
    #EOH
    #notifies :create, "ruby_block[cron_run_flag]", :immediately
    #not_if { node.attribute?("cron_complete") }
#end

#ruby_block "cron_run_flag" do
#  block do
#    node.set['cron_complete'] = true
#    node.save
#  end
#  action :nothing
#end


