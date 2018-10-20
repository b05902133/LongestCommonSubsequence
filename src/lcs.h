#ifndef LCS_H
#define LCS_H

#include <string>
#include <vector>

class LCS
{
  public:

    enum Source
    {
      dec_a,
      dec_b,
      dec_ab,
      null
    };

    struct Data;

    void exec( const std::string &a, const std::string &b );

  private:

    void initDatabase   ();
    void evalDatabase   ();
    void collectResults ();
    void collectResults ( size_t i, size_t j, std::string &lcs );
    void printResults   ();

    std::string mStringA;
    std::string mStringB;

    std::vector<std::vector<Data>>  mDatabase;
    std::vector<std::string>        mResults;
};

struct LCS::Data
{
  std::vector<Source> sources;
  int                 length;
};

#endif
