class solr {

   file {
	"/etc/init.d/solr":
		owner => "root",
		group => "root",
		ensure => "present",
		mode  => "0755",
		source => "puppet:///modules/solr/solr",
    }

    package {
	   "openjdk-6-jre":
                        alias  => "java",
                        ensure => present;

   	   "solr":
                        ensure => present;

	}




    service {"solr":
        ensure => "running" ,
        enable => "true",
	require => File['/etc/init.d/solr'],
    }


}

