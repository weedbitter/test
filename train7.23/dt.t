#!/usr/bin/perl

use DateTime;

my $now = DateTime->now( 'time_zone' => 'local');

warn $now->ymd();
warn $now->ymd('');
warn $now->ymd('====');
warn $now->hms();
warn $now->hms('---');
warn $now->hms('');
