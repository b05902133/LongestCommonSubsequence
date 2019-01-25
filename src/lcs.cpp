#include "lcs.h"

#include <iostream>
#include <algorithm>
#include <cassert>
using namespace std;

const LCS::Data LCS::nullData = { {}, 0 };
// public member functions {{{
void LCS::exec( const std::string &a, const std::string &b ) /*{{{*/
{
  mStringA = a;
  mStringB = b;

  initDatabase  ();
  evalDatabase  ();
  collectResults();

  sort( mResults.begin(), mResults.end() );

  printResults();
} /*}}}*/
// end public member functions
/*}}}*/
// private member functions
void LCS::initDatabase() /*{{{*/
{
  mDatabase.resize( mStringA.size() + 1 );

  for( size_t i = 0 ; i < mDatabase.size() ; ++i )
  {
     mDatabase[i].resize( mStringB.size() + 1 );

     for( size_t j = 0 ; j < mDatabase[i].size() ; ++j )
     {
        if( j == 0 || i == 0 )
          mDatabase[i][j].length = 0;
     }
  }
}
/*}}}*/
void LCS::evalDatabase() /*{{{*/
{
  for( size_t i = 1 ; i < mDatabase.size() ; ++i )
     for( size_t j = 1 ; j < mDatabase[i].size() ; ++j )
     {
        removeBothSide( i, j );               // remove A[i] and B[j] 
        removeOneSide( i, j, Source::dec_a ); // A[i] is not in lcs 
        removeOneSide( i, j, Source::dec_b ); // B[j] is not in lcs 
     }
}
/*}}}*/
void LCS::collectResults() /*{{{*/
{
  string lcs;

  collectResults( mStringA.size(), mStringB.size(), lcs );
}
/*}}}*/
void LCS::collectResults( size_t i, size_t j, std::string &lcs ) /*{{{*/
{
  // preconditions
  assert( i < mDatabase.size()    );
  assert( j < mDatabase[i].size() );
  assert( mDatabase.size()          > mStringA.size() );
  assert( mDatabase.front().size()  > mStringB.size() );
  assert( lcs.size() < mDatabase[mStringA.size()][mStringB.size()].length );
  // end preconditions

  for( const CharPair &charPair : mDatabase[i][j].sources )
  {
     lcs.push_back( mStringA[charPair.first] );
     if( lcs.size() == mDatabase[mStringA.size()][mStringB.size()].length )
     {
       mResults.push_back( lcs );
       reverse( mResults.back().begin(), mResults.back().end() );
     }
     else
       collectResults( charPair.first, charPair.second, lcs );
     lcs.pop_back();
  }
}
/*}}}*/
void LCS::printResults() const /*{{{*/
{
  assert( !mResults.empty() ); // precondition

  cout << mResults.front().size() << " " << mResults.size() << "\n";

  for( const string &lcs : mResults )
     cout << lcs << "\n";
}
/*}}}*/
void LCS::removeBothSide( const size_t i, const size_t j ) /*{{{*/
{
  // preconditions
  assert( i < mDatabase.size()    );
  assert( i - 1 < mStringA.size() );
  assert( j < mDatabase[i].size() );
  assert( j - 1 < mStringB.size() );
  // end preconditions

  Data        &data     = mDatabase[i][j];
  const Data  &dataDec  = dataSource( i, j, Source::dec_ab );

  data.length = dataDec.length;

  if( mStringA[i-1] == mStringB[j-1] )
  {
    ++data.length;
    data.sources.insert( make_pair( i - 1, j - 1 ) );
  }
}
/*}}}*/
void LCS::removeOneSide( const size_t i, const size_t j, const Source source ) /*{{{*/
{
  // preconditions
  assert( source == Source::dec_a || source == Source::dec_b );
  assert( i < mDatabase.size()    );
  assert( j < mDatabase[i].size() );
  // end preconditions

  Data        &data     = mDatabase[i][j];
  const Data  &dataDec  = dataSource( i, j, source );

  if( dataDec.length > data.length )
    data = dataDec;
  else if( dataDec.length == data.length )
    data.sources.insert( dataDec.sources.begin(), dataDec.sources.end() );
}
/*}}}*/
const LCS::Data& LCS::dataSource( const size_t i, const size_t j, const Source source ) const /*{{{*/
{
  // preconditions
  assert( i < mDatabase.size()    );
  assert( j < mDatabase[i].size() );
  // end preconditions

  switch( source )
  {
    case Source::dec_a:   return mDatabase[i-1][j];
    case Source::dec_b:   return mDatabase[i][j-1];
    case Source::dec_ab:  return mDatabase[i-1][j-1];
    default:              return nullData;
  }
} /*}}}*/
// end private member functions
// vim: foldmethod=marker foldmarker={{{,}}}
