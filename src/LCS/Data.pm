package Data;

use strict;
use warnings;

# interface of public member functions
sub new;
sub lcsLength;
sub setLcsLength;
sub sources;
sub setSources;
sub insertSource;
# end interface public member functions

# implementation of public member functions
=pod
Construct a Data object.
=cut
sub new
{
  my $className = shift;
  my $members   =
    {
      sources   => [],
      lcsLength => 0,
    };

  bless $members, $className;
}

=pod
Get the lcs length.

Return Value:

  the lcs length.
=cut
sub lcsLength
{
  my $self = shift;

  return $self->{lcsLength};
}

=pod
Set the lcs length.

Parameters:

  lcs length value.
=cut
sub setLcsLength
{
  my ( $self, $value ) = @_;

  $self->{lcsLength} = $value;
}

=pod
Get the sources of the lcs.

Return Value:

  a list with elements being a pair.
=cut
sub sources
{
  my $self = shift;

  return $self->{sources};
}

=pod
Set the lcs sources.

Parameters:

  lcs sources.
    it sould be a list with elements being pairs,
    this can be constructed by List::Util::pairs.
=cut
sub setSources
{
  my ( $self, @pairs ) = @_;

  @{ $self->{sources} } = @pairs;
}

=pod
Insert sources into the lcs source.

Parameters:

  a list with elements being pairs, this can be constructed by List::Util::pairs.
=cut
sub insertSource
{
  my ( $self, @pairs ) = @_;

  push @{ $self->{sources} }, @pairs;
}
# end implementation of public member functions

1;
