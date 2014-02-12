package Zmem;
use strict;
use warnings;
use feature qw(state);
use JSON;
use Data::Dump;

#
# 构造函数
#
sub new {
    my $class = shift;
    my $cfg   = shift;
    my $self  = bless {}, $class;
    $self->{cfg}  = $cfg;
    # 设置数据库相关
    $self->setup();

    return $self;
}


#
# 设置数据库相关
# $self->setup();
#
sub setup {
    my $self = shift;    
    $self->{sth} = {};
    my $tables = $self->{cfg}->{tables};
    for my $table ( keys %$tables ){
        my ($col , $val );
        for ( @{$tables->{$table}} ){
            if (defined $col) {
                $col  = $col . ',' . $_;
                $val  = $val . ',' . '?';
            }
            else {
                $col  = $_;
                $val  = '?';
            }
        }
        my $select_sql = "select $col from $table ";
        my $insert_sql = "insert into $table($col) values($val) "; 

        #print "$select_sql\n";
        #print "$insert_sql\n";
        my $sel = $self->{cfg}{dbh}->prepare($select_sql);
        my $ins = $self->{cfg}{dbh}->prepare($insert_sql);
        # 保存sth缓存
        $self->{sth}{sel}{$table}   = $sel;
        $self->{sth}{ins}{$table}   = $ins;
    }
    return $self;
}

#
# 初始化memcached 
# $self->init_memd();
#
sub init_memd {
    my $self = shift;    
    my $tables = $self->{cfg}->{tables};
    for my $table ( keys %$tables ){
        $self->_init_memd_table($table);
    }
    return $self;
}

#
# 刷新memcached 
# $self->refresh_memd();
#
sub refresh_memd {
    my $self = shift;    
    my $tables = $self->{cfg}->{tables};
    $self->{cfg}->{memd}->flush_all;
    for my $table ( keys %$tables ){
        $self->_refresh_table($table);
    }

    return $self;
}


#
#memcached 根据表明去数据 get方法
#$self->get_table($table);
#
sub get_table {
    my $self = shift;
    my $table = shift;
    return $self->{cfg}->{memd}->get($table);
}


sub insert {
    my $self = shift;
    my $table = shift;
    return $self->_insert($table,@_);
}



##########################################
######### 内部私有函数 ###################
##########################################

############################
# 关键内部函数(访问数据库) #
############################

#
# init memcached by table name
#
sub _init_memd_table {
    my $self = shift;
    my $table = shift;
    my $ret = 0;
    eval{
        $self->{sth}{sel}{$table}->execute();
        my $data = [];
        while(my $row = $self->{sth}{sel}{$table}->fetchrow_arrayref()) {
            push @$data, [@$row];
        }
        $data = JSON->new->utf8->encode($data);
        $ret = $self->{cfg}->{memd}->set($table , $data);
    };
    if ($@){
        warn "table : $table exits error, please check conf.pl";
        return -1;
    }
    $self->{sth}{sel}{$table}->finish();
    $self->{cfg}{dbh}->commit();
    return $ret;
}

#
#
#

sub _insert {
    my $self = shift;
    my $table = shift;
    my $memd_res;
    eval {
        $self->{sth}{ins}{$table}->execute(@_);
        $self->{sth}{ins}{$table}->finish();
        $memd_res = $self->_refresh_table($table);
    };
    if($@){
        warn "$@";
        $self->{cfg}{dbh}->rollback();
        return '-1';
    }
    unless ($memd_res){
        warn "memcached 同步失败！";
        $self->{cfg}{dbh}->rollback();
        return $memd_res;
    }
    $self->{cfg}{dbh}->commit();
    return 1;
}


#
# $self->refresh($table);
#

sub _refresh_table {
    my $self = shift;
    my $table = shift;
    return $self->_init_memd_table($table);
}

1;

__END__
#---------------------------------------------------
# Zmem对象结构
#---------------------------------------------------
# {
#       # 全局配置信息
#       cfg  => $cfg
#               $cfg = {
#                   dbh  => $dbh,           
#                   memd => $memd,
#                   cfg  => do conf,
#               }
#       # 数据库语句预编译缓存
#       sth => {
#           ins => {
#               $table  =>  {
#                   sql => DBI::st,
#                   },
#               },
#           },
#           sel => {
#               $table  =>  {
#                   sql => DBI::st,
#                   },
#               },
#           },
#       },
#  }
#---------------------------------------------------

