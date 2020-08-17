module setmacro;

/*
macro <groups>

where:

    <groups>    is the number of energy groups

Note: the macro card must be defined before of materials definition
    
*/

import std.stdio;
import std.conv;
import core.stdc.stdlib : exit;

void setMacro(string[] line, int lineCount)
{
    try
    {
        assert( to!int(line[1]) );
    }
    catch(core.exception.AssertError e) 
    {
        writefln("\n+++ Error: Incorrect parameters definition at line %s\n", lineCount - 1);
        exit(0);
    }
    catch(core.exception.RangeError e)
    {
        writefln("\n+++ Error: Incorrect parameters definition at line %s\n", lineCount - 1);
        exit(0);
    }
}