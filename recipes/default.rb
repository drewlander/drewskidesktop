#
# Cookbook:: drewskidesktop
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
powershell_script 'install chocolatey' do
code <<-EOH
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
EOH
end

%W{
  googlechrome 
  firefox
  vlc
  javaruntime
  jdk8
  flashplayerplugin
  adobereader
  dotnet3.5
  slack
  microsoft-teams
  mremoteng
  git.install
  googledrive
  itunes
  clementine
  cygwin
  cyg-get
  notepadplusplus.install
  7zip.install
  yarn
  virtualbox
  virtualbox.extensionpack 
  packer
  sysinternals
  mpv
  windirstat
  nunit.install
  autohotkey
}.each do |pkg|
  chocolatey_package pkg do
      action :upgrade
    end
end 

chocolatey_package 'vagrant' do
  action :upgrade
  returns [0, 3010]
end

remote_file "#{node['user']['homefolder']}/chromium_portable.zip" do
  source node['chromium']['portable_url']
  owner node['user']['username']
  action :create_if_missing
end

remote_file "#{node['user']['homefolder']}/chromium_portable.zip" do
  source node['chromium']['portable_url']
  owner node['user']['username']
  action :create_if_missing
end

powershell_script 'unzip chromium' do
code <<-EOH
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("#{node['user']['homefolder']}/chromium_portable.zip", "#{node['user']['homefolder']}/chromium_portable")
EOH
  only_if {! ::File.exist?("#{node['user']['homefolder']}/chromium_portable") }
end


remote_file "#{node['xmplay']['install_location']}/xmplay38.zip" do
  source node['xmplay']['download_url']
  owner node['user']['username']
  action :create_if_missing
end

powershell_script 'unzip xmplay' do
code <<-EOH
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("#{node['xmplay']['install_location']}/xmplay38.zip", "#{node['xmplay']['install_location']}/xmplay")
EOH
  only_if {! ::File.exist?("#{node['xmplay']['install_location']}/xmplay") }
end

