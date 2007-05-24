#!/usr/bin/perl
use Module::Build;
my $mbld = Module::Build->new(
# 'module_name'                   => 'Math::BaseCnv',
  'dist_name'                     => 'Math-BaseCnv',
# 'dist_version_from'             => 'BaseCnv.pm',
  'dist_version'                  => '1.4.75O6Pbr',
  'dist_abstract'                 => 'fast functions to CoNVert between number Bases',
  'dist_author'                   => 'Pip Stuart <Pip@CPAN.Org>',
# 'create_readme'                 => '1',
# 'create_makefile_pl'            => '1', # 'traditional',
  'license'                       => 'gpl',
  'script_files'                  => {
  },
  'pm_files'                      => {
    'BaseCnv.pm'                    => 'lib/Math/BaseCnv.pm',
  },
  'requires'                      => {
    'Memoize'                       => '0',
    'Test'                          => '0',
    'Test::Pod'                     => '0',
    'Test::Pod::Coverage'           => '0',
  },
);
$mbld->create_build_script();