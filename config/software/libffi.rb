#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "libffi"
version "3.0.13"


# TODO: this link is subject to change with each new release of libffi.
# we'll need to use a more robust link (sourceforge) that will
# not change over time.
source :url => "ftp://sourceware.org/pub/libffi/libffi-#{version}.tar.gz",
       :md5 => "45f3b6dbc9ee7c7dfbbbc5feba571529"

relative_path "libffi-#{version}"
configure_env =
  case platform
  when "aix"
    {
      "LDFLAGS" => "-maix64 -L#{install_dir}/embedded/lib -Wl,-blibpath:#{install_dir}/embedded/lib:/usr/lib:/lib",
      "CFLAGS" => "-maix64 -I#{install_dir}/embedded/include",
      "LD" => "ld -b64",
      "OBJECT_MODE" => "64",
      "ARFLAGS" => "-X64 cru "
    }
  when "mac_os_x"
    {
      "LDFLAGS" => "-R#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib"
    }
  when "solaris2"
    if Omnibus.config.solaris_compiler == "studio"
    {
      "LDFLAGS" => "-R#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -static-libgcc",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -DNO_VIZ"
    }
    elsif Omnibus.config.solaris_compiler == "gcc"
    {
      "LDFLAGS" => "-R#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib -DNO_VIZ"
    }
    else
      raise "Sorry, #{Omnibus.config.solaris_compiler} is not a valid compiler selection."
    end
  else
    {
      "LDFLAGS" => "-Wl,-rpath #{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib",
      "PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig"
    }
  end

build do
  command ["./configure --prefix=#{install_dir}/embedded",
           "--libdir=#{install_dir}/embedded/lib",
	   "--includedir=#{install_dir}/embedded/include"].join(" ") , :env => configure_env
  command "make -j #{max_build_jobs}" , :env => configure_env
  command "make -j #{max_build_jobs} install"

  # force libs and include locations
  command "[ ! -d #{install_dir}/embedded/lib/libffi-#{version}/include ] || rsync -a #{install_dir}/embedded/lib/libffi-#{version}/include/ #{install_dir}/embedded/include/"
  command "rm -rf #{install_dir}/embedded/lib/libffi-#{version}/include"
  command "rmdir #{install_dir}/embedded/lib/libffi-#{version}"
  command "[ ! -d #{install_dir}/embedded/lib64 ] || rsync -a #{install_dir}/embedded/lib64/ #{install_dir}/embedded/lib/"
  command "rm -rf #{install_dir}/embedded/lib64/"
end
