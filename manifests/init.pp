import 'classes/*'

class solr (
	$backend = 'tomcat',
	$home = '/usr/share/solr'
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
