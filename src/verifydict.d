module verifydict;

/*
Verify if some
*/
import setpins: Pin;

import std.stdio;
import core.stdc.stdlib: exit;

void verifyPinDictionary(int pinId, Pin[int] pinDict, int line)
{
    if(pinId !in pinDict)
    {
        writefln("\n+++ Error: Undefined refineId at line: %s\n", line -1 );
        exit(0);
    }

}