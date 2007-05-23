use Test::Pod::Coverage 'tests' => '1'; pod_coverage_ok('Math::BaseCnv', { 'also_private' => [ qr/^(cnv(10)?__|bs2init$)/ ], }, 'POD Covered');
