use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# # the contents of the Makefile that is written.
WriteMakefile(
  'NAME'         => 'Math::BaseCnv',
  'VERSION_FROM' => 'BaseCnv.pm', # finds $VERSION
  'ABSTRACT'     => 'fast functions to convert between number bases',
  'dist'         => { 'COMPRESS' => 'gzip', 'SUFFIX' => 'tgz' },
);