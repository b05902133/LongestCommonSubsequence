use strict;
use warnings;
use File::Basename;
use lib dirname( __FILE__ );
use Test::More;
use LCS::Table;

can_ok( 'Data', qw( new ) );
can_ok( 'Table', qw( new row column resize data ) );

subtest 'Public Member Functions' => sub#{{{
{
  subtest 'Constructor' => sub#{{{
  {
    my ( $row, $column )  = ( 2, 3 );
    my $table             = new_ok( 'Table' => [$row, $column] );

    ok( $table->row     == $row,    "the row number should be $row"       );
    ok( $table->column  == $column, "the column number should be $column" );
  };
  #}}}
  subtest 'Operation' => sub#{{{
  {
    subtest 'resize' => sub#{{{
    {
      my ( $rowInit,  $columnInit ) = ( 1, 2 );
      my ( $row1,     $column1    ) = ( 2, 5 );
      my ( $row2,     $column2    ) = ( 1, 2 );
      my $table                     = Table->new( $rowInit, $columnInit );

      $table->resize( $row1, $column1 );
      
      ok( $table->row     == $row1,
          "the row number should be resized from $rowInit to $row1," .
          "but the row number is " . $table->row );
      ok( $table->column  == $column1,
          "the column number should be resized from $columnInit to $column1," .
          "but the column number is " . $table->column );

      $table->resize( $row2, $column2 );
      
      ok( $table->row     == $row2,
          "the row number should be resized from $row1 to $row2," .
          "but the row number is " . $table->row );
      ok( $table->column  == $column2,
          "the column number should be resized from $column1 to $column2," .
          "but the column number is " . $table->column );
    };
#}}}
    subtest 'data' => sub#{{{
    {
      my ( $rowInit,  $columnInit ) = ( 1, 2 );
      my ( $row,      $column     ) = ( 0, 0 );
      my $table                     = Table->new( $rowInit, $columnInit );

      isa_ok( $table->data( 0, 0 ), 'Data', "table[$row][$column]" );
    };#}}}
  };#}}}
};
#}}}
done_testing;
# vim: filetype=perl foldmethod=marker foldmarker={{{,}}}
