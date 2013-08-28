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

#apt-get install make
#apt-get install libopenexr-dev libilmbase-dev libtiff-dev libnetcdf-dev libsdl1.2-dev libglu1-mesa-dev  libgl1-mesa-dev gcc g++ libgomp1 libgl1-mesa-glx libgl1-mesa-swx1 libgl1-mesa libxmu6 libopenexr6 libsdl1.2debian libsdl-ttf2.0-0

package 'make' do
 action :install
end

package 'libxi6' do
 action :install
end

package 'libxmu6' do
 action :install
end

package 'libglu1-mesa' do
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
    ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.4 /usr/lib/libtiff.so.5
    wget http://pages.uoregon.edu/~ekeever1/hscal.tar.gz
    wget http://pages.uoregon.edu/~ekeever1/hscal-source.tar.gz
    tar -xzf hscal.tar.gz
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


