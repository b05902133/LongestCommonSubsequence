import java.io.*;

class Main
{
  public static void main( String[] args ) throws IOException
  {
    int inputNum = 2;

    BufferedReader  br            = new BufferedReader( new InputStreamReader( System.in ) );
    String[]        inputs        = new String[inputNum];
    int             readyInputNum = 0;

    while( readyInputNum < inputNum )
    {
      String[] buffer = br.readLine().split( "\\s+" );

      for( int i = 0 ; i < buffer.length ; ++i )
      {
         if( readyInputNum >= inputNum ) break;

         inputs[readyInputNum++] = buffer[i];
      }
    }
    System.out.println( inputs[0] + ", " + inputs[1] );
  }
}
