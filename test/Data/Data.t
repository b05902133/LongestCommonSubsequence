use strict;
use warnings;
use Test::More;
use LCS::Data;

can_ok( 'Data', qw( new lcsLength sources setSources insertSource ) );

subtest 'Public Members' => sub
{
  subtest 'Constructor' => sub
  {
    my $data = new_ok( 'Data' );

    ok( $data->lcsLength  == 0, 'lcs length should be 0'    );
    ok( $data->sources    == 0, 'sources size should be 0'  );
  };

=comment
  subtest 'Setters' => sub
  {

  };
=cut
};

done_testing;
# vim: filetype=perl
