define solr::core (
  $path = "${solr::home}/$name",
  $source = 'to be implemented')
  {
    concat::fragment {"$name":
      target  => "${solr::home}/solr.xml",
      order   => 15,
      content => template('solr/core.xml.erb');
  }

  file {"${path}":
    ensure => directory,
    owner  => "${solr::tomcat_user}",
    group  => "${solr::tomcat_group}",
    mode   => '0755',
  }

}

