dist_name = node['platform_version'].to_f < 12.04 ? "lucid" : "precise"

apt_repository "nginx" do
  uri "http://ppa.launchpad.net/nginx/stable/ubuntu"
  distribution dist_name
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
end

include_recipe "nginx"

r = resources('package[nginx]')
r.instance_eval do
  package_name 'nginx-extras'
end

template "nginx.conf" do
  cookbook "cloudfoundry-nginx"
end
