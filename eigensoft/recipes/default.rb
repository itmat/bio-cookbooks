# depends on juanty apt-get sources
include_recipe "apt_jaunty"
# installs libg2c0 and liblapack-dev packages and dependencies
package "libg2c0"
package "liblapack-dev"
execute "symlink_liblapack" do
  command "ln -s /usr/lib/liblapack.so.3gf /usr/lib/liblapack.so.3"
  not_if "test -e /usr/lib/liblapack.so.3"
end
execute "symlink_libatlas" do
  command "ln -s /usr/lib/libatlas.so.3gf /usr/lib/libatlas.so.3"
  EOH
  not_if "test -e /usr/lib/libatlas.so.3"
end

# installs eigensoft 3.0
directory "/tmp/eig" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if "test -d /tmp/eig"
end
remote_file "/tmp/eig/EIG3.0.tar.gz" do
  source 'http://www.hsph.harvard.edu/faculty/alkes-price/files/EIG3.0.tar.gz'
end

script "install_eigensoft" do
  interpreter "bash"
  user "root"
  cwd "/tmp/eig"
  code <<-EOH
  tar -x -z -f EIG3.0.tar.gz
  cp bin/* /usr/local/bin/.
  mkdir -p /broad/tools
  ln -s /usr/lib /broad/tools/lib
  ln -s /usr/lib64 /broad/tools/lib64
  EOH
end