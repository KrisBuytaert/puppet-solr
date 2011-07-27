class solr::config {
	file {
		'solr initscript':
			ensure => "present",
			path => '/etc/init.d/solr',
			owner => "root",
			group => "root",
			mode  => "0755",
			content => 'solr/solr.init';
	}
}
