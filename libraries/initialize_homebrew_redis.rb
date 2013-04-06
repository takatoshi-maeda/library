def initialize_homebrew_redis
  unless File.exists?("#{node.user.home}/homebrew.mxcl.redis.plist")
    script "regist redis plists" do
      interpreter "bash"
      flags "-e"
      code <<-"EOS"
      ln -sfv /usr/local/opt/redis/*.plist #{node.user.home}/Library/LaunchAgents
      launchctl load #{node.user.home}/Library/LaunchAgents/homebrew.mxcl.redis.plist
      EOS
    end
  end
  template "/usr/local/etc/redis.conf" do
    source "redis.conf.erb"
  end
end
