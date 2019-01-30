package Data;

use strict;
use warnings;

# interface of public member functions{{{
sub new;
sub lcsLength;
sub setLcsLength;
sub sources;
sub setSources;
sub insertSource;
# end interface public member functions
#}}}
# interface of non member functions{{{
sub isPairEqual;
# end interface of non member functions
#}}}
# interface of private member functions{{{
sub isRepeat;
# end interface of private member functions
#}}}
# implementation of public member functions{{{
=pod#{{{
Construct a Data object.
=cut#}}}
sub new#{{{
{
  my $className = shift;
  my $members   =
    {
      sources   => [],  # a list of pairs, a pair should contain two non-negative interger
      lcsLength => 0,   # a non-negative integer
    };

  bless $members, $className;
}
#}}}
=pod#{{{
Get the lcs length.

Return Value:

  the lcs length.
=cut#}}}
sub lcsLength#{{{
{
  my $self = shift;

  return $self->{lcsLength};
}
#}}}
=pod#{{{
Set the lcs length.

Parameters:

  lcs length value.
=cut#}}}
sub setLcsLength#{{{
{
  my ( $self, $value ) = @_;

  return unless $value >= 0; # precondition

  $self->{lcsLength} = $value;
}
#}}}
=pod#{{{
Get the sources of the lcs.

Return Value:

  a list with elements being a pair.
=cut#}}}
sub sources#{{{
{
  my $self = shift;

  return @{ $self->{sources} };
}
#}}}
=pod#{{{
Set the lcs sources.

Parameters:

  lcs sources.
    it sould be a list with elements being pairs,
    this can be constructed by List::Util::pairs.
=cut#}}}
sub setSources#{{{
{
  my ( $self, @pairs ) = @_;

  @{ $self->{sources} } = @pairs;
}
#}}}
=pod#{{{
Insert sources into the lcs source.

Parameters:

  a list with elements being pairs, this can be constructed by List::Util::pairs.
=cut#}}}
sub insertSource#{{{
{
  my ( $self, @pairs ) = @_;

  for my $pair ( @pairs )
  {
     next if $self->isRepeat( $pair );

     push @{ $self->{sources} }, $pair;
  }
}#}}}
# end implementation of public member functions
#}}}
# implementation of non member functions{{{
=pod#{{{
Test if two pairs are the same.
Each pair contains two nonnegative integer.

Parameters:

  1. pair1
  2. pair2

Return Value:

  a Boolean context indicate if the pairs are the same.
=cut#}}}
sub isPairEqual#{{{
{
  my ( $pair1, $pair2 ) = @_;

  return ( $pair1->key == $pair2->key and $pair1->value == $pair2->value );
}#}}}
# end implementation of non member functions
#}}}
# implementation of private member functions{{{
=pod#{{{
Test if the pair exists in sources.

Parameters:

  a pair.

Return Value:

  a Boolean context indicate if the pair exists in sources.
=cut#}}}
sub isRepeat#{{{
{
  my ( $self, $pair ) = @_;

  for my $sourcePair ( @{ $self->{sources} } )
  {
     return 1 if isPairEqual( $pair, $sourcePair );
  }
  return 0;
}#}}}
# end implementation of private member functions
#}}}
1;
# vim: foldmethod=marker foldmarker={{{,}}}
