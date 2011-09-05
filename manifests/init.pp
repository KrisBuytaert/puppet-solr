import 'classes/*'

class solr (
	$backend = 'tomcat'
) {
	class {
		'solr::config':
			before => Class['solr::services'];
		'solr::services':;
	}
	if $::operatingsystem == debian {
		class {
			'solr::source':
				before => Class['solr::config'];
		}
	} else {
		class {
			'solr::packages':
				before => Class['solr::config'];
		}
	}

	Exec {
		path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
	}
}
