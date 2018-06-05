require 'spec_helper'

HOME = ENV["HOME"]

describe file("#{HOME}/project/rails/workplan") do
	it { should be_directory }
	it { should be_owned_by("tamura") }
end

describe file("#{HOME}/run") do
	it { should be_directory }
	it { should be_owned_by("tamura") }
end

%w(ruby ruby-dev libgdbm-dev build-essential postgresql libpq-dev zlib1g-dev).each do |name|
    describe package(name) do
       it { should be_installed }
    end
end

describe package('bundler') do
	it { should be_installed.by("gem") }
end

describe command('ruby -v') do
	its(:stdout) { should match %r(ruby 2.5)}
end

describe command('gem -v') do
	its(:stdout) { should match %r(2.7)}
end

describe command('bundle -v') do
	its(:stdout) { should match %r(Bundler version 1.16)}
end

describe command('rails -v') do
	its(:stdout) { should match %r(Rails 5.0)}
end

describe command('node -v') do
	its(:stdout) { should match %r(v10.2)}
end

describe command('yarn --version') do
	its(:stdout) { should match %r(1.7.0)}
end

describe file("/etc/postgresql/10/main/postgresql.conf") do
	its(:content) { should match /shared_buffers = 1600MB/ }
	its(:content) { should match /temp_buffers = 32MB/ }
	its(:content) { should match /work_mem = 32MB/ }
	its(:content) { should match /maintenance_work_mem = 128MB/ }
	its(:content) { should match /wal_buffers = 16MB/ }
end

describe service('postgresql') do
  it { should be_enabled }
  it { should be_running }
end

describe port(5432) do
  it { should be_listening }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe command('curl http://localhost -o /dev/null -w "%{http_code}\n" -s') do
	its(:stdout) { should match /^200$/ }
end

describe port(8000) do
  it { should be_listening }
end

describe command('curl http://localhost:8000 -o /dev/null -w "%{http_code}\n" -s') do
	its(:stdout) { should match /^200$/ }
end

describe service('puma.service') do
  it { should be_enabled }
  it { should be_running }
end

describe package('postgresql') do
  it { should be_installed }
end

40.times do |n|
	id = "a%03d" % n
	describe user(id) do
		it { should exist }
	end
end