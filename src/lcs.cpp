#include "lcs.h"

#include <iostream>
#include <algorithm>
using namespace std;

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
  mDatabase.clear();
  mNodes.clear();
  mNodeLeaves.resize( 1 );

  mDatabase.resize( mStringA.size() + 1 );

  for( size_t i = 0 ; i < mDatabase.size() ; ++i )
  {
     mDatabase[i].resize( mStringB.size() + 1 );

     for( size_t j = 0 ; j < mDatabase[i].size() ; ++j )
     {
        if( j == 0 || i == 0 )
        {
          mDatabase[i][j].length  = 0;
          mDatabase[i][j].type    = mNodes.size();
          mDatabase[i][j].sources.push_back( Source::null );
        }
     }
  }
}
/*}}}*/
void LCS::evalDatabase() /*{{{*/
{
  for( size_t i = 1 ; i < mDatabase.size() ; ++i )
     for( size_t j = 1 ; j < mDatabase[i].size() ; ++j )
     {
        Data &data = mDatabase[i][j];

        // remove A[i] and B[j] {{{
        data.length = mDatabase[i-1][j-1].length;
        data.type   = mDatabase[i-1][j-1].type;
        data.sources.push_back( Source::dec_ab );
        // end remove A[i] and B[j]
        /*}}}*/
        // check if A[i] == B[j] {{{
        if( mStringA[i-1] == mStringB[j-1] )
        {
          ++data.length;
          data.sources.back() = Source::dec_ab_common;
        }
        // end check if A[i] == B[j]
        /*}}}*/
        // A[i] is not in lcs {{{
        if( mDatabase[i-1][j].length > data.length )
        {
          data.length = mDatabase[i-1][j].length;
          data.type   = mDatabase[i-1][j].type;
          data.sources.clear();
          data.sources.push_back( Source::dec_a );
        }
        else if( mDatabase[i-1][j].length == data.length )
        {
          if( !isSameType( i , j, mDatabase[i-1][j].type ) )
            data.sources.push_back( Source::dec_a );
        }
        // end A[i] is not in lcs
        /*}}}*/
        // B[j] is not in lcs {{{
        if( mDatabase[i][j-1].length > data.length )
        {
          data.length = mDatabase[i][j-1].length;
          data.type   = mDatabase[i][j-1].type;
          data.sources.clear();
          data.sources.push_back( Source::dec_b );
        }
        else if( mDatabase[i][j-1].length == data.length )
        {
          if( !isSameType( i , j, mDatabase[i][j-1].type ) )
            data.sources.push_back( Source::dec_b );
        }
        // end B[j] is not in lcs
        /*}}}*/
        // setup type {{{
        if( data.sources.size() > 1 )
        {
          Key key;

          for( Source source : data.sources )
          {
             Type type;

             switch( source )
             {
               case Source::dec_a:  type = mDatabase[i-1][j].type;    break;
               case Source::dec_b:  type = mDatabase[i][j-1].type;    break;
               case Source::dec_ab: type = mDatabase[i-1][j-1].type;  break;
               default:             type = 0;                         break;
             }
             key.insert( mNodeLeaves[type].begin(), mNodeLeaves[type].end() );
          }
          auto it = mNodes.find( key );

          if( it == mNodes.end() )
          {
            data.type   = mNodes.size() + 1;
            mNodes[key] = data.type;
            mNodeLeaves.push_back( key );
          }
          else
            data.type = it->second; // get the type
        }
        else if( data.length == 1 && data.sources.front() == Source::dec_ab_common )
        {
          Key key = { mNodes.size() + 1 };

          data.type   = mNodes.size() + 1;
          mNodes[key] = data.type;
          mNodeLeaves.push_back( key );
        }
        // end setup type }}}
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
  for( Source source : mDatabase[i][j].sources )
  {
     switch( source )
     {
       case Source::dec_a:  collectResults( i - 1,  j,      lcs ); break;
       case Source::dec_b:  collectResults( i,      j - 1,  lcs ); break;
       case Source::dec_ab: collectResults( i - 1,  j - 1,  lcs ); break;
       case Source::dec_ab_common:

         lcs.push_back( mStringA[i-1] );

         if( lcs.size() == mDatabase[mStringA.size()][mStringB.size()].length )
         {
           mResults.push_back( lcs );
           reverse( mResults.back().begin(), mResults.back().end() );
         }
         else
           collectResults( i - 1, j - 1, lcs );

         lcs.pop_back();
         break;

       default: break;
     }
  }
}
/*}}}*/
void LCS::printResults() /*{{{*/
{
  cout << mResults.front().size() << " " << mResults.size() << "\n";

  for( const string &lcs : mResults )
     cout << lcs << "\n";
}
/*}}}*/
bool LCS::isSameType( const size_t i, const size_t j, const Type type ) /*{{{*/
{
  for( Source source : mDatabase[i][j].sources )
  {
     size_t typeT;

     switch( source )
     {
       case Source::dec_a:  typeT = mDatabase[i-1][j].type;   break;
       case Source::dec_b:  typeT = mDatabase[i][j-1].type;   break;
       case Source::dec_ab: typeT = mDatabase[i-1][j-1].type; break;
       default:             continue;
     }
     if( type == typeT ) return true;
  }
  return false;
}/*}}}*/
// end private member functions
// vim: foldmethod=marker foldmarker={{{,}}}
