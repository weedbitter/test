#!/usr/bin/perl


$text = " this matches ' THIS' not 'THAT' ";

$text =~ m" ('TH..' )";

print " $1\n";


$text = ' This is an example of backreferences';

($example, $backreferences) = ($text =~ m" (exam).*(backref)" );
print "$example, $backreferences ,$1  ,$2 \n";

if ($text =~ m" (example).*(back)")

{

	print $1; # prints ' example' -- since the first parens match the text example.

	print $2; # prints ' back' -- since the second parens match the text back


}



## 1)正则表达式是“要么全部要么什么也没有”的处理
#
#  
#  2)如果正则表达式失败，反向引用不能得到赋值。
#
#
