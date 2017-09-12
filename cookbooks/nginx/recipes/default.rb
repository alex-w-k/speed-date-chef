#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2017, Alexander Koch, All Rights Reserved.

apt_update

%w(nginx gcc autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev make).each do |pkg|
  package pkg
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action   [:start, :enable]
end
user 'deploy' do
  password '$1$opyc.vcj$Uzr74O/mHAoswYI2iKB2E/'
end

rbenv_user_install 'deploy' do
  user 'deploy'

end

rbenv_ruby '2.4.1' do
  user 'deploy'
end
