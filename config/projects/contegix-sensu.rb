
name "contegix-sensu"
maintainer "Contegix LLC"
homepage "https://www.contegix.com"

replaces        "contegix-sensu"
install_path    "/opt/contegix/sensu"
#build_version   Omnibus::BuildVersion.new.semver
build_version   "0.12.1"
build_iteration 5

# creates required build directories
dependency "preparation"

# sensu dependencies/components
dependency "ruby"
dependency "sensu"
dependency "perl"
dependency "curl"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
