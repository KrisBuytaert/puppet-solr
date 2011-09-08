class solr::services {
	service {
		'solr':
			ensure => "stopped",
			enable => "true",
			require => File['solr initscript'];

		'tomcat6':
			ensure => running,
			enable => true,
			require => File['tomcat6.default'];
    }
}
