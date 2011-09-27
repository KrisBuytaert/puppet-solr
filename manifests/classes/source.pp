class solr::source {
	exec {
		'grab_solr_source':
			command => 'wget http://apache.belnet.be//lucene/solr/3.3.0/apache-solr-3.3.0.tgz',
			creates => '/usr/share/apache-solr-3.3.0.tgz',
			cwd => '/usr/share';

		'unpack_solr_source':
			command => 'tar xzvf apache-solr-3.3.0.tgz',
			creates => '/usr/share/apache-solr-3.3.0',
			cwd => '/usr/share',
			unless => "test -d $solr::home",
			require => Exec['grab_solr_source'];

		'mv_solr_source':
			command => "mv apache-solr-3.3.0 $solr::home",
			cwd => '/usr/share',
			creates => "$solr::home",
			require => Exec['unpack_solr_source'];

		'install_solr_libs_into_tomcat':
			command => "cp $solr::home/example/solr -fr /var/lib/tomcat6/",
			creates => '/var/lib/tomcat6/solr',
			require => Exec['mv_solr_source'];

		'install_solr_into_tomcat':
			command => "cp $solr::home/dist/apache-solr-3.3.0.war /var/lib/tomcat6/webapps/solr.war",
			creates => '/var/lib/tomcat6/webapps/solr.war',
			require => Exec['install_solr_libs_into_tomcat'];
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

		'/var/lib/tomcat6/solr':
			ensure => directory,
			owner => $::operatingsystem ? {
				default => 'tomcat',
				debian => 'tomcat6',
			},
			group => $::operatingsystem ? {
				default => 'tomcat',
				debian => 'tomcat6',
			},
			require => Exec['install_solr_libs_into_tomcat'];
	}
}
