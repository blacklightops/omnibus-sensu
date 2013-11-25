name "sensu"
version "0.12.1"

dependency "ruby"
dependency "rubygems"
dependency "libffi"
dependency "nokogiri"
dependency "ffi"
dependency "curl"
dependency "libnetsnmp"

env = {	"PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig" }

build do
  gem "install sensu -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"
  gem "install sensu-cli -n #{install_dir}/bin --no-rdoc --no-ri"
  gem "install sensu-plugin -n #{install_dir}/bin --no-rdoc --no-ri"
  gem "install bunny --no-rdoc --no-ri" , :env => env
  gem "install net-ssh --no-rdoc --no-ri" , :env => env
  gem "install net-sftp --no-rdoc --no-ri" , :env => env
  gem "install net-dhcp --no-rdoc --no-ri" , :env => env
  gem "install net-dns --no-rdoc --no-ri" , :env => env
  gem "install net-ip --no-rdoc --no-ri" , :env => env
  gem "install net-ldap --no-rdoc --no-ri" , :env => env
  gem "install net-ntp --no-rdoc --no-ri" , :env => env
  gem "install net-ping --no-rdoc --no-ri" , :env => env
  gem "install net-snmp --no-rdoc --no-ri" , :env => env
  gem "install nori --no-rdoc --no-ri" , :env => env
  gem "install carrot-top --no-rdoc --no-ri" , :env => env
  gem "install dnsbl-client --no-rdoc --no-ri" , :env => env
  gem "install lxc --no-rdoc --no-ri" , :env => env
  gem "install mail --no-rdoc --no-ri" , :env => env
  gem "install redis --no-rdoc --no-ri" , :env => env
  gem "install rest-client --no-rdoc --no-ri" , :env => env
  gem "install snmp --no-rdoc --no-ri" , :env => env
  gem "install curb --no-rdoc --no-ri" , :env => env
  gem "install mechanize --no-rdoc --no-ri" , :env => env
  # remove documentation
  command "rm -rf #{install_dir}/embedded/docs"
  command "rm -rf #{install_dir}/embedded/share/man"
  command "rm -rf #{install_dir}/embedded/man"
  command "rm -rf #{install_dir}/embedded/share/doc"
  command "rm -rf #{install_dir}/embedded/ssl/man"
  command "rm -rf #{install_dir}/embedded/info"

  # load default configuration files
  command "rsync -a #{Omnibus.project_root}/files/ #{install_dir}/"
end
