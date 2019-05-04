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

  public LCS()
  {
    mResults = new Vector<String>();
  }

  public void exec( String a, String b )
  {
    mStringA = a;
    mStringB = b;

    initDatabase  ();
    evalDatabase  ();
    collectResults();

    mResults.sort( null );

    printResults();
  }

  private void initDatabase()
  {
    mDatabase = new Data[mStringA.length()+1][mStringB.length()+1];

    for( int i = 0 ; i < mDatabase.length ; ++i )
       for( int j = 0 ; j < mDatabase[i].length ; ++j )
       {
          mDatabase[i][j] = new Data();

          if( i == 0 || j == 0 )
            mDatabase[i][j].length = 0;
       }
  }

  private void evalDatabase()
  {
    for( int i = 1 ; i < mDatabase.length ; ++i )
       for( int j = 1 ; j < mDatabase[i].length ; ++j )
       {
          removeBothSide( i, j );
          removeOneSide( i, j, Source.DEC_A );
          removeOneSide( i, j, Source.DEC_B );
       }
  }

  private void collectResults()
  {
    StringBuilder lcs = new StringBuilder( Integer.max( mStringA.length(), mStringB.length() ) );

    collectResults( mStringA.length(), mStringB.length(), lcs );
  }

  private void collectResults( int i, int j, StringBuilder lcs )
  {
    for( CharPair charPair : mDatabase[i][j].sources )
    {
       lcs.append( mStringA.charAt( charPair.first ) );
       if( lcs.length() == mDatabase[mStringA.length()][mStringB.length()].length )
       {
         mResults.add( lcs.reverse().toString() );
         lcs.reverse();
       }
       else
         collectResults( charPair.first, charPair.second, lcs );
       lcs.deleteCharAt( lcs.length() - 1 );
    }
  }

  private void printResults()
  {
    System.out.println( mResults.firstElement().length() + " " + mResults.size() );

    for( String lcs : mResults )
       System.out.println( lcs );
  }

  private void removeBothSide( int i, int j )
  {
    Data data     = mDatabase[i][j];
    Data dataDec  = dataSource( i, j, Source.DEC_AB );

    data.length = dataDec.length;

    if( mStringA.charAt( i-1 ) == mStringB.charAt( j-1 ) )
    {
      ++data.length;
      data.sources.add( new CharPair( i - 1, j - 1 ) );
    }
  }

  private void removeOneSide( int i, int j, Source source )
  {
    Data data     = mDatabase[i][j];
    Data dataDec  = dataSource( i, j, source );

    if( dataDec.length > data.length )
    {
      data.length   = dataDec.length;
      data.sources  = dataDec.sources;
    }
    else if( dataDec.length == data.length )
      data.sources.addAll( dataDec.sources );
  }

  private Data dataSource( int i, int j, Source source )
  {
    switch( source )
    {
      case DEC_A:   return mDatabase[i-1][j];
      case DEC_B:   return mDatabase[i][j-1];
      case DEC_AB:  return mDatabase[i-1][j-1];
      default:      return null;
    }
  }

  String mStringA;
  String mStringB;

  Data[][]        mDatabase;
  Vector<String>  mResults;
}

class Data
{
  public Data()
  {
    sources = new HashSet<CharPair>();
  }

  public HashSet<CharPair>  sources;
  public int                length;
}

class CharPair
{
  public CharPair( int i, int j )
  {
    first   = i;
    second  = j;
  }

  public int first;
  public int second;
}
