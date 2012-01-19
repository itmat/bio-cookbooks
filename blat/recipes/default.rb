#
# Cookbook Name:: blat
# Recipe:: default
#
# Copyright 2010, University of Pennsylvania
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_file "/tmp/blatSrc.zip" do
  source  "http://genome-test.cse.ucsc.edu/~kent/src/blatSrc.zip"
  checksum "b764828fdf8ef4c9994ae4b6148340a776493475edb573b6adf63ae7ca9b2629"
  backup false
  action :create_if_missing
end

bash "unzip blatSrc.zip" do
  cwd "/tmp"
  code "unzip blatSrc.zip"
  not_if "test -d /tmp/blastSrc"
end

bash "compile and install BLAT" do
  cwd "/tmp/blatSrc"
  not_if "test -x /usr/local/bin/blat"
  code <<-EOH
  sed -i -e 's/\-Werror//g' inc/common.mk
  mkdir -p ~/bin/x86_64
  MACHTYPE=x86_64 make
  cp ~/bin/x86_64/* /usr/local/bin/.
  EOH
end


