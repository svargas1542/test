module main;

/*
 * The main module of the gemma code
 */

import std.stdio;
import std.array;
import std.datetime.stopwatch;

import checkfile;
import readinput;

import verifyargs;

/********************************************************************/

string gemmaVersion = "0.07.20"; /**< gemma version*/

File inputFile; //**< Input file object*/

File outputFile; /**< Output file object*/

File logFile; /**< Log file object*/

bool debugOption = false;

/** Main function*/
void main(string[] args )
{

    verifyargs.verifyArgs(args);

    outputFile = File(output, "w"); // open output file


    debug(10)
    {
        debugOption = true;

        /* The log file is only used with -debug=10 option. 
         * See Makefile and dmd option -debug=<level> 
         */
        logFile = File("logFile.log", "w"); //open the log file
    }

    //verify if the inputFile exist
    checkfile.checkFile(input);

    inputFile = File(input, "r"); // open input file
    
    ReadInput readInput = new ReadInput();

    writefln(""); // last space
}


