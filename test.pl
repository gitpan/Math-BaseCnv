#!/usr/bin/perl -w
# 37K2jPD - test.pl created by Pip@CPAN.org to validate Math::BaseCnv
#     functionality.  
#   This script mimics Ken Williams' <ken@forums.swathmore.edu>
#     test cases for his Math::BaseCalc module.  I have included dig()
#     function calls with most tests out of respect for BaseCalc even
#     though the only necessary calls are the ones that set the 
#     digits to something other than '0'..'9', 'A'..'Z' since BaseCnv
#     initializes the digit list with good characters for any small
#     common number bases.  My timings showed BaseCnv to require 
#     about 3/4ths of the execution time needed by BaseCalc with all
#     the unnecessary dig() calls && about twice as fast when dig() is
#     only called when it must be.  BaseCalc may not need all the 
#     $calc->digits() calls either though so that last one is probably 
#     an unfair performance comparison.  Besides speed, conversion 
#     functions make more sense to me than objects ... even if perl's
#     hex() builtin is the opposite behavior of mine =).
#   Before `make install' is performed this script should be run with
#     `make test'.  After `make install' it should work as `perl test.pl'.

BEGIN { $| = 1; print "0..15\n"; }
END   { print "not ok 1\n" unless($loaded); }
use Math::BaseCnv qw(:all);

my $calc; my $result; my $TESTNUM = 0;
$loaded = 1;
&report(1);

sub report { # prints test progress
  my $bad = !shift;
  print "not " x $bad;
  print "ok ", $TESTNUM++, "\n";
  print @_ if $ENV{TEST_VERBOSE} and $bad;
}

#$calc = new Math::BaseCalc(digits=>[0,1]);
dig( [ '0', '1' ] );
$calc = 2;
&report($calc);

#$result = $calc->from_base('01101');
$result = cnv('01101', 2, 10);
&report($result == 13, "$result\n");

#$calc->digits('bin');
#$result = $calc->from_base('1101');
dig('bin'); 
$result = cnv('1101', 2, 10);
&report($result == 13, "$result\n");

#$result = $calc->to_base(13);
$result = cnv(13, 2); # omitting last param assumes first is already 10 to ?
&report($result eq '1101', "$result\n");

#$calc->digits('hex');
#$result = $calc->to_base(46);
dig('hex'); 
$result = hex(46);
&report($result eq '2e', "$result\n");

#$calc->digits([qw(i  a m  v e r y  p u n k)]);
#$result = $calc->to_base(13933);
dig( [ qw(i  a m  v e r y  p u n k) ] ); 
#$result = cnv(13933, 10, 11); 
$result = cnv(13933, scalar( dig() )); # empty dig() returns the char array
&report($result eq 'krap', "$result\n");

#$calc->digits('hex');
#$result = $calc->to_base('-17');
dig('hex'); 
$result = hex(-17);
&report($result eq '-11', "$result\n");

#$calc->digits('hex');
#$result = $calc->from_base('-11');
dig('hex'); 
$result = dec(-11);
&report($result eq '-17', "$result\n");

# no fractions in BaseCnv!  ...
#  $calc->digits('hex');
#  $result = $calc->from_base('-11.05');
#  &report($result eq '-17.01953125', "$result\n");
#  
#  $calc->digits([0..6]);
#  $result = $calc->from_base('0.1');
#  &report($result eq (1/7), "$result\n");

# ... so do two more dig tests instead
dig( [ qw(i  a m  v e r y  p u n k) ] ); 
$result = cnv(13542, scalar( dig() )); 
&report($result eq 'kaka', "$result\n");

dig( [ qw( n a c h o z   y u m ) ] );
$result = cnv(lc('MunchYummyNachoChz'), 9, 10);
&report($result eq '1.46443919598918e+17', "$result\n");

# Test large numbers && dec/hex functions
#$calc->digits('hex');
#my $r1 = $calc->to_base(2**55 + 5);
#$result = $calc->from_base($calc->to_base(2**55 + 5));
#warn "res: $r1, $result";
dig('hex'); 
$calc   =       hex(2**55 + 5);
$result =   dec(hex(2**55 + 5));
&report($result eq (2**55 + 5), "$result\n");

#$calc->digits('bin');
#my $first  = $calc->from_base('1110111');
#my $second = $calc->from_base('1010110');
#my $third = $calc->to_base($first * $second);
dig('bin');
my $first  = cnv('1110111',           2, 10);
my $second = cnv('1010110',           2, 10);
my $third  = cnv(($first * $second),      2);
&report($third eq '10011111111010', "$third\n");

# Test b10/b64 functions
diginit();
$result = b64(1234567890); # 10 bass10 digits is only 6 bass64 digits
&report($result eq '19bWBI', "$result\n");

$result = b10('TheBootyBoys.com'); # Around The Corner =)
&report($result eq '3.6744147055401e+28', "$result\n");

$result = b10( b64( 127 ) );
&report($result eq '127', "$result\n");
