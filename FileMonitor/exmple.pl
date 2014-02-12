#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use File::Monitor;
use File::Monitor::Delta;
use File::Monitor::Object;
use File::Find::Rule;
use POSIX qw(strftime);

#my @files=File::Find::Rule->not_name('.*.swp')->in('f:\mon','d:\24');  #这里可以写多个目录，我这里做测试是用win，linux同理
START:
my @files   = File::Find::Rule->not_name('.*.swp')->in('./data');
my $monitor = File::Monitor->new();
foreach my $file (@files) {
    $monitor->watch(
        {
            name    => "$file",
            recurse => 1,         #是否递归目录
        }
    );
}

while ( 1 and sleep 3 ) {         #每一秒检测一次
    my @changes = $monitor->scan;

#open FH,'>>F:\monitor_log\monitor.log' or die "$!";  #将变动的文件写入日志
    open FH, '>>./log/monitor.log' or die "$!";    #linux与win的路径
    for my $change (@changes) {
        my $name    = $change->name;
        my @created = $change->files_created;
        my @deleted = $change->files_deleted;
        if (@deleted) {
        }
        if (@created) {
            print FH
              "@created The created\n"; #如果有新文件则重新索引文件
            goto START;
        }
        if ( $change->is_mtime ) {      #判断是否为修改文件
            print FH $change->name . "======>";
            if ( $change->is_size ) {   #如果大小变化则判断变化多少
                my $old_size = ( $change->old_size ) || 0;
                my $new_size = ( $change->new_size ) || 0;
                print FH "has changed size from $old_size to $new_size"
                  . "====>";
            }
            my $time = $change->new_mtime;
            if ( defined $time ) {
                my $mtime = strftime( "%Y-%m-%d %H:%M:%S\n", localtime($time) );
                print FH "$mtime";
            }
        }
    }
    close FH;
}
