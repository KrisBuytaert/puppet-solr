import 'classes/*'

class solr (
	$backend = 'tomcat'
) {
	include solr::packages
	include solr::config
	include solr::services

	Class['solr::packages'] -> Class['solr::config'] -> Class['solr::services']
}
