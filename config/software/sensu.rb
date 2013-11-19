name "sensu"
version "0.12.1"

dependency "ruby"
dependency "rubygems"

build do
  gem "install sensu -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"

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
