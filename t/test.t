#
# test.t -- Test Config::IniSearch module
#
#####################################################################

use strict;
use Test;
$Test::Harness::verbose = 1;
BEGIN{ plan tests => 12, todo => [8,9] };
use Config::IniSearch;
my $status;

# Test to access specified INI file...
print "1...";
my $iniFile = "/etc/global.ini";
my $config = new Config::IniSearch( 'testSection', $iniFile );
( $config->{fileName} eq '/etc/global.ini' ) ? 
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );

# Tests starting with most specific ini file and progressing to global
# ini file
print "2...";
$config = new Config::IniSearch( 'testSection' );
( $config->{fileName} eq './testSection.ini' ) ?
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );
rename './testSection.ini', './testSection.ini.moved';

print "3...";
$config = new Config::IniSearch( 'testSection' );
( $config->{fileName} eq './global.ini' ) ?
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );
rename './global.ini', './global.ini.moved';

print "4...";
$config = new Config::IniSearch( 'testSection' );
( $config->{fileName} eq 't/testSection.ini' ) ?
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );
rename 't/testSection.ini', 't/testSection.ini.moved';

print "5...";
$config = new Config::IniSearch( 'testSection' );
( $config->{fileName} eq 't/global.ini' ) ?
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );
rename 't/global.ini', 't/global.ini.moved';

print "6...";
$config = new Config::IniSearch( 'testSection' );
( $config->{fileName} eq '/etc/testSection.ini' ) ?
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );

print "7...";
$config = new Config::IniSearch( 'testSection2' );
( $config->{fileName2} eq '/etc/global.ini' ) ?
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );

# Restore files
rename './testSection.ini.moved', './testSection.ini';
rename './global.ini.moved', './global.ini';
rename 't/testSection.ini.moved', 't/testSection.ini';
rename 't/global.ini.moved', 't/global.ini';

# Test various Config::IniHash case options

# Hmm...what exactly does 'tolower' and 'toupper' accomplish?
print "8...skipped\n";
ok(0);
=pod
$config = new Config::IniSearch( 'testSection', undef, case=>tolower );
( $config->{uppercase} =~ /success/ ) ? print 'ok' : print 'FAILED';
print "\n";
=cut

print "9...skipped\n";
ok(0);
=pod
$config = new Config::IniSearch( 'testSection', undef, case=>toupper );
( $config->{LOWERCASE} =~ /success/ ) ? print 'ok' : print 'FAILED';
print "\n";
=cut

print "10...";
$config = new Config::IniSearch( 'testSection', undef, case=>'lower' );
( $config->{uppercase} =~ /success/ ) ?
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );

print "11...";
$config = new Config::IniSearch( 'testSection', undef, case=>'upper' );
( $config->{LOWERCASE} =~ /success/ ) ?
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );

print "12...";
$config = new Config::IniSearch( 'testSection', undef, case=>'preserve' );
( $config->{MiXeDcAsE} =~ /success/ ) ?
    ( $status = 'ok' ) : ( $status = 'FAILED' );
print "$status\n";
ok( $status eq 'ok' );
