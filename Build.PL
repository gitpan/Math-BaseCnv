#!/usr/bin/perl
  use Module::Build;
      Module::Build->new(
  # 'module_name'                   => 'Math::BaseCnv',
    'dist_name'                     => 'Math-BaseCnv',
  # 'dist_version_from'             => 'BaseCnv.pm',
    'dist_version'                  => '1.2.59IBlgw',
    'dist_abstract'                 => 'fast functions to convert between number bases',
    'dist_author'                   => 'Pip Stuart <Pip@CPAN.Org>',
  # 'create_readme'                 => '1',
  # 'create_makefile_pl'            => '1',
    'license'                       => 'gpl',
    'script_files'                  => {
      'bin/cnv'                       => '1',
    },
    'pm_files'                      => {
      'BaseCnv.pm'                    => 'lib/Math/BaseCnv.pm',
    },
    'requires'                      => {
      'Memoize'                       => '0',
    },
  )->create_build_script();