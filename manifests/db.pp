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

  $sql = "${install_dir}/schema/ttrss_schema_mysql.sql"

  if $create_db {
    mysql::db { $db_name:
      user     => $db_user,
      password => $db_password,
      host     => $db_host,
      grant    => ['all'],
    } ->
    exec {"import schema":
      command     => "/usr/bin/mysql -u${db_user} -p'$db_password' -D ${db_name} < $sql",
      logoutput   => true,
      refreshonly => true,
      require     => Mysql::Db[$db_name],
      subscribe   => Mysql::Db[$db_name],
    }
  }
}

