# 3159mLT - Math::BaseCnv.pm created by Pip@CPAN.Org to convert between 
#   arbitrary number bases.  I'm totally addicted to bass!

=head1 NAME

Math::BaseCnv - fast functions to convert between number bases

=head1 VERSION

This documentation refers to version 1.0.428LV46 of 
Math::BaseCnv, which was released on Sun Feb  8 21:31:04:06 2004.

=head1 SYNOPSIS

  use Math::BaseCnv;

  # Convert 63 from base-10 (decimal) to base-2 (binary)
  $binary_63 = cnv( 63, 10, 2 ); 

=head1 DESCRIPTION

BaseCnv provides a few simple functions for converting between 
arbitrary number bases.  It is as fast as I currently know how to 
make it (of course relying only on the lovely perl).  If you 
would rather utilize an object syntax for number-base conversion, 
please see Ken Williams's <ken@forum.swarthmore.edu> fine 
Math::BaseCalc module.

=head1 2DO

=over 2

=item - better error checking

=item - handle fractional parts? umm but I like using '.' as a b64 char
          so ',' comma as separator?

=item -    What else does BaseCnv need?

=back

=head1 WHY?

The reason I created BaseCnv was that I needed a simple way to 
convert quickly between the 3 number bases I use most (10, 16, and 
64).  It turned out that it was trivial to handle any number base 
that could be represented as characters.  High-bit ASCII proved 
somewhat problemmatic but at least BaseCnv can convert between any
possible base between 2 and 128 which is more than I originally 
needed.  I'm quite happy with it and employ b64() too much now =).
I'm totally addicted to bass!

=head1 USAGE

=head2 cnv($numb[,$from[,$tobs]])

Convert the number contained in $numb 
from its current number base ($from) into the result number base
($tobs).  If only $numb is provided, it will be converted to
hexadecimal (base 16) if it only contains valid decimal digits or
it will be converted to decimal (base 10) if it contains 
hexadecimal digits or begins with '0x'.  If only $numb and $from are
provided as parameters, cnv assumes that $numb is already in 
decimal format and uses $from as the $tobs.  The normal (and most 
clear) usage is to provide all 3 parameters.

cnv() is the only function that is exported from a normal 
use Math::BaseCnv;' command.  Other functions can be imported
to local namespaces explicitly or with the following tags:

    :all - every function described here
    :hex - only dec() and hex()
    :b64 - only b10() and b64() and cnv()
    :dig - only dig() and diginit()

=head2 b10($b64n)

A shortcut to convert the number given as a parameter 
($b64n) from base 64 to decimal (base 10).

=head2 b64($b10n)

A shortcut to convert the number given as a parameter 
($b10n) from decimal (base 10) to base 64.

=head2 dec($b16n)

A shortcut to convert the number given as a parameter 
($b16n) from hexadecimal (base 16) to decimal (base 10).

=head2 hex($b10n)

A shortcut to convert the number given as a parameter 
($b10n) from decimal (base 10) to hexadecimal (base 16).

=head2 dig(\@newd)

Assign the new digit character list to be used in 
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
    '128' => ['0'..'9', 'A'..'Z', 'a'..'z', '.', '_'... higher chars

If no \@newd list or digit set name is provided as a parameter, 
dig() returns the current character list.  It's fine to have many
more characters in your current digit set than will be used with
your conversions (eg. using dig('128') works fine for any cnv()
call with $from and $tobs params less than or equal to 128).

An example of a \@newd parameter for a specified alternate digit 
set for noval (base 9) conversions is:

    dig( [ qw( n a c h o z   y u m ) ] );

=head2 diginit()

Resets the used digit list to the initial default order
of the predefined digit set: '128'.

=head1 NOTES

The perl builtin hex() function takes a hex string as a parameter and 
returns the decimal value (FromBase = 16, ToBase = 10) but this 
notation seems counter-intuitive to me since the code implies that 
a hex() function will turn your parameter into hexadecimal (ie. It 
sounds like hex will hexify your parameter but it does not.) so 
I've decided (maybe foolishly) to invert the notation for my 
similar functions since it makes more sense to me this way and will
be easier to remember (I've had to lookup hex() in the Camel book 
many times already which was part of the impetus for this module...
as well as the gut reaction that sprintf() is not a proper natural
inverse function for hex()).  

This means that my b64() function takes a decimal number as a 
parameter and returns the base64 equivalent (FromBase = 10, ToBase =
64) and my b10() function takes a base64 number (string) and returns 
the decimal value (FromBase = 64, ToBase = 10).  My hex() function 
overloads perl's builtin version with this opposite behavior so my 
dec() function behaves like perl's normal hex() function.  I know 
it's confusing and maybe bad form of me to do this but I like it 
so much better this way that I'd rather go against the grain.  

Please think of my dec() and hex() functions as meaning decify and 
hexify.  Also the pronunciation of dec() is 'dess' (!'deck' as in 
the inverse of 'ink' which -- and ++ have so improved upon).  After 
reading the informative perl module etiquette guidelines, I now 
appreciate the need to export as little as is necessary by default.  
So to be responsible, I have limited BaseCnv exporting to only 
cnv() under normal circumstances.  Please specify the other 
functions you'd like to import into your namespace or use the tags 
described above in the cnv() section like:
    'use Math::BaseCnv qw(:all !:hex);'

Error checking is minimal.

This module does not handle fractional number inputs because I like 
using the dot (.) character as a standard base64 digit since it 
makes for clean filenames.

I hope you find Math::BaseCnv useful.  Please feel free to e-mail 
me any suggestions or coding tips or notes of appreciation 
("app-ree-see-ay-shun").  Thank you.  TTFN.

=head1 CHANGES

Revision history for Perl extension Math::BaseCnv:

=over 4

=item - 1.0.428LV46  Sun Feb  8 21:31:04:06 2004

* broke apart CHANGES to descend chronologically

* made dec() auto uppercase param since dec(a) was returning 36 instead of 10

=item - 1.0.41M4GMP  Thu Jan 22 04:16:22:25 2004

* put cnv in bin/ as EXE_FILES

=item - 1.0.418BEPc  Thu Jan  8 11:14:25:38 2004

* testing new e auto-gen MANIFEST(.SKIP)?

=item - 1.0.3CNH37s  Tue Dec 23 17:03:07:54 2003

* updated POD

=item - 1.0.3CG3dIx  Tue Dec 16 03:39:18:59 2003

* normalized base spelling and other eccentricities

=item - 1.0.3CD1Vdd  Sat Dec 13 01:31:39:39 2003

* added ABSTRACT section to WriteMakeFile()

* changed synopsis example

* updated all POD indenting

=item - 1.0.3CCA5Mi  Fri Dec 12 10:05:22:44 2003

* removed indenting from POD NAME field

=item - 1.0.3CB7M43  Thu Dec 11 07:22:04:03 2003

* updated package to coincide with Time::Fields release

=item - 1.0.39B36Lv  Thu Sep 11 03:06:21:57 2003

* synchronized POD with README documentation using new e utility

* templatized package compilation

* fixed boundary bugs

=item - 1.0.37SLNGN  Mon Jul 28 21:23:16:23 2003

* first version (and my first perl module... yay!) put on CPAN

=item - 1.0.37JKj3w  Sat Jul 19 20:45:03:58 2003

* reworked interface from shell utility to package

=item - 1.0.3159mLT  Sun Jan  5 09:48:21:29 2003

* original version

=back

=head1 INSTALL

Please run:

    `perl -MCPAN -e "install Math::BaseCnv"`

or uncompress the package and run the standard:

    `perl Makefile.PL; make; make test; make install`

=head1 LICENSE

Most source code should be Free!
  Code I have lawful authority over is and shall be!
Copyright: (c) 2003, Pip Stuart.  All rights reserved.
Copyleft :  I license this software under the GNU General Public 
  License (version 2).  Please consult the Free Software Foundation 
  (http://www.fsf.org) for important information about your freedom.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut

package Math::BaseCnv;
require Exporter;
use strict;
use base qw(Exporter);
# only export cnv() for 'use Math::BaseCnv;' and all other stuff optionally
our @EXPORT      =              qw(cnv                            )    ; 
our @EXPORT_OK   =              qw(    dec hex b10 b64 dig diginit)    ; 
our %EXPORT_TAGS = ( 'all' => [ qw(cnv dec hex b10 b64 dig diginit) ],
                     'hex' => [ qw(    dec hex                    ) ],
                     'b64' => [ qw(cnv         b10 b64            ) ],
                     'dig' => [ qw(                    dig diginit) ] );
our $VERSION     = '1.0.428LV46'; # major . minor . PipTimeStamp
our $PTVR        = $VERSION; $PTVR =~ s/^\d+\.\d+\.//; # strip major and minor
# See http://Ax9.Org/pt?$PTVR and `perldoc Time::PT`

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

sub bs2init { # build hash of digit char keys to array index values
  %bs2d = (); 
  for(my $i = 0; $i < @{ $digsets{$d2bs} }; $i++) { 
    $bs2d{${ $digsets{$d2bs} }[$i]} = $i;
  }
}
sub diginit { # reset digit character list to initial Dflt
  $d2bs = '128'; bs2init();
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
sub cnv__10 { # convert from some number base to decimal fast
  my $t = shift; my $s = shift || 64; my $n = 0;
  $nega = ''; $nega = '-' if($t =~ s/^-//);
  foreach(split(//, $t)) { return(-1) unless(exists $bs2d{$_}); }
  while(length($t)) { $n += $bs2d{substr($t,0,1,'')}; $n *= $s; } 
  return($nega . int($n / $s));
}
sub cnv10__ { # convert from decimal to some number base fast
  my $n = shift || 0; my $s = shift || 64; my $t = '';
  return(-1) if($s > @{ $digsets{$d2bs} });
  $nega = ''; $nega = '-' if($n =~ s/^-//);
  while($n) { $t = $digsets{$d2bs}->[($n % $s)] . $t; $n = int($n / $s); }
  if(length($t)) { $t = $nega . $t;           }
  else           { $t = $digsets{$d2bs}->[0]; }
  return($t);
}
sub dec { return(cnv__10(uc(shift), 16)); }#shortcut for hexadecimal -> decimal
sub hex { return(cnv10__(shift,     16)); }#shortcut for decimal     -> hex
sub b10 { return(cnv__10(shift,     64)); }#shortcut for base64      -> decimal
sub b64 { return(cnv10__(shift,     64)); }#shortcut for decimal     -> base64
sub cnv { # convert between any number base
  my $numb = shift; return(-1) if(!defined $numb || $numb =~ /^$/);
  my $fbas = shift; my $tbas = shift; 
  my $rslt = '';    my $temp = 0;
  
  return($digsets{$d2bs}->[0]) if($numb =~ /^-?0+$/); # lots of (negative?) zeros is just zero
  if(!defined($tbas)) { # makeup reasonable values for missing params
    if(!defined($fbas)) {
      $fbas = 10; $tbas = 16;
      if     ($numb =~ /^0x/i || ($numb =~ /[A-F]/i and $numb =~ /^[0-9A-F]+$/i)) {
        $fbas = 16; $tbas = 10;
      } elsif($numb =~ /[G-Z._]/i and $numb =~ /^[0-9A-Z._]+$/i) {
        $fbas = 64; $tbas = 10;
      } elsif($numb =~ /\D/) {
        print "!*EROR*! Can't determine reasonable FromBase and ToBase from number:$numb!\n";
      }
    } else {
      $tbas = $fbas; $fbas = 10;
    }
  }
  $fbas = 16 if($fbas =~ /\D/);
  $tbas = 10 if($tbas =~ /\D/);
  if($fbas == 16) { $numb =~ s/^0x//i; $numb = uc($numb); }
  return(-1) if($fbas < 2 || $tbas < 2); # invalid base error
  $numb = cnv__10($numb, $fbas) if($numb =~ /\D/ || $fbas != 10);
  $numb = cnv10__($numb, $tbas) if(                 $tbas != 10);
  return( $numb );
}

diginit(); # initialize the Dflt digit set when BaseCnv is used

127;
