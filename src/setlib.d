module setlib;

/*
 lib <dirLib>

 where:
    <dirLib>   cross section directory file paths

Note: If GEMMA_DATA enviorement is defined, <dirLib> must be the 
directory where the inventory.dat file exist.
If GEMMA_DATA is not defined, <dirLib> must be the complet directory
path where the inventory.dat file exist.
 */

import checkfile;

import std.stdio;
import std.process;
import std.array;

string path;

void setLib(string[] line, int lineCount)
{

    string dataPath = environment.get("GEMMA_DATA");
    
    if(dataPath is null)
    {
        write("\n+++ No GEMMA_DATA enviorement path\n");

        path = "\\" ~ line[1] ~ "\\inventory.dat";

        checkfile.checkFile( path );
    }
    else
    {
        version(windows)
        {
            path = dataPath ~ "\\" ~ line[1] ~ "\\inventory.dat";

            checkfile.checkFile( path );
        }

        version(linux)
        {
            path = dataPath ~ "/" ~ line[1] ~ "/inventory.dat";

            checkfile.checkFile( path );
        }
    }

}

string getPath()
{
    return path;
}

