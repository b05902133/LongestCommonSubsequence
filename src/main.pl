use strict;
use warnings;
use LCS::LCS;

sub main;

main;

sub main
{
  my @strings;

  while( <STDIN> )
  {
    push @strings, split /\s+/;

    if( @strings >= 2 )
    {
      my $engine = LCS->new;

      $engine->exec( $strings[0], $strings[1] );
      last;
    }
  }
}
