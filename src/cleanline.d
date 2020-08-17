module cleanline;

import std.stdio;
import std.algorithm;
import std.string : split;
import std.conv;

string[] getCleanLine(string line)
{
    auto param = findSplitBefore(line, "%");

    return param[0].split();

}

string[] getNewCleanLine(File inputFile, File outputFile, int lineCount)
{
    const string newLine = inputFile.readln();

    outputFile.writef("%s-\t%s",lineCount, newLine);

    auto param = findSplitBefore(newLine, "%");

    return param[0].split();

}