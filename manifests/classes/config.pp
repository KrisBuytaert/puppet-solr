class solr::config {
	file {
		'solr initscript':
			ensure => "present",
			path => '/etc/init.d/solr',
			owner => "root",
			group => "root",
			mode  => "0755",
			content => 'solr/solr.init';

		'solr conf':
			ensure => present,
			path => '/usr/share/solr/solr.xml',
			owner => root,
			group => root,
			mode => '0755',
			content => template('solr/solr.xml.erb');
	}
}
