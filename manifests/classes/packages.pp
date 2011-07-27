class solr::packages {
    package {
		'java':
			ensure => present,
			name => $operatingsystem ? {
				'Centos' => $operatingsystemrelease ? {
					'6.0' => "java-1.6.0-openjdk.$hardwaremodel",
					'*' => 'openjdk-6-jre',
				},
				'*' => 'openjdk-6-jre',
			};

		'solr':
			ensure => present;

		'tomcat':
			ensure => present,
			name => 'tomcat6';
	}
}
