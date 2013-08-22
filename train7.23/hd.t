use Data::Hexdumper qw(hexdump);

print hexdump("abcdefg");

__END__

$data = "hello world"  x 100;
print hexdump(
  data           => $data, # what to dump
  # NB number_format is deprecated
  number_format  => 'S',   # display as unsigned 'shorts'
  start_position => 100,   # start at this offset ...
  end_position   => 148    # ... and end at this offset
);


print hexdump(
  "abcdefg",
  { output_format => '%4a : %C %S< %L> : %d' }
);

