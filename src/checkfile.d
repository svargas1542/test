module checkfile;

/*
 * Verify if some file exist
 */

/******************************************************************************/

import main;

import std.stdio;
import std.file: isFile;
import core.stdc.stdlib;

/******************************************************************************/

/**@brief Check if some file exist */

void checkFile(string file)
{
    try
    {
        file.isFile;
    }
    catch (std.file.FileException e)
    {
        writefln("\n+++ Error: file \"%s\" does not exist\n", file);

        outputFile.writefln("*** Error: file \"%s\" does not exist", file);

        exit(0);
    }
}



