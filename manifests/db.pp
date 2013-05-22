class ttrss::db (
  $create_db,
  $create_db_user,
  $db_name,
  $db_host,
  $db_user,
  $db_password,
  $install_dir,
) {
  validate_bool($create_db,$create_db_user)
  validate_string($db_name,$db_host,$db_user,$db_password,$install_dir)

  if $create_db {
    mysql::db { $db_name:
      user     => $db_user,
      password => $db_password,
      host     => $db_host,
      sql      => "${install_dir}/schema/ttrss_schema_mysql.sql",
      grant    => ['all'],
    }
  }
}
