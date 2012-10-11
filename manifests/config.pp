class solr::config {
  file {
    # Not actually using this anymore as we are deploying in tomcat
    'solrinitscript':
      ensure  => 'present',
      path    => '/etc/init.d/solr',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template('solr/solr.init.erb');
    "${solr::home}":
      ensure  => 'directory',
      owner   => "${solr::tomcat_user}",
      group   => "${solr::tomcat_group}",
      mode    => '0755';
  }
  $warlocation = "${solr::root}/dist/apache-solr-${solr::version}.war"

  file { '/etc/tomcat6/Catalina/localhost/solr.xml':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('solr/Catalina.solr.xml.erb');
  }



  include concat::setup
  concat {"${solr::home}/solr.xml":
    # path    => "${solr::home}/solr.xml",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
  concat::fragment {'header':
    target  => "${solr::home}/solr.xml",
    order   => 0,
    content => template('solr/solr.xml.erb.head');
  }

  concat::fragment {'footer':
    target  => "${solr::home}/solr.xml",
    order   => 99,
    content => template('solr/solr.xml.erb.foot');
  }

}
