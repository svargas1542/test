module setpins; 

/*
pin <pinId>
<materialId_1> <radius_1>
...
<materialId_n> <radius_n>

where:
    <pinId>         is the pin identifier
    <material_n>    are the material identifier
    <radius_n>      are the outer raddi of the material rings.

Note: radius_1 < radius_2 < ... < radius_n
*/




/*****************************************************************************/

import cleanline;
import main;

/*****************************************************************************/

import std.algorithm;
import std.stdio;
import std.conv : to;
import std.string : split;
import core.stdc.stdlib;

/*****************************************************************************/

/** struct for pin dictionary*/
struct Pin
{
    double[string] materialId; /**< material Id and radious*/
    int[3] parameters;  /**< <division> <inner> <outer> or <area> see readrefine module*/
}

/** struct fot universes dictionary*/
struct Universes
{
    string universetype; /**< universe type*/
}

/*****************************************************************************/

/** @brief Class for check the pin card. */
final class ReadPins
{
    private:

    int pinId;          /**< Pin identifier*/

    double[] radius;    /**< radius of each material */
    string[] materials;  /**< material */
    double old = 0.0;
    
    Universes[int] pinUnivers; /**< Pin Universes dictionary*/

    string[] line;

    int lineCount;
    double rad;
    string materialId;
    string[] lineData;
    double[string] mat;
    double infinity = 1E+10;

    void correctDefinition()
    {
        // verify correct definition of pin card
        try
        {
            pinId = to!int(line[1]);

            debug(10)
            {
                logFile.writefln("readpins.setPin.pinId:\t%s", pinId);
            }
        }
        catch (std.conv.ConvException e)
        {
            writeln("*** Error Incorrect definition in pin card");

            outputFile.writefln("+++ Error +++ Incorrect definition in pin card", );
        }

    }

    void setPins()
    {
        if(pinId in pinUnivers)
        {
            writefln("*** Error, at line: %s, universe: %s already exist", lineCount , pinId);
            exit(0);
        }
        else
        {
            pinUnivers[pinId] = Universes(to!string(line[0]));

            do
            {
                lineData = getNewCleanLine(inputFile, outputFile, lineCount);

                if(lineData.length == 1)
                {
                    mat[to!string(lineData[0])] = infinity;
                    materials ~= lineData[0];
                }
                else
                {
                    try
                    {
                        rad = to!double(lineData[1]);
                    }
                    catch (std.conv.ConvException e)
                    {
                        writeln("*** Error: Incorrect pin definition at line: ", lineCount);

                        outputFile.writefln("*** Error: Incorrect pin definition at line", lineCount);

                        exit(0);
                    }
                    
                    materials ~= lineData[0];
                    if(rad > 0.0 && rad > old)
                    {
                        old = rad;
                        mat[to!string(lineData[0])] = to!double(lineData[1]);

                        radius ~= rad;
                        
                    }
                    else
                    {
                        writefln("*** Error in pin definition, line: %s", lineCount);
                    }                    
                }
            
                lineCount++;

            }while(lineData.length != 1);   
        }
    }

    public:

    /** Constructor */
    this(string[] line, int lineCount, Universes[int] pinUnivers)
    {
        this.line = line;

        this.lineCount = lineCount;

        this.pinUnivers = pinUnivers;

        correctDefinition();

        setPins();
    }

    double[string] getMat()
    {
        return mat;
    }

    /** Return pin Universes*/
    @property Universes[int] getUniverses()
    {
        return pinUnivers;
    }

    /**< return number of line*/
    int getCountLine()
    {
        return lineCount;
    }

    /**< return pin ID*/
    int getPinId()
    {
        return pinId;
    }

}

