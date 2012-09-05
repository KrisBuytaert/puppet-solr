class solr::packages {
  package {
    'solr':
      ensure => present,
      name => $::operatingsystem ? {
        Centos => 'solr',
        Debian => 'solr-common',
      };
  }
  package {
    'java':
      ensure => present,
      name => $::operatingsystem ? {
        'Centos' => $::operatingsystemrelease ? {
          /6\.[0-3]/ => "java-1.6.0-openjdk.$::hardwaremodel",
          '*' => 'openjdk-6-jre',
        },
        'Debian' => 'openjdk-6-jre-headless',
      };
  }
  package {
    'tomcat':
      ensure => present,
      name => 'tomcat6';
  }

}
