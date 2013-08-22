           use Net::FTP;

           $ftp = Net::FTP->new("canna", Debug => 0)
             or die "Cannot connect to some.host.name: $@";

           $ftp->login("ck-pre", "ck-pre")
             or die "Cannot login ", $ftp->message;

           $ftp->cwd("/")
             or die "Cannot change working directory ", $ftp->message;

           $ftp->put("ftp.t")
             or die "put failed ", $ftp->message;

           $ftp->quit;


