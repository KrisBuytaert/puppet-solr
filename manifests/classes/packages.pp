class solr::packages {
    package {
		'java':
			ensure => present,
			name => 'openjdk-6-jre';

		'solr':
			ensure => present;

	}
}
