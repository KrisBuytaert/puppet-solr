class solr::source {
	exec {
		'grab_solr_source':
			command => 'wget http://apache.belnet.be//lucene/solr/3.3.0/apache-solr-3.3.0.tgz',
			creates => '/usr/share/apache-solr-3.3.0.tgz',
			cwd => '/usr/share';

		'unpack_solr_source':
			command => 'tar xzvf apache-solr-3.3.0.tgz',
			creates => '/usr/share/solr',
			cwd => '/usr/share',
			require => Exec['grab_solr_source'];

		'install_solr_into_tomcat':
			command => 'cp /usr/share/apache-solr-3.3.0/dist/apache-solr-3.3.0.war /var/lib/tomcat6/webapps/solr.war',
			creates => '/var/lib/tomcat6/webapps/solr.war',
			require => Exec['unpack_solr_source'];
	}

	file {
		'tomcat6.default':
			ensure => present,
			path => '/etc/default/tomcat6',
			owner => root,
			group => root,
			mode => 0644,
			content => template('solr/tomcat6.default.erb'),
			require => Package['tomcat'];
	}
}
