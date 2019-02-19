package LCS;

use strict;
use warnings;
use List::Util qw( pairs );
use LCS::Data;
use LCS::Table;

List::Util->VERSION( 1.39 );

=constants being used#{{{

Source:

  dec_a
  dec_b
  dec_ab
  null

=cut
#}}}
# interface of public member functions{{{
sub new;
sub exec;
# end interface of public member functions
#}}}
# interface of private member functions{{{
sub initDatabase;
sub evalDatabase;
sub collectResults;
sub collectResults;
sub printResults;

sub removeBothSide;
sub removeOneSide;

sub dataSource;
# end interface of private member functions
#}}}
# implementation of public member functions{{{
=pod#{{{
Create a LCS object.
=cut#}}}
sub new#{{{
{
  my $className = shift;
  my $object    =
    {
      stringA => '',
      stringB => '',

      database  => Table->new( 0, 0 ),
      results   => []
    };

  bless $object, $className;
}
#}}}
=pod#{{{
Find the lognest common subsequence.

Parameters:

  string a
  string b
=cut#}}}
sub exec#{{{
{
  my $self = shift;

  ( $self->{stringA}, $self->{stringB} ) = @_;

  $self->initDatabase;
  $self->evalDatabase;
  $self->collectResults;

  @{ $self->{results} } = sort @{ $self->{results} };

  $self->printResults;
}#}}}
# end implementation of public member functions
#}}}
# implementation of private member functions{{{
sub initDatabase#{{{
{
  my $self = shift;

  my $mDatabase  = $self->{database};
  my $mStringA   = \$self->{stringA};
  my $mStringB   = \$self->{stringB};

  $mDatabase->resize( length( $$mStringA ) + 1, length( $$mStringB ) + 1 );

  for( my $i = 0 ; $i < $mDatabase->row ; ++$i )
  {
     for( my $j = 0 ; $j < $mDatabase->column ; ++$j )
     {
        $mDatabase->data( $i, $j )->setLcsLength( 0 ) if $j == 0 or $i == 0;
     }
  }
}
#}}}
sub evalDatabase#{{{
{
  my $self = shift;

  for( my $i = 1 ; $i < $self->{database}->row ; ++$i )
  {
     for( my $j = 1 ; $j < $self->{database}->column ; ++$j )
     {
        $self->removeBothSide( $i, $j );
        $self->removeOneSide( $i, $j, 'dec_a' );
        $self->removeOneSide( $i, $j, 'dec_b' );
     }
  }
}
#}}}
sub collectResults#{{{
{
  my $self = shift;

  if( @_ )
  {
    my ( $i, $j, $lcs ) = @_;

    my $lengthA   = length $self->{stringA};
    my $lengthB   = length $self->{stringB};
    my $lcsLength = $self->{database}->data( $lengthA, $lengthB )->lcsLength;
    my $data      = $self->{database}->data( $i, $j );
    my $mResults  = $self->{results};

    for my $charPair ( $data->sources )
    {
       my ( $iNext, $jNext )  = @$charPair;
       my $char               = substr $self->{stringA}, $iNext, 1;

       $$lcs = $char . $$lcs;

       if( length $$lcs == $lcsLength )
       {
         push @$mResults, $$lcs
       }
       else
       {
         $self->collectResults( $iNext, $jNext, $lcs );
       }
       $$lcs = substr $$lcs, 1;
    }
  }
  else
  {
    my $lcs = '';

    my $mStringA = \$self->{stringA};
    my $mStringB = \$self->{stringB};

    $self->collectResults( length $$mStringA, length $$mStringB, \$lcs );
  }
}
#}}}
sub printResults#{{{
{
  my $self = shift;

  my $mResults = $self->{results};

  print( length $mResults->[0], " ", scalar @$mResults, "\n" );

  print $_, "\n" for ( @$mResults );
}
#}}}
sub removeBothSide#{{{
{
  my ( $self, $i, $j ) = @_;
  my $dataDec = $self->dataSource( $i, $j, 'dec_ab' );
  my $data    = $self->{database}->data( $i, $j );
  my $charA   = substr $self->{stringA}, $i - 1, 1;
  my $charB   = substr $self->{stringB}, $j - 1, 1;

  $data->setLcsLength( $dataDec->lcsLength );

  if( $charA eq $charB )
  {
    $data->setLcsLength( $data->lcsLength + 1 );
    $data->insertSource( pairs( $i - 1, $j - 1 ) );
  }
}
#}}}
sub removeOneSide#{{{
{
  my ( $self, $i, $j, $source ) = @_;
  my $dataDec = $self->dataSource( $i, $j, $source );
  my $data    = $self->{database}->data( $i, $j );

  if( $dataDec->lcsLength > $data->lcsLength )
  {
    $data->setLcsLength( $dataDec->lcsLength  );
    $data->setSources  ( $dataDec->sources    );
  }
  elsif( $dataDec->lcsLength == $data->lcsLength )
  {
    $data->insertSource( $dataDec->sources );
  }
}
#}}}
sub dataSource#{{{
{
  my ( $self, $i, $j, $source ) = @_;

  return $self->{database}->data( $i-1, $j    ) if( $source eq 'dec_a'  );
  return $self->{database}->data( $i,   $j-1  ) if( $source eq 'dec_b'  );
  return $self->{database}->data( $i-1, $j-1  ) if( $source eq 'dec_ab' );
  return undef;
}#}}}
# end implementation of private member functions
#}}}
1;
# vim: foldmethod=marker foldmarker={{{,}}}
