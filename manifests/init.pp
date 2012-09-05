class solr (
  $backend = 'tomcat',
  $root = '/usr/share/solr',
  $home = '/var/lib/solr',
  $tomcat_root = $::operatingsystem ? {
    default => '/var/lib/tomcat6',
    centos  => '/usr/share/tomcat6',
  },
  $tomcat_user = $::operatingsystem ? {
    default => 'tomcat',
    debian  => 'tomcat6',
  },
  $tomcat_group = $::operatingsystem ? {
    default => 'tomcat',
    debian  => 'tomcat6',
  },
  $version = '3.6.1',
  $persistent = 'false',
  $shareschema = 'true',
  $masterurl = 'http://solrmaster:8080/solr/'

)
{
  include solr::packages
  include solr::config
  include solr::services

  Class['solr::packages'] -> Class['solr::config'] -> Class['solr::services']
}
