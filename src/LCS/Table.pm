package Table;

use strict;
use warnings;
use LCS::Data;

=head1 NAME

Table - a 2 dimention table of Data

=head1 DESCRIPTIONS
=cut

# interface of public member functions{{{
sub new;
sub row;
sub column;
sub resize;
sub data;
# end interface of public member functions
#}}}
# interface of public member functions{{{
=head2 Public Member Functions
=cut
# document{{{
=head3 new

Construct a Table object

B<Parameters>

=over

=item * row size

The rows of the table.
It should be a non negative number.

=item * column size

The columns of the table.
It should be a non negative number.

=back
=cut#}}}
sub new#{{{
{
  my ( $className, $row, $column )  = @_;
  my $table                         = [];

  for( my $i = 0 ; $i < $row ; ++$i )
  {
     push @{ $table }, [];

     for( my $j = 0 ; $j < $column ; ++$j )
     {
       push @{ $table->[$i] }, Data->new;
     }
  }

  bless $table, $className;
}
#}}}
# document{{{
=head3 row

Get the row number of the table.

B<Return>

=over

=item * the row number.

=back
=cut#}}}
sub row#{{{
{
  my $self = shift;

  return scalar @$self;
}
#}}}
# document{{{
=head3 column

Get the column number of the table.

B<Return>

=over

=item * the column number.

=back
=cut#}}}
sub column#{{{
{
  my $self = shift;

  return scalar @{ $$self[0] };
}
#}}}
# document{{{
=head3 resize

Resize the table.

B<Parameters>

=over

=item * row size

The rows of the table.
It should be a non negative number.

=item * column size

The columns of the table.
It should be a non negative number.

=back
=cut#}}}
sub resize#{{{
{
  my ( $self, $row, $column ) = @_;

  my $rowCurrent = $self->row;
  my $colCurrent = $self->column;

  # resize row{{{
  if( $rowCurrent <= $row )
  {
    for my $i ( $rowCurrent .. $row - 1 )
    {
       push @$self, [];

       push @{ $$self[$i] }, Data->new for ( 1 .. $colCurrent );
    }
  }
  else
  {
    splice @$self, $row;
  }
  # end resize row
  #}}}
  # resize column{{{
  if( $colCurrent <= $column )
  {
    for my $i ( 0 .. $row - 1 )
    {
       push @{ $$self[$i] }, Data->new for ( $colCurrent + 1 .. $column );
    }
  }
  else
  {
    splice @{ $$self[$_] }, $column for ( 0 .. $row - 1 );
  }
  # end resize column}}}
}
#}}}
# document{{{
=head3 data

Get the data of the table.

B<Parameters>

=over

=item * row size

The rows of the table.
It should be a non negative number.

=item * column size

The columns of the table.
It should be a non negative number.

=back

B<Return>

=over

=item * the data at I<row> and I<column> of the table.

=back
=cut#}}}
sub data#{{{
{
  my ( $self, $row, $column ) = @_;

  return $self->[$row][$column];
}#}}}
# end interface of public member functions
#}}}
1;
# vim: foldmethod=marker foldmarker={{{,}}}
