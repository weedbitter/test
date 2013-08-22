       use Digest::MD5 qw(md5 md5_hex md5_base64);

        $data = "100000";
        $digest = md5($data);  
        warn "$digest\n";
        $digest = md5_hex($data);
        warn "$digest\n";
        $digest = md5_base64($data);
        warn "$digest\n";


