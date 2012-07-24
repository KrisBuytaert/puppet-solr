class solr::packages {
    package {
		'solr':
			ensure => present,
			name => $operatingsystem ? {
				Centos => 'solr',
				Debian => 'solr-common',
			};

		'java':
			ensure => present,
			name => $operatingsystem ? {
				'Centos' => $operatingsystemrelease ? {
					/6\.[0-3]/ => "java-1.6.0-openjdk.$hardwaremodel",
					'*' => 'openjdk-6-jre',
				},
				'Debian' => 'openjdk-6-jre-headless',
			};
	}

	@package {
		'tomcat':
			ensure => present,
			name => 'tomcat6';

		'jetty':
			ensure => present,
			name => 'jetty';

		'solr-tomcat':
			ensure => present;

		'solr-jetty':
			ensure => present;
	}

	if $operatingsystem == Debian {
		realize(Package["solr-$solr::backend"], Aptrepo['unstable'])
	}
}
