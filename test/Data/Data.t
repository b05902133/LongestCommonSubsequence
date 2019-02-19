use strict;
use warnings;
use Test::More;
use LCS::Data;
use List::Util qw( pairs );

List::Util->VERSION( 1.39 );

can_ok( 'Data', qw( new lcsLength sources setSources insertSource ) );

subtest 'Public Members' => sub#{{{
{
  subtest 'Constructor' => sub#{{{
  {
    my $data = new_ok( 'Data' );

    ok( $data->lcsLength  == 0, 'lcs length should be 0'    );
    ok( $data->sources    == 0, 'sources size should be 0'  );
  };
#}}}
  subtest 'Setters' => sub#{{{
  {
    my $data = Data->new;

    subtest 'setLcsLength' => sub#{{{
    {
      my $value = 5;

      $data->setLcsLength( $value );

      ok( $data->lcsLength == $value, "lcs length should be set to $value" );
    };
#}}}
    subtest 'setSources' => sub#{{{
    {
      my @pairs = pairs ( 1, 2, 3, 4 );

      $data->setSources( @pairs );

      ok( $data->sources == @pairs, 'the size of sources should be ' . scalar @pairs );

      is_deeply( [$data->sources], \@pairs, 'sources is not the same as input' );
    };#}}}
  };
#}}}
  subtest 'Operations' => sub#{{{
  {
    my $data = Data->new;

    subtest 'insertSource' => sub#{{{
    {
      my @pairs1  = pairs ( 1, 2, 1, 2 );
      my @pairs2  = pairs ( 3, 4, 1, 2, 5, 6 );
      my @result1 = pairs ( 1, 2 );
      my @result2 = pairs ( 1, 2, 3, 4, 5, 6 );

      $data->insertSource( @pairs1 );

      ok( $data->sources == @result1, 'the size of sources should be ' . scalar @result1 );
      is_deeply( [$data->sources], \@result1 );

      $data->insertSource( @pairs2 );

      ok( $data->sources == @result2, 'the size of sources should be ' . scalar @result2 );
      is_deeply( [$data->sources], \@result2 );
    };#}}}
  };#}}}
};
#}}}
subtest 'Non Members' => sub#{{{
{
  subtest 'isPairEqual' => sub#{{{
  {
    my ( $pair1, $pair2 ) = pairs ( 1, 2, 1, 2 );
    my ( $pair3, $pair4 ) = pairs ( 1, 2, 2, 1 );

    ok( Data::isPairEqual( $pair1, $pair2 ), "( @$pair1 ) should be equal to ( @$pair2 )"       );
    ok( !Data::isPairEqual( $pair3, $pair4 ), "( @$pair3 ) should not be equal to ( @$pair4 )"  );
  };#}}}
};
#}}}
done_testing;
# vim: filetype=perl foldmethod=marker foldmarker={{{,}}}
