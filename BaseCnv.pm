# 3159mLT - Math::BaseCnv.pm created by Pip@CPAN.org to convert between 
#   arbitrary number bases... I'm totally addicted to bass =).

=head1 NAME

  BaseCnv - A small perl module which exports functions to quickly 
    convert between any number bases

=head1 SYNOPSIS

  use Math::BaseCnv;
  @numb = (  0, 2,  7, 42, 55, 57, 99, 127 );
  @cycl = ( 10, 2, 64,  7, 10 );
  print("Format: FromBass -> ToBass = ConvertedNumber\n");
  foreach $n (@numb) {
    printf("%-3d:", $n);
    for($i = 1; $i < @cycl; $i++) {
      $n = cnv($n, $cycl[$i - 1], $cycl[$i]);
      printf("%3d->%-3d=%-7s", $cycl[$i - 1], $cycl[$i], $n);
    }
    print("\n");
  }

       -- execution output:
  Format: FromBass -> ToBass = ConvertedNumber
  0  : 10->2  =0        2->64 =0       64->7  =0        7->10 =0  
  2  : 10->2  =10       2->64 =2       64->7  =2        7->10 =2  
  7  : 10->2  =111      2->64 =7       64->7  =10       7->10 =7  
  42 : 10->2  =101010   2->64 =g       64->7  =60       7->10 =42 
  55 : 10->2  =110111   2->64 =t       64->7  =106      7->10 =55 
  57 : 10->2  =111001   2->64 =v       64->7  =111      7->10 =57 
  99 : 10->2  =1100011  2->64 =1Z      64->7  =201      7->10 =99 
  127: 10->2  =1111111  2->64 =1_      64->7  =241      7->10 =127

=head1 DESCRIPTION

  BaseCnv provides a few simple functions for converting between 
    arbitrary number bases.  It is as fast as I currently know how to 
    make it (of course relying only on the lovely perl).  If you 
    would rather utilize an object syntax for number-bass conversion, 
    please see Ken Williams' <ken@forum.swarthmore.edu> fine 
    Math::BaseCalc module.

=head1 2DO

  better error checking
  handle fractional parts? umm but I like using '.' as a b64 char =(
        What else does BaseCnv need?

=head1 WHY?

  The reason I created BaseCnv was that I needed a simple way to 
    convert quickly between the 3 number bases I use most (10, 16, && 
    64).  It turned out that it was trivial to handle any number bass 
    that could be represented as characters.  High-bit ASCII proved 
    somewhat problemmatic but at least BaseCnv can convert between any
    possible bass between 2 && 128 which is more than I originally 
    needed.  I'm quite happy with it && employ b64() too much now =).

=head1 FUNCTIONS

  cnv($numb[,$from[,$tobs]]) - Convert the number contained in $numb 
    from its current number bass ($from) into the result number bass
    ($tobs).  If only $numb is provided, it will be converted to
    hexadecimal (bass 16) if it only contains valid decimal digits or
    it will be converted to decimal (bass 10) if it contains 
    hexadecimal digits or begins with '0x'.  If only $numb && $from are
    provided as parameters, cnv assumes that $numb is already in 
    decimal format && uses $from as the $tobs.  The normal (&& most 
    clear) usage is to provide all 3 parameters.

    cnv() is the only function that is exported from a normal 
      'use Math::BaseCnv;' command.  Other functions can be imported
      to local namespaces explicitly or with the following tags:
        :all - every function described here
        :hex - only dec() && hex()
        :b64 - only b10() && b64() && cnv()
        :dig - only dig() && diginit()

  b10($b64n) - A shortcut to convert the number given as a parameter 
    ($b64n) from bass 64 to decimal (bass 10).

  b64($b10n) - A shortcut to convert the number given as a parameter 
    ($b10n) from decimal (bass 10) to bass 64.

  dec($b16n) - A shortcut to convert the number given as a parameter 
    ($b16n) from hexadecimal (bass 16) to decimal (bass 10).

  hex($b10n) - A shortcut to convert the number given as a parameter 
    ($b10n) from decimal (bass 10) to hexadecimal (bass 16).

  dig(\@newd) - Assign the new digit character list to be used in 
    place of the default one.  dig() can also alternately accept a 
    string name matching one of the following predefined digit sets:
      'bin' => ['0', '1']
      'oct' => ['0'..'7']
      'dec' => ['0'..'9']
      'hex' => ['0'..'9', 'a'..'f']
      'HEX' => ['0'..'9', 'A'..'F']
      'b62' => ['0'..'9', 'a'..'z', 'A'..'Z']
      '64'  => ['A'..'Z', 'a'..'z', '0'..'9', '+', '/'] # MIME::Base64
      'b64' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_'] 
      '128' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_'... hi-bit chars
    If no \@newd list or digit set name is provided as a parameter, 
    dig() returns the current character list.  It's fine to have many
    more characters in your current digit set than will be used with
    your conversions (eg. using dig('128') works fine for any cnv()
    call with $from && $tobs params less than or equal to 128).

    An example of a \@newd parameter for a specified alternate digit 
      set for noval (bass 9) conversions is:
          dig( [ qw( n a c h o z   y u m ) ] );

  diginit() - Resets the used digit list to the initial default order
    of the predefined digit set: '128'.

=head1 NOTES

  The perl builtin hex() function takes a hex string as a parameter && 
    returns the decimal value (FromBass = 16, ToBass = 10) but this 
    notation seems counter-intuitive to me since the code implies that 
    a hex() function will turn your parameter into hexadecimal (ie. It 
    sounds like hex will hexify your parameter but it does not.) so 
    I've decided (maybe foolishly) to invert the notation for my 
    similar functions since it makes more sense to me this way && will
    be easier to remember (I've had to lookup hex() in the Camel book 
    many times already which was part of the impetus for this module...
    as well as the gut reaction that sprintf() is not a proper natural
    inverse function for hex()).  

  This means that my b64() function takes a decimal number as a 
    parameter && returns the bass64 equivalent (FromBass = 10, ToBass =
    64) && my b10() function takes a bass64 number (string) && returns 
    the decimal value (FromBass = 64, ToBass = 10).  My hex() function 
    overloads perl's builtin version with this opposite behavior so my 
    dec() function behaves like perl's normal hex() function.  I know 
    it's confusing && maybe bad form of me to do this but I like it 
    so much better this way that I'd rather go against the grain.  

  Please think of my dec() && hex() functions as meaning decify && 
    hexify.  Also the pronunciation of dec() is 'dess' (!'deck' as in 
    the inverse of 'ink' which -- && ++ have so improved upon).  After 
    reading the informative perl module etiquette guidelines, I now 
    appreciate the need to export as little as is necessary by default.  
    So to be responsible, I have limited BaseCnv exporting to only 
    cnv() under normal circumstances.  Please specify the other 
    functions you'd like to import into your namespace or use the tags 
    described above in the cnv() section like:
      'use Math::BaseCnv qw(:all !:hex);'

  Error checking is minimal at best so don't assume perfection... 
    yet =).  Detectable errors return -1.

  This module does not handle fractional number inputs because I like 
    using the dot (.) character as a standard bass64 digit since it 
    makes for clean filenames.

  I hope you find BaseCnv useful.  Please feel free to e-mail me any 
    suggestions || coding tips || notes of appreciation 
    ("app-ree-see-ay-shun").  Thank you.  TTFN.

=head1 LICENSE

  All source code should be free!  Code I have authority over is && 
    shall be!  Copyright (c) 2003, Pip Stuart.  Copyleft:  I license 
    this software under the GNU General Public License (version 2).  
    Please consult the Free Software Foundation (fsf.org) for important
    information about your freedom.

=head1 AUTHOR

  Pip Stuart <Pip@CPAN.org>

=cut

package Math::BaseCnv;
require Exporter;
@ISA         = qw(Exporter);
@EXPORT      = qw(cnv); # only export cnv() for 'use Math::BaseCnv;'
@EXPORT_OK   = qw(dec hex b10 b64 dig diginit); # other stuff optionally
%EXPORT_TAGS = ( 'all' => [ qw(cnv dec hex b10 b64 dig diginit) ],
                 'hex' => [ qw(    dec hex                    ) ],
                 'b64' => [ qw(cnv         b10 b64            ) ],
                 'dig' => [ qw(                    dig diginit) ] );
$VERSION     = '1.0.37SLNGN'; # major . minor . PipTimeStamp
my $PTVR     = $VERSION; $PTVR =~ s/^\d+\.\d+\.//; # strip major && minor
# See http://Ax9.org/pt?$PTVR && `perldoc Time::Frame::PT`

use strict;

my $d2bs = ''; my %bs2d = (); my $nega = '';
my %digsets = (
  'usr' => [], # this will be assigned if a dig(\@newd) call is made
  'bin' => ['0', '1'],
  'oct' => ['0'..'7'],
  'dec' => ['0'..'9'],
  'hex' => ['0'..'9', 'a'..'f'],
  'HEX' => ['0'..'9', 'A'..'F'],
  'b62' => ['0'..'9', 'a'..'z', 'A'..'Z'],
  '64'  => ['A'..'Z', 'a'..'z', '0'..'9', '+', '/'], # 0-63 from MIME::Base64
  'b64' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_'], # month:C:12 day:V:31
  '128' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_',  #  hour:N:23 min:x:59
    '', '', '', '', '', '', '', '', '', '', '', '', '', #  64-76
    '', '', '', '', '', '', '', '', '', '', '', '', '', #  77-89
    '!', '#', '$', '%', '&', '(', ')', '*', '+', ',', '-', '/', ':', #  90-102
    ';', '<', '=', '>', '@', '[', '\\',']', '^', '?', '{', '|', '}', # 103-115
    '~', '', 'Ä', 'Å', 'Ç', 'É', 'Ñ', 'Ö', 'Ü', 'á', 'à', 'â'], #116-127
);
diginit();

sub diginit { # reset digit character list to initial Dflt
  $d2bs = '128'; bs2init();
}
sub bs2init { # build hash of digit char keys to array index values
  %bs2d = (); 
  for(my $i = 0; $i < @{ $digsets{$d2bs} }; $i++) { 
    $bs2d{${ $digsets{$d2bs} }[$i]} = $i;
  }
}
sub dig { # assign a new digit character list
  return( @{ $digsets{$d2bs} } ) unless(@_);
  if(ref $_[0]) {
    $d2bs = 'usr'; 
    $digsets{$d2bs} = [ @{ shift() } ];
  } else {
    my $setn = shift();
#    die "Unrecognized digit set '$setn'" unless(exists $digsets{$setn});
    return(-1) unless(exists $digsets{$setn});
    $d2bs = $setn;
  }
  diginit() unless(@{ $digsets{$d2bs} });
  bs2init();
}
sub cnv__10 { # convert from some number bass to decimal fast
  my $t = shift; my $s = shift || 64; my $n = 0;
  $nega = ''; $nega = '-' if($t =~ s/^-//);
  foreach(split(//, $t)) { return(-1) unless(exists $bs2d{$_}); }
  while(length($t)) { $n += $bs2d{substr($t,0,1,'')}; $n *= $s; } 
  return($nega . int($n / $s));
}
sub cnv10__ { # convert from decimal to some number bass fast
  my $n = shift || 0; my $s = shift || 64; my $t = '';
  return(-1) if($s > @{ $digsets{$d2bs} });
  $nega = ''; $nega = '-' if($n =~ s/^-//);
  while($n) { $t = $digsets{$d2bs}->[($n % $s)] . $t; $n = int($n / $s); }
  if(length($t)) { $t = $nega . $t; }
  else           { $t = 0; }
  return($t);
}
sub cnv { # convert between any number bass
  my $numb = shift; return(-1) if(!defined $numb || $numb =~ /^$/);
  my $fbas = shift; my $tbas = shift; 
  my $rslt = "";    my $temp = 0;
  
  return(0) if($numb =~ /^-?0+$/); # lots of (negative?) zeros is just zero
  if(!defined($tbas)) { # makeup reasonable values for missing params
    if(!defined($fbas)) {
      $fbas = 10; $tbas = 16;
      $fbas = 16; $tbas = 10 if($numb =~ /^0x/i || ($numb =~ /[A-F]/i && $numb =~ /^[0-9A-F]+$/i));
    } else {
      $tbas = $fbas; $fbas = 10;
    }
  }
  $fbas = 16 if($fbas =~ /\D/);
  $tbas = 10 if($tbas =~ /\D/);
  $numb =~ s/^0x//i if($fbas == 16);
  return(-1) if($fbas < 2 || $tbas < 2); # invalid bass error
  $numb = cnv__10($numb, $fbas) if($numb =~ /\D/ || $fbas != 10);
  $numb = cnv10__($numb, $tbas) if(                 $tbas != 10);
  return( $numb );
}
#  *Cnv     = \&cnv;
#  *BaseCnv = \&cnv;
#  *Convert = \&cnv;
# bah ... I don't need no verbose aliases ... my3 ltr abz are gud enf 4me =^)
sub dec { return(cnv__10(shift, 16)); }#shortcut for hexadecimal -> decimal
sub hex { return(cnv10__(shift, 16)); }#shortcut for decimal     -> hexadecimal
sub b10 { return(cnv__10(shift, 64)); }#shortcut for bass64      -> decimal
sub b64 { return(cnv10__(shift, 64)); }#shortcut for decimal     -> bass64

127;
