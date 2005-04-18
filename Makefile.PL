use ExtUtils::MakeMaker;
  # See lib/ExtUtils/MakeMaker.pm for details of how to influence
  # # the contents of the Makefile that is written.
  WriteMakefile(
    'NAME'         => 'Math::BaseCnv',
    'VERSION'      => '1.2.54HK3pB',
    'ABSTRACT'     => 'fast functions to convert between number bases',
    'AUTHOR'       => 'Pip Stuart <Pip@CPAN.Org>',
    'EXE_FILES'    => [ 
                      'bin/cnv',
                    ],
    'PREREQ_PM'    => {
    'Memoize'                        => 0,
    }, # Module::Name => 1.1,
    'dist'         => { 'COMPRESS' => 'gzip', 'SUFFIX' => 'tgz' },
  );