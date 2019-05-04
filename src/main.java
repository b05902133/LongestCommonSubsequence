import java.io.*;

class Main
{
  public static void main( String[] args ) throws IOException
  {
    int inputNum = 2;

    BufferedReader  br            = new BufferedReader( new InputStreamReader( System.in ) );
    String[]        inputs        = new String[inputNum];
    int             readyInputNum = 0;
    LCS             lcs           = new LCS();

    while( readyInputNum < inputNum )
    {
      String[] buffer = br.readLine().split( "\\s+" );

      for( int i = 0 ; i < buffer.length ; ++i )
      {
         if( readyInputNum >= inputNum ) break;

         inputs[readyInputNum++] = buffer[i];
      }
    }
    lcs.exec( inputs[0], inputs[1] );
  }
}
