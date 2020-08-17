module setrefine;

/*
 refine <type> <id> <parameters>
 where:
    <type>  is the refinement type, available: pin, surf.
    <refineId>    is the item to be refined, either pin id or surface id.

    <parameters> are the refinement parameters based on the type

    if pin type: <parameters> = <divisions> <inner> <outer>
    where:
        <divisions> is the pin cell division factor, where division = 2^n
        <inner>     is the number of inner rings added
        <outer>     is the number of outer rings added

    if surf type: <parameters> = <area>
    where:
        <area>  is the desired area of regions.
*/

import main;

import std.stdio;
import core.stdc.stdlib: exit;
import core.exception;
import std.conv;

string type;
int refineId;
int[] parameters;

void setRefineParameters(string[] paramLine, int countLine)
{
    type = paramLine[1];

    destroy(parameters);
    
    switch(type)
    {

        case "pin":

            try
            {
                assert(paramLine.length == 6);

                refineId = to!int(paramLine[2]);

                parameters ~= to!int(paramLine[3]); // divisions

                parameters ~= to!int(paramLine[4]); // inner

                parameters ~= to!int(paramLine[5]); // outer
            }
            catch (core.exception.AssertError e)
            {
                writefln("\n+++ Error: missing parameter in line: %s\n", countLine - 1 );
                outputFile.writefln("+++ Error: missing parameter ");
                exit(0);
            }
            catch(std.conv.ConvException e)
            {
                writefln("\n+++ Error: Incorrect values definition at line: %s\n", countLine -1 );
                outputFile.writefln("+++ Error: Incorrect values definition " );
                exit(0);
            }   

        break;

        default:

            writefln("\n+++ Error: Unsupported refinement: %s\n", type);

            exit(0);

    }
}

int[] getParameters()
{
    return parameters;
}


int getRefineId()
{
    return refineId;
}
