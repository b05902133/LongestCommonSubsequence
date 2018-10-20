#include <iostream>
#include <string>
using namespace std;

#include "lcs.h"

int main()
{
  LCS engine;

  string a;
  string b;

  if( cin >> a >> b )
    engine.exec( a, b );

  return 0;
}
