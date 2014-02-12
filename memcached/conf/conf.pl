#!/usr/bin/perl

use utf8;

{

	# db information
	dsn    => "dbi:DB2:$ENV{DB_NAME}",
	user   => $ENV{DB_USER},
	pass   => $ENV{DB_PASS},
	schema => $ENV{DB_SCHEMA},

	#memcached server
	mem_server => [ $ENV{MEM_SERVER} ],

	#expire
	expire => 14401,

	#Accounting entries
	tables => {
		'dept_bi'         => [ 'id', 'dept_id', 'dept_bi', 'bi' ],
		'dept_matcher'    => [ 'id', 'db_id', 'matcher', 'memo' ],
		'dim_fch'         => [ 'id', 'name', 'valid', 'memo' ],
	},
};

