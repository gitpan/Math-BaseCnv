use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
#   the contents of the Makefile that is written.
WriteMakefile(
  'NAME'         => 'Math::BaseCnv',
  'VERSION'      => '1.4.75O58nW',
  'ABSTRACT'     => 'fast functions to CoNVert between number Bases',
  'AUTHOR'       => 'Pip Stuart <Pip@CPAN.Org>',
  'EXE_FILES'    => [ 
                    ],
  'PREREQ_PM'    => {
    'Memoize'                        => 0,
    'Test'                           => 0,
    'Test::Pod'                      => 0,
    'Test::Pod::Coverage'            => 0,
  }, # Module::Name => 1.1,
  'dist'         => { 'COMPRESS' => 'gzip', 'SUFFIX' => 'tgz' },
);