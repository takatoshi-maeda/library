provider = {}
if platform?("mac_os_x", "mac_os_x_server")
  include_recipe 'homebrew'
  provider = {:class => Chef::Provider::Package::Homebrew,
              :name => "homebrew"}
elsif platform?("redhat", "centos", "fedora")
  include_recipe 'yum'
  provider = {:class => Chef::Provider::Package::Yum,
              :name => "yum"}
elsif platform?("ubuntu")
  include_recipe 'apt'
  provider = {:class => Chef::Provider::Package::Apt,
              :name => "apt"}
end

node.packages.items.each do |pkg|
  package pkg do
    action :install
    provider provider[:class]
  end
  send("initialize_#{provider[:name]}_#{pkg}") if node.packages.initialize.include?(pkg)
end
