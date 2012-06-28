class solr::source {
	exec {
		'grab_solr_source':
			command => "wget http://apache.belnet.be//lucene/solr/${solr::version}/apache-solr-${solr::version}.tgz",
			creates => "/usr/share/apache-solr-${solr::version}.tgz",
			cwd => '/usr/share';

		'unpack_solr_source':
			command => "tar xzvf apache-solr-${solr::version}.tgz",
			creates => "/usr/share/apache-solr-${solr::version}",
			cwd => '/usr/share',
			unless => "test -d $solr::home",
			require => Exec['grab_solr_source'];

		'mv_solr_source':
			command => "mv apache-solr-${solr::version} $solr::home",
			cwd => '/usr/share',
			creates => "$solr::home",
			require => Exec['unpack_solr_source'];

		'install_solr_libs_into_tomcat':
			command => "cp $solr::home/example/solr -fr $solr::tomcat_root",
			creates => "$solr::tomcat_root/solr",
			require => Exec['mv_solr_source'];

		'install_solr_into_tomcat':
			command => "cp $solr::home/dist/apache-solr-${solr::version}.war $solr::tomcat_root/webapps/solr.war",
			creates => "$solr::tomcat_root/webapps/solr.war",
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

		"$solr::tomcat_root/solr":
			ensure => directory,
			owner => $solr::tomcat_user,
			group => $solr::tomcat_group,
			require => Exec['install_solr_libs_into_tomcat'];
	}
}
