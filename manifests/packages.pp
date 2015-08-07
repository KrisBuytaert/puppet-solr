class solr::packages {
  $solr_package = $::operatingsystem ? {
    Centos => 'solr',
    Debian => 'solr-common',
  }
  $java_package = $::operatingsystem ? {
    'Centos' => $::operatingsystemrelease ? {
      /6\.[0-3]/ => "java-1.6.0-openjdk.${::hardwaremodel}",
      '*' => 'openjdk-6-jre',
    },
    'Debian' => 'openjdk-6-jre-headless',
  }
  package {
    'solr':
      ensure => present,
      name   => $solr_package,
  }
  package {
    'java':
      ensure => present,
      name   => $java_package,
  }
  package {
    'tomcat':
      ensure => present,
      name   => 'tomcat6';
  }

}
