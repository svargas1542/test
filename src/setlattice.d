module setlattice;

import std.algorithm : canFind;
import std.stdio;
import std.conv : to;
import std.string : split;
import core.stdc.stdlib : exit;

import main;
import setpins;


//-------------------------------------------------------------------//

/**
* Macro information struct for a lattice.
* used in reader.d.
*/
struct Lattice
{
    int type;           /**< lattoce type. */
    double x;           /**< center x value. */
    double y;           /**< center y value. */
    int rows;           /**< number of rows. */
    int columns;        /**< number of columns. */
    double pitch;       /**< pitch, distance between pins. */
    int[][] map;        /**< pin map layout. */
}

//-------------------------------------------------------------------//

int latticeId, latticeType, rows, columns;
int[][] map;

double xCoor, yCoor, pitch;

Lattice[int] latticeDict; /**< dictionary of defined lattce information. */

string[string] mUniverseType;

void setLattice(string[] paramLine, int lineCount, Universes[int] universes)
{
    string rowLine;

    try
    {
        latticeId = to!int(paramLine[1]);

        latticeType = to!int(paramLine[2]);

        xCoor = to!double(paramLine[3]);

        yCoor = to!double(paramLine[4]);

        rows = to!int(paramLine[5]);

        columns = to!int(paramLine[6]);

        pitch = to!double(paramLine[7]);

        assert(latticeId !in universes);

        universes[latticeId] = Universes("lattice");

    }
    catch( std.conv.ConvException e)
    {
        writefln("+++ Error at line: %s, incorrect parameters definition", lineCount);

        outputFile.writeln("+++ Error: incorrect parameters definition");

        exit(0);
    }
    catch( core.exception.AssertError e)
    {
        writefln("+++ Error at line: %s, incorrect parameter definition", lineCount);
        outputFile.writeln("+++ Error: universe Id already exist");
        exit(0);
    }

    map = new int[][](rows, columns);
    
    latticeDict[latticeId] = Lattice(latticeType, xCoor, yCoor, rows, columns, pitch, map);

    mUniverseType[ paramLine[1] ] = "lattice";

    try
    {
        for (int i; i < rows; i++)
        {
            rowLine = inputFile.readln();

            lineCount++;

            outputFile.writef("%s-\t%s", lineCount, rowLine);

            auto row = rowLine.split();

            for (int j; j < columns; j++)
            {
                map[i][j] = to!int(row[j]);

                try
                {
                    if ( [0, 1].canFind( latticeType ) )
                    {   
                        if(to!int(row[j]) !in universes || to!int(row[j]) in latticeDict )
                        {
                            writefln("+++ Error at line: %s", lineCount);

                            outputFile.writefln("+++ Error: not universe definition or universe al ready exist");

                            exit(0);
                        }
                    }
                }
                catch (core.exception.AssertError e)
                {
                    writefln("+++ Error at line: %s", lineCount);

                    outputFile.write("+++ Error: universe alredy exist");

                    exit(0);
                }

            }
        }
    }
    catch (core.exception.RangeError e)
    {
        writeln("+++ Error 1");
    }
    catch (std.conv.ConvException e)
    {
        writeln("+++ Error 2");
    }
    catch (core.exception.AssertError e)
    {
        writefln("+++ Error at line: %s", lineCount);

        outputFile.write("+++ Error: not universe definition");

        exit(0);
    }
    }

/**
  * Getter method: universe type.
  * @returns universe type.
  */
  @property string[string] getUniType()
  {
    return mUniverseType;
  }

  @property Lattice[int] getLattice()
  {
      return latticeDict;
  }