        use IO::String;

        my $var; 
        $io = IO::String->new($var);

        $io->print("hello\nworld\n");
    
        warn "$var\n";
      
        warn "---------\n";
        my $i2 = IO::String->new($var);
        print <$i2>;
        print <$i2>;
        warn "---------\n";

#
#  sink
#  source
#
