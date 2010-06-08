# adds R-project apt source
remote_file "/etc/apt/sources.list.d/cran.list" do
  source "cran.list"
end

# adds the R-project pgp key that signs packages and listing
remote_file "/tmp/key.txt" do
  source "key.txt"
end
execute "apt-key add /tmp/key.txt"

# update the apt repo listings
execute "apt-get update"

# install base R and R dev for building package sources
package "r-base"
package "r-base-dev"
