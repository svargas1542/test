module readquadrature;

/*
quadrature <numAzim> <separation> <numPolar>

where: 
    <numAzim>      is the number of azimuthal angles, in multiples of 4
    <separation>   is the desired separation between tracks
    <numPolar>     is the number of polar angles, Legendre quadrature.
*/

/*****************************************************************************/

import std.stdio;
import std.conv : to;
import std.string : split;
import core.stdc.stdlib : exit;

/*****************************************************************************/

/**
* Quadrature information struct.
*/
struct Quadrature
{
    int numAzim = 4;                /**< number of azimuthal angles. */

    double separation = 0.2;          /**< desired distance between tracks. */

    int numPolar = 6;               /**< number of polar angles. */

    string polarType = "ty";    /**< polar angle quadrature type, gl/ty. */
}

Quadrature quadrature; /**< system quadrature information. */

string message = "\n+++ Error: Incorrect parameters definition at line: %s\n";

/* set quadrature card */
void setQuadrature(string[] line, int lineCount)
{
    try
    {
        quadrature.numAzim = to!int(line[1]);

        quadrature.separation = to!double(line[2]);

        quadrature.numPolar = to!int(line[3]);

        assert(quadrature.numAzim % 4 == 0 && quadrature.numPolar % 2 == 0);

    }
    catch (std.conv.ConvException e)
    {
        writefln(message, lineCount - 1 );
        exit(0);
    }
    catch (core.exception.RangeError e)
    {
        writefln(message, lineCount - 1 );
        exit(0);
    }
    catch (core.exception.AssertError e)
    {
        writefln(message, lineCount - 1 );
        exit(0);
    }

}

Quadrature getQuadrature()
{
    return quadrature;
}


