
name "sensu"
maintainer "Contegix LLC"
homepage "https://www.contegix.com"

replaces        "sensu"
install_path    "/opt/contegix/sensu"
#build_version   Omnibus::BuildVersion.new.semver
build_version   "0.12.1"
build_iteration 3

# creates required build directories
dependency "preparation"

# sensu dependencies/components
dependency "ruby"
dependency "sensu"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
