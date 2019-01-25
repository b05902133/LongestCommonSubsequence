use strict;
use warnings;

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
      print "@strings[0,1]\n";
      last;
    }
  }
}
