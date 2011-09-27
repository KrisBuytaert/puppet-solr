class solr::services {
	service {
		'solr':
			ensure => "stopped",
			enable => $::operatingsystem ? {
				default => "true",
				centos => "false",
			},
			require => File['solr initscript'];

		'tomcat6':
			ensure => running,
			enable => true,
			require => File['tomcat6.default'];
    }
}
