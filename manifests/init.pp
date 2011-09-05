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
}
