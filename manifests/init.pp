class solr (
	$backend = 'tomcat',
	$home = '/usr/share/solr',
	$tomcat_root = $::operatingsystem ? {
		default => '/var/lib/tomcat6',
		centos => '/usr/share/tomcat6',
	},
	$tomcat_user = $::operatingsystem ? {
		default => 'tomcat',
		debian => 'tomcat6',
	},
	$tomcat_group = $::operatingsystem ? {
		default => 'tomcat',
		debian => 'tomcat6',
	},
	$version = '1.4.1'
) {
  motd::register { 'solr': }

	class {
		'solr::packages':
			before => Class['solr::config'];
		'solr::source':
			require => Class['solr::packages'];
		'solr::config':
			before => Class['solr::services'];
		'solr::services':;
	}

	Exec {
		path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
	}
}
