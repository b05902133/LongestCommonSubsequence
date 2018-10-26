#ifndef LCS_H
#define LCS_H

#include <string>
#include <vector>
#include <map>
#include <utility>
#include <set>

class LCS /*{{{*/
{
  public: /*{{{*/

    enum Source /*{{{*/
    {
      dec_a,
      dec_b,
      dec_ab,
      null
    };
    /*}}}*/
    struct Data;

    void exec( const std::string &a, const std::string &b );
    /*}}}*/
  private: /*{{{*/

    using CharPair = std::pair<size_t,size_t>;

    static const Data nullData;

    void initDatabase   ();
    void evalDatabase   ();
    void collectResults ();
    void collectResults ( const size_t i, const size_t j, std::string &lcs );
    void printResults   () const;

    void removeBothSide ( const size_t i, const size_t j );
    void removeOneSide  ( const size_t i, const size_t j, const Source source );

    const Data& dataSource( const size_t i, const size_t j, const Source source ) const;

    std::string mStringA;
    std::string mStringB;

    std::vector<std::vector<Data>>  mDatabase;
    std::vector<std::string>        mResults;
    /*}}}*/
};
/*}}}*/
struct LCS::Data /*{{{*/
{
  std::set<CharPair> sources;
  size_t             length;
};
/*}}}*/
#endif
// vim: foldmethod=marker foldmarker={{{,}}}
