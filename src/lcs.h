#ifndef LCS_H
#define LCS_H

#include <string>
#include <vector>
#include <map>
#include <tuple>
#include <set>

class LCS /*{{{*/
{
  public: /*{{{*/

    enum Source /*{{{*/
    {
      dec_a,
      dec_b,
      dec_ab,
      dec_ab_common,
      null
    };
    /*}}}*/
    struct Data;

    void exec( const std::string &a, const std::string &b );
    /*}}}*/
  private: /*{{{*/

    using Type  = size_t;
    using Key   = std::set<Type>;

    void initDatabase   ();
    void evalDatabase   ();
    void collectResults ();
    void collectResults ( const size_t i, const size_t j, std::string &lcs );
    void printResults   ();

    bool isSameType( const size_t i, const size_t j, const Type type );

    std::string mStringA;
    std::string mStringB;

    std::vector<std::vector<Data>>  mDatabase;
    std::vector<std::string>        mResults;

    std::map<Key,Type>  mNodes;
    std::vector<Key>    mNodeLeaves;
    /*}}}*/
};
/*}}}*/
struct LCS::Data /*{{{*/
{
  std::vector<Source> sources;
  size_t              length;
  Type                type;
};
/*}}}*/
#endif
// vim: foldmethod=marker foldmarker={{{,}}}
