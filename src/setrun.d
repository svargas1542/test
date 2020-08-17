module setrun;

/*
run <maxIter> <tolerance>

where:
    <maxIter>   is the maximum number of iterations or transport sweeps.
                (default 1000)

    <tolerance> is the convergence criteria.
                A value of e = 1X10E-06 is suggested for most calculations. 
                A maximum number of iterations (defautl: 1x10E-06).
*/

import main;

import std.stdio;
import std.conv;
import std.string;
import core.stdc.stdlib : exit;

int maxIter = 1000;         /**< maximum number of iterations. */

double tolerance = 1E-06;   /**< convergence criteria. */

string error = "\n+++ Error: Incorrect parameters definition";

void setRun(string[] line, int lineCount)
{
    try
    {
        maxIter = to!int(line[1]);

        tolerance = to!double(line[2]);
        
        assert(maxIter > 0);
    }
    catch (std.conv.ConvException e)
    {
        writefln("%s at line: %s\n", error, lineCount - 1);

        outputFile.writefln("%s", error);

        exit(0);
    }

    catch (core.exception.AssertError e)
    {
        writefln("%s at line: %s", error, lineCount -1 );

        outputFile.writefln("%s", error);

        exit(0);
    }
    
    catch (core.exception.RangeError e)
    {
        writefln("%s at line: %s", error, lineCount);

        outputFile.writefln("%s", error);

        exit(0);
    }
}

int getMaxIter()
{
    return maxIter;
}
double getTolerance()
{
    return tolerance;
}
