# == Class: ttrss
#
# This module manages ttrss
#
# === Parameters
#
# [*install_dir*]
#   Specifies the directory into which ttrss should be installed. Default:
#   /opt/ttrss
#
# [*install_url*]
#   Specifies the url from which the ttrss tarball should be downloaded.
#   Default: http://ttrss.org
#
# [*version*]
#   Specifies the version of ttrss to install. Default: 3.5
#
# [*create_db*]
#   Specifies whether to create the db or not. Default: true
#
# [*create_db_user*]
#   Specifies whether to create the db user or not. Default: true
#
# [*db_name*]
#   Specifies the database name which the ttrss module should be configured
#   to use. Default: ttrss
#
# [*db_host*]
#   Specifies the database host to connect to. Default: localhost
#
# [*db_user*]
#   Specifies the database user. Default: ttrss
#
# [*db_password*]
#   Specifies the database user's password in plaintext. Default: password
#
# [*ttrss_owner*]
#   Specifies the owner of the ttrss files. Default: root
#
# [*ttrss_group*]
#   Specifies the group of the ttrss files. Default: 0 (*BSD/Darwin
#   compatible GID)
#
# [*ttrss_lang*]
#   ttrss Localized Language. Default: ''
#
#
# [*ttrss_plugin_dir*]
#   ttrss Plugin Directory. Full path, no trailing slash. Default: ttrss Default
# === Requires
#
# === Examples
#
class ttrss (
  $install_dir    = '/opt/tt-rss',
  $install_url    = 'http://tt-rss.org',
  $version        = '1.7.9',
  $create_db      = true,
  $create_db_user = true,
  $db_name        = 'ttrss',
  $db_host        = 'localhost',
  $db_user        = 'ttrss',
  $db_password    = 'password',
  $ttrss_owner       = 'www-data',
  $ttrss_group       = 'www-data',
  $ttrss_lang        = '',
  $ttrss_plugin_dir  = 'DEFAULT'
) {
  class { 'ttrss::app':
    install_dir   => $install_dir,
    install_url   => $install_url,
    version       => $version,
    db_name       => $db_name,
    db_host       => $db_host,
    db_user       => $db_user,
    db_password   => $db_password,
    ttrss_owner      => $ttrss_owner,
    ttrss_group      => $ttrss_group,
    ttrss_lang       => $ttrss_lang,
    ttrss_plugin_dir => $ttrss_plugin_dir,
  }
  -> class { 'ttrss::db':
    install_dir   => $install_dir,
    create_db      => $create_db,
    create_db_user => $create_db_user,
    db_name        => $db_name,
    db_host        => $db_host,
    db_user        => $db_user,
    db_password    => $db_password,
  }
}
