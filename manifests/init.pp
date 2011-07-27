import 'classes/*'

class solr {
	include solr::packages
	include solr::config
	include solr::services

	Class['solr::packages'] -> Class['solr::config'] -> Class['solr::services']
}
