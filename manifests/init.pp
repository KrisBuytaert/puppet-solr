import 'classes/*'

class solr (
	$backend = 'tomcat'
) {
	class {
		'solr::packages':
			before => Class['solr::config'];
		'solr::config':
			before => Class['solr::services'];
		'solr::services':;
	}

	if $::operatingsystem == debian {
		class {
			'solr::source':
				require => Class['solr::packages'];
		}
	}

	Exec {
		path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
	}
}
