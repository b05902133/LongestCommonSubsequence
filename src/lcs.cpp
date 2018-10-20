#include "lcs.h"

#include <iostream>
#include <algorithm>
using namespace std;

// public member functions
void LCS::exec( const std::string &a, const std::string &b )
{
  mStringA = a;
  mStringB = b;

  initDatabase  ();
  evalDatabase  ();
  collectResults();

  sort( mResults.begin(), mResults.end() );

  printResults();
}
// end public member functions

// private member functions
void LCS::initDatabase()
{
  mDatabase.clear();

  mDatabase.resize( mStringA.size() + 1 );

  for( size_t i = 0 ; i < mDatabase.size() ; ++i )
  {
     mDatabase[i].resize( mStringB.size() + 1 );

     for( size_t j = 0 ; j < mDatabase[i].size() ; ++j )
     {
        if( j == 0 || i == 0 )
        {
          mDatabase[i][j].length = 0;
          mDatabase[i][j].sources.push_back( Source::null );
        }
     }
  }
}

void LCS::evalDatabase()
{
  for( size_t i = 1 ; i < mDatabase.size() ; ++i )
     for( size_t j = 1 ; j < mDatabase[i].size() ; ++j )
     {
        Data &data = mDatabase[i][j];

        // remove A[i] and B[j]
        data.length = mDatabase[i-1][j-1].length;
        data.sources.push_back( Source::dec_ab );
        // end remove A[i] and B[j]

        if( mStringA[i] == mStringB[j] ) ++data.length;

        // A[i] is not in lcs
        if( mDatabase[i-1][j].length > data.length )
        {
          data.length = mDatabase[i-1][j].length;
          data.sources.clear();
          data.sources.push_back( Source::dec_a );
        }
        else if( mDatabase[i-1][j].length == data.length )
        {
          data.sources.push_back( Source::dec_a );
        }
        // end A[i] is not in lcs

        // B[j] is not in lcs
        if( mDatabase[i][j-1].length > data.length )
        {
          data.length = mDatabase[i][j-1].length;
          data.sources.clear();
          data.sources.push_back( Source::dec_b );
        }
        else if( mDatabase[i][j-1].length == data.length )
        {
          data.sources.push_back( Source::dec_b );
        }
        // end B[j] is not in lcs
     }
}

void LCS::collectResults()
{
  string lcs;

  collectResults( mStringA.size(), mStringB.size(), lcs );
}

void LCS::collectResults( size_t i, size_t j, std::string &lcs )
{
  for( Source source : mDatabase[i][j].sources )
  {
     switch( source )
     {
       case Source::dec_a: collectResults( i - 1, j, lcs ); break;
       case Source::dec_b: collectResults( i, j - 1, lcs ); break;
       case Source::dec_ab:

         lcs.push_back( mStringA[i] );
         collectResults( i - 1, j - 1, lcs );
         lcs.pop_back();
         break;

       case Source::null:
       default:

         mResults.push_back( lcs );
         break;
     }
  }
}

void LCS::printResults()
{
  cout << mResults.front().size() << " " << mResults.size() << "\n";

  for( string &lcs : mResults )
     cout << lcs << "\n";
}
// end private member functions
