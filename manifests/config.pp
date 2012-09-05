class solr::config {
  file {
    # Not actually using this anymore as we are deploying in tomcat
    'solr initscript':
      ensure => "present",
      path => '/etc/init.d/solr',
      owner => "root",
      group => "root",
      mode  => "0755",
      content => template('solr/solr.init.erb');

    'solr conf':
      ensure => present,
      path => '/usr/share/solr/solr.xml',
      owner => root,
      group => root,
      mode => '0755',
      content => template('solr/solr.xml.erb');
  }
  $warlocation = "${solr::home}/dist/apache-solr-${solr::version}.war"

  file { '/etc/tomcat6/Catalina/localhost/solr.xml':
      ensure => present,
      owner => root,
      group => root,
      mode => '0755',
      content => template('solr/Catalina.solr.xml.erb'),
  }


}

