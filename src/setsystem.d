module setsystem;

/*
system <systemId>
    
where 

    <systemId> is the universe identifier.
*/

import main;

import std.stdio;
import std.string : split;
import core.stdc.stdlib : exit;

string systemId;

void setSystem(string[] line, int lineCount)
{
    writeln(line);
    try
    {
        systemId = line[1];
    }
    catch (core.exception.RangeError e)
    {
        writefln("\n+++ Error: Incorrect parameters definition at line: %s", lineCount - 1 );
        outputFile.writefln("+++ Error: Incorrect system definition");
        exit(0);
    }
}

string getSystem()
{
    return systemId;
}
