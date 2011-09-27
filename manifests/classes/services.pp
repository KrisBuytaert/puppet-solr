class solr::services {
	service {
		'solr':
			ensure => "stopped",
			enable => $::operatingsystem ? {
				default => "true",
				centos => "false",
			},
			require => File['solr initscript'];

		'tomcat':
			name => $::operatingsystemrelease ? {
				default => 'tomcat6',
				5.4 => 'tomcat5',
			},
			ensure => running,
			enable => true,
			require => File['tomcat6.default'];
    }
}
