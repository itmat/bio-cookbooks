remote_file "/etc/apt/sources.list.d/jaunty.list" do
  source "jaunty.list"
  not_if 
end

execute "apt_get_update" do
  command "apt-get update"
  action :run
end
