import java.util.Vector;
import java.util.HashSet;

class LCS
{
  private enum Source
  {
    DEC_A,
    DEC_B,
    DEC_AB,
    NULL
  }

  public void exec( String a, String b )
  {
  }

  private void initDatabase()
  {
  }

  private void evalDatabase()
  {
  }

  private void collectResults()
  {
  }

  private void collectResults( int i, int j, String lcs )
  {
  }

  private void printResults()
  {
  }

  private void removeBothSide( int i, int j )
  {
  }

  private void removeOneSide( int i, int j, Source source )
  {
  }

  private Data dataSource( int i, int j, Source source )
  {
    return null;
  }

  String mStringA;
  String mStringB;

  Data[][]        mDatabase;
  Vector<String>  mResults;
}

class Data
{
  public HashSet<CharPair>  sources;
  public int                length;
}

class CharPair
{
  public char first;
  public char second;
}
