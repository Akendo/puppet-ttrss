class ttrss::app (
  $install_dir,
  $install_url,
  $version,
  $db_name,
  $db_host,
  $db_user,
  $db_password,
  $ttrss_owner,
  $ttrss_group,
  $ttrss_lang,
  $ttrss_plugin_dir,
) {
  validate_string($install_dir,$install_url,$version,$db_name,$db_host,$db_user,$db_password,$ttrss_owner,$ttrss_group, $ttrss_lang, $ttrss_plugin_dir)

  $ttrss_config = template("ttrss/ttrss_config.erb")
  ## Resource defaults
  File {
    owner  => $ttrss_owner,
    group  => $ttrss_group,
    # mode   => '0755',
  }
  Exec {
    path      => ['/bin','/sbin','/usr/bin','/usr/sbin'],
    cwd       => $install_dir,
    logoutput => 'on_failure',
    user      => $ttrss_owner,
    group     => $ttrss_group,
  }
  file { $install_dir:
    ensure  => directory,
    # recurse => true,
  }
  wget::fetch { "Install tt-rss":
    source      => "https://github.com/gothfox/Tiny-Tiny-RSS/archive/${version}.tar.gz",
    destination => "/${install_dir}/1.7.9.tar.gz",
    timeout     => 0,
    verbose     => false,
    require => File[$install_dir],
  }
  -> exec { 'Extract tt-rss':
    command => "tar zxvf ./${version}.tar.gz --strip-components=1",
    creates => "${install_dir}/index.php",
  }
  # Configure tt-rss
  file { "$install_dir/config.php":
    ensure   => file,
    content  => $ttrss_config,
    require  => File[$install_dir],
  }
}
