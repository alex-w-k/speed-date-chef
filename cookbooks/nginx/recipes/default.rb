#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2017, Alexander Koch, All Rights Reserved.

apt_update

apt_repository 'yarn' do
  uri 'https://dl.yarnpkg.com/debian/'
  key 'https://dl.yarnpkg.com/debian/pubkey.gpg'
  distribution 'stable'
  components %w(main)
  action :add
end

packages = %w(nginx nodejs yarn postgresql postgresql-contrib libpq-dev)

packages.each do |pkg|
  package pkg
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action   [:start, :enable]
end

%w(sites-available sites-enabled conf.d).each do |leaf|
  directory File.join(node['nginx']['dir'], leaf) do
    mode  '0755'
  end
end

template "#{node['nginx']['dir']}/sites-available/default" do
  source 'default-site.erb'
  notifies :reload, 'service[nginx]', :delayed
end

user 'deploy' do
  password '$1$opyc.vcj$Uzr74O/mHAoswYI2iKB2E/'
end

rbenv_system_install 'root'

rbenv_ruby '2.4.1'

rbenv_gem 'bundler' do
  rbenv_version '2.4.1'
end
