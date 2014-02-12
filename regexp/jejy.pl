#!/usr/bin/perl
use strict;
use warnings;

my $je = shift;
if ( $je =~ /^\d+$/ )
{    #如果不是小数后两位格式，转换为两位小数格式
     warn($je .= '.00');
}
elsif ( $je =~ /^\d+\.\d$/ ) {
    warn($je .= '0');
}
elsif ( $je =~ /^\d+\.\d{2}$/ ) {
    warn($je);
}
else {
    warn("存在不合法日期：$je.");
}

