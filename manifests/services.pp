class solr::services {
  #  service {
  #  'solr':
  #    ensure => "running",
  #    enable => "true",
  #    require => File['solr initscript'];
  #}
  service { 'tomcat6':
    ensure   => 'running',
    enable => 'true',
  }

}
