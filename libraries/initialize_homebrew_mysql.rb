def initialize_homebrew_mysql
  unless File.exist?("#{node.user.home}/Library/LaunchAgents/homebrew.mxcl.mysql.plist")
    script "initialize mysql" do
      interpreter "bash"
      flags "-e"
      code <<-"EOS"
        unset TMPDIR
        mkdir -p /usr/local/var/mysql
        rm -f /usr/local/opt/mysql/my.cnf
        sudo mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
        mkdir -p ~/Library/LaunchAgents
        cp /usr/local/Cellar/mysql/#{`ls /usr/local/Cellar/mysql/`.chomp}/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/
        launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
      EOS
    end
  end
  template "/usr/local/var/mysql/my.cnf" do
    source "my.cnf.erb"
  end
end
