
name "blacklight-sensu"
maintainer "Blacklight Ops, Inc."
homepage "https://www.blacklightops.com"

replaces        "blacklight-sensu"
install_path    "/opt/blacklight/sensu"
#build_version   Omnibus::BuildVersion.new.semver
build_version   "0.12.6"
build_iteration 1

# creates required build directories
dependency "preparation"

# sensu dependencies/components
dependency "ruby"
dependency "perl"
dependency "sensu"
dependency "ubersmithrb"

# version manifest file
dependency "version-manifest"

# config files
config_file "#{install_path}/etc/sysconfig/sensu"

exclude "\.git*"
exclude "bundler\/git"
