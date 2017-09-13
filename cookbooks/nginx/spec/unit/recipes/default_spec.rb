#
# Cookbook:: nginx
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nginx::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    packages = %w(nginx nodejs yarn postgresql postgresql-contrib libpq-dev)

    context 'it installs all packages' do
      packages.each do |pkg|
        it "installs #{pkg}" do
          expect(chef_run).to install_package(pkg)
        end
      end
    end

    users = %w(deploy)

    context 'it creates all user accounts' do
      users.each do |user|
        it "has user #{user}" do
          expect(chef_run).to create_user(user)
        end
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
