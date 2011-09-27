class solr::packages {
    @package {
		'solr':
			ensure => present,
			name => $::operatingsystem ? {
				Centos => 'solr',
				Debian => 'solr-common',
			};

		'java':
			ensure => present,
			name => $::operatingsystem ? {
				'Centos' => "java-1.6.0-openjdk.$::hardwaremodel",
				'Debian' => 'openjdk-6-jre',
			};

		'tomcat':
			ensure => present,
			name => 'tomcat6',

		'jetty':
			ensure => present,
			name => 'jetty';

		'solr-tomcat':
			ensure => present;

		'solr-jetty':
			ensure => present;
	}

	realize(Package['java', 'tomcat'])

	if $::operatingsystem == 'somethingelse' {
		realize(Package['solr', "solr-$solr::backend"])
	}
}
