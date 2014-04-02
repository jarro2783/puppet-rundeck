# == Class: rundeck
#
# This will install rundeck (http://rundeck.org/) and manage it's configration and plugins
#
# === Requirements/Dependencies
#
# Currently reequires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*package_version*]
# The version of rundeck to be installed
#
# [*jre_name*]
# The name of the jre to be installed if using a custom jre.
#
# [*jre_version*]
# The version of the jre to be installed if using a custom jre.
#
# === Examples
#
# Installing rundeck with a custom jre:
#
# class { 'rundeck':
#   jre_name    => 'openjdk-7-jre',
#   jre_version => '7u51-2.4.4-0ubuntu0.12.04.2'
# }
#
class rundeck (
  $package_version       = $rundeck::params::package_version,
  $jre_name              = $rundeck::params::jre_name,
  $jre_version           = $rundeck::params::jre_version,
  $auth_type             = $rundeck::params::auth_type,
  $auth_users            = $rundeck::params::auth_users,
  $properties_dir        = $rundeck::params::properties_dir,
  $log_dir               = $rundeck::params::log_dir,
  $owner                 = $rundeck::params::owner,
  $group                 = $rundeck::params::group,
  $rdeck_base            = $rundeck::params::rdeck_base,
  $ssl_enabled           = $rundeck::params::ssl_enabled,
  $server_name           = $rundeck::params::server_name,
  $server_hostname       = $rundeck::params::server_hostname,
  $server_port           = $rundeck::params::server_port,
  $server_url            = $rundeck::params::server_url,
  $cli_username          = $rundeck::params::cli_username,
  $cli_password          = $rundeck::params::cli_password,
  $projects_dir          = $rundeck::params::projects_dir,
  $var_dir               = $rundeck::params::var_dir,
  $tmp_dir               = $rundeck::params::tmp_dir,
  $plugin_dir            = $rundeck::params::plugin_dir,
  $ssh_keypath           = $rundeck::params::keypath,
  $ssh_user              = $rundeck::params::ssh_user,
  $ssh_timeout           = $rundeck::params::ssh_timeout,
  $projects_default_org  = $rundeck::params::projects_default_org,
  $projects_default_desc = $rundeck::params::projects_default_desc,
  $logs_dir              = $rundeck::params::logs_dir,
  $ssh_keypath           = $rundeck::params::ssh_keypath,
  $ssh_user              = $rundeck::params::ssh_user,
  $ssh_timeout           = $rundeck::params::ssh_timeout,
  $projects_organization = $rundeck::params::projects_default_org,
  $projects_description  = $rundeck::params::projects_default_desc,
  $rd_loglevel           = $rundeck::params::loglevel,
  $rss_enabled           = $rundeck::params::rss_enabled,
  $grails_server_url     = $rundeck::params::grails_server_url,
  $dataSource_dbCreate   = $rundeck::params::dataSource_dbCreate,
  $dataSource_url        = $rundeck::params::dataSource_url,
  $keystore              = $rundeck::params::keystore,
  $keystore_password     = $rundeck::params::keystore_password,
  $key_password          = $rundeck::params::key_password,
  $truststore            = $rundeck::params::truststore,
  $truststore_password   = $rundeck::params::truststore_password,
  $service_name          = $rundeck::params::service_name

) inherits rundeck::params {

  validate_re($package_version, '\d+\.\d+\.\d+')
  validate_string($jre_name)
  validate_string($jre_version)
  validate_re($auth_type, ['^file$', '^ldap$'])
  validate_hash($auth_users)
  validate_absolute_path($properties_dir)
  validate_absolute_path($log_dir)
  validate_string($owner)
  validate_string($group)
  validate_absolute_path($rdeck_base)
  validate_bool($ssl_enabled)
  validate_string($server_name)
  validate_string($server_hostname)
  validate_re($server_port, '\d{0,5}')
  validate_string($server_url)
  validate_re($cli_username, '[a-zA-Z0-9]{3,}')
  validate_string($cli_password)
  validate_absolute_path($projects_dir)
  validate_absolute_path($var_dir)
  validate_absolute_path($tmp_dir)
  validate_absolute_path($plugin_dir)
  validate_absolute_path($ssh_keypath)
  validate_re($ssh_user, '[a-zA-Z0-9]{3,}')
  validate_re($ssh_timeout, '[0-9]+')
  validate_string($projects_organization)
  validate_string($projects_description)
  validate_re($rd_loglevel, ['^ALL$', '^DEBUG$', '^ERROR$', '^FATAL$', '^INFO$', '^OFF$', '^TRACE$', '^WARN$'])
  validate_bool($rss_enabled)
  validate_string($grails_server_url)
  validate_string($dataSource_dbCreate)
  validate_string($dataSource_url)
  validate_absolute_path($keystore)
  validate_string($keystore_password)
  validate_string($key_password)
  validate_absolute_path($truststore)
  validate_string($truststore_password)
  validate_string($service_name)

  class { 'rundeck::install':
    jre_name        => $jre_name,
    jre_version     => $jre_version,
    package_version => $package_version
  } ->
  class { 'rundeck::config':
    auth_type             => $auth_type,
    auth_users            => $auth_users,
    properties_dir        => $properties_dir,
    owner                 => $owner,
    group                 => $group,
    ssl_enabled           => $ssl_enabled,
    server_name           => $server_name,
    server_hostname       => $server_hostname,
    server_port           => $server_port,
    server_url            => $server_url,
    cli_username          => $cli_username,
    cli_password          => $cli_password,
    rdeck_base            => $rdeck_base,
    projects_dir          => $projects_dir,
    var_dir               => $var_dir,
    tmp_dir               => $tmp_dir,
    logs_dir              => $logs_dir,
    plugin_dir            => $plugin_dir,
    ssh_keypath           => $ssh_keypath,
    ssh_user              => $ssh_user,
    ssh_timeout           => $ssh_timeout,
    projects_organization => $projects_organization,
    projects_description  => $projects_description,
    rd_loglevel           => $rd_loglevel,
    rss_enabled           => $rss_enabled,
    grails_server_url     => $grails_server_url,
    dataSource_dbCreate   => $dataSource_dbCreate,
    dataSource_url        => $dataSource_url,
    keystore              => $keystore,
    keystore_password     => $keystore_password,
    key_password          => $key_password,
    truststore            => $truststore,
    truststore_password   => $truststore_password
  } ->
  class { 'rundeck::service':
    service_name => $service_name
  } ->
  Class['rundeck']
}
