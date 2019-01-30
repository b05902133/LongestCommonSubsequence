package Data;

use strict;
use warnings;

=head1 NAME

Data - the data store the information of lcs

=cut

=head1 DESCRIPTIONS
=cut

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
=head2 Public Member Functions
=cut
# document{{{
=head3 new

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
# document{{{
=head3 lcsLength

Get the lcs length.

B<Return Value>

=over

=item * the lcs length.

=back
=cut#}}}
sub lcsLength#{{{
{
  my $self = shift;

  return $self->{lcsLength};
}
#}}}
# document{{{
=head3 setLcsLength

Set the lcs length.

B<Parameters>

=over

=item * lcs length value.

=back
=cut#}}}
sub setLcsLength#{{{
{
  my ( $self, $value ) = @_;

  return unless $value >= 0; # precondition

  $self->{lcsLength} = $value;
}
#}}}
# document{{{
=head3 sources

Get the sources of the lcs.

B<Return Value>

=over

=item * a list with elements being a pair.

=back
=cut#}}}
sub sources#{{{
{
  my $self = shift;

  return @{ $self->{sources} };
}
#}}}
# document{{{
=head3 setSources

Set the lcs sources.

B<Parameters>

=over

=item * lcs sources

it sould be a list with elements being pairs,
this can be constructed by List::Util::pairs.

=back
=cut#}}}
sub setSources#{{{
{
  my ( $self, @pairs ) = @_;

  @{ $self->{sources} } = @pairs;
}
#}}}
# document{{{
=head3 insertSource

Insert sources into the lcs source.

B<Parameters>

=over

=item * a list with elements being pairs

this can be constructed by List::Util::pairs.

=back
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
=head2 Non-Member Functions
=cut
# document{{{
=head3 isPairEqual

Test if two pairs are the same.
Each pair contains two nonnegative integer.

B<Parameters>

=over

=item * pair1
=item * pair2

=back

B<Return Value>

=over

=item * a Boolean context indicate if the pairs are the same.

=back
=cut#}}}
sub isPairEqual#{{{
{
  my ( $pair1, $pair2 ) = @_;

  return ( $pair1->key == $pair2->key and $pair1->value == $pair2->value );
}#}}}
# end implementation of non member functions
#}}}
# implementation of private member functions{{{
=head2 Private Member Functions
=cut
# document{{{
=head3 isRepeat

Test if the pair exists in sources.

B<Parameters>

=over

=item * a pair

=back

B<Return Value>

=over

=item * a Boolean context indicate if the pair exists in sources.

=back
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
