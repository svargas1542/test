module verifyargs;

/*
 * verify arguments from console line
 * .\gemmaw0.1.exe -i <InputFile> [options]
 *  where:
 *          <InputFile> the input file name\n"
 *          [options]:
 *                  -o <OutputFile> the output file name (default: output.o)
 *                  -h  print help and exit
 *                  -v  print gemma version.
 */

import std.stdio;
import core.stdc.stdlib : exit;
import std.getopt;

import main;

string input ; /**< input file name*/

string output = "output.out";/**< output file name*/

/***/
void verifyArgs(string[] args)
{
    if ( args.length == 1 )
    {
        missingInputFile();
    }
    else
    {
        foreach(option; args)
        {
            if( option == "-v") // printe gemma version
            {
                gVersion(gemmaVersion);
            }

            if ( option == "-h" ) // print gemma options
            {
                menuOptions();
            }
        }
    }     
    
    getopt(args, "o", &output, "i", &input); // get options arguments
 
    if ( input == "blank" )
    {
        missingInputFile();
    }

}

/** Print options for gemma code*/
void menuOptions()
{
    string options = "Gemma MOC code (C), "
                    ~ "All Rights Reserved written by Guillermo Ibarra\n"
                    ~ "Usage:\n"
                    ~ "\tgemma.exe -i <InputFile> [options]\n"
                    ~ "Where:\n"
                    ~ "\t<InputFile>\tInput file name\n"
                    ~ "<options>:\n"
                    ~ "\t-o <OutputFile>\t\tOutput file name (default: output.o)\n"
                    ~ "\t-h\t\t\tprint help and exit\n"
                    ~ "\t-v\t\t\tprint gemma version\n";

    writeln(options);

    exit(0);
}

/** Print message:  missing input file*/
void missingInputFile()
{
    string missing = "*** Error *** Missing input file.\n"
                    ~ "Usage:\tgemma.exe -i <InputFile> [options]\n";
 
    writefln(missing);

    exit(0);
}

/** Print the gemma version*/
void gVersion(string gemmaVersion)
{
    string message = "Gemma version: " ~ gemmaVersion;

    writeln(message);
    
    exit(0);
}