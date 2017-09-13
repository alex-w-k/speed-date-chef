# # encoding: utf-8

# Inspec test for recipe speed-date::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  describe user('root') do
    it { should exist }
  end

  describe user('deploy') do
    it { should exist }
  end
end

describe file('/etc/apt/sources.list.d/yarn.list') do
  it { should exist }
end

describe apt('yarn') do
  it { should exist }
  it { should be_enabled }
end

packages = %w(nginx nodejs yarn postgresql postgresql-contrib libpq-dev)

packages.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe port(80) do
  it { should be_listening }
end

describe port(22) do
  it { should be_listening }
end

describe port(23) do
  it { should_not be_listening }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
  its('exit_status') { should eq 0 }
  its('stdout') { should include('2.4.1') }
end

describe bash('/usr/local/rbenv/versions/2.4.1/bin/gem list --local') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/bundler/) }
end

describe user('postgres') do
  it { should exist }
end

describe command('curl localhost') do
  its('stdout') { should match /Welcome to nginx!/ }
end
