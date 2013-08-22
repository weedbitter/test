$str = "三代建行易宝通对私2013-07-07.csv";

$str =~/(.*)(\d{4}-\d{2}-\d{2})\.csv/;
print $1, " here \n";
print $2, " here \n"


