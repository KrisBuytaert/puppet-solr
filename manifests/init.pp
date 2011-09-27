import 'classes/*'

class solr (
	$backend = 'tomcat',
	$home = '/usr/share/solr',
	$tomcat_root = $::operatingsystem ? {
		default => '/var/lib/tomcat6',
		centos => $::operatingsystemrelease ? {
			default => '/usr/share/tomcat6',
			5.4 => '/usr/share/tomcat5',
		},
	},
	$tomcat_user = $::operatingsystem ? {
		default => 'tomcat',
		debian => 'tomcat6',
	},
	$tomcat_group = $::operatingsystem ? {
		default => 'tomcat',
		debian => 'tomcat6',
	}
) {
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
