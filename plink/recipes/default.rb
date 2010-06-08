# adds R-project apt source
remote_file "/usr/local/bin/plink" do
  source "plink-1.07-x86_64"
  mode "0755"
  backup false
end
