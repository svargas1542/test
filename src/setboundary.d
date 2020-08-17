module setboundary;

/*
boundary <side> <condition>

where
    <side>      is the boundary being modified, options include: 
                top, bottom, right, left or all.

    <condition> is the desired condition, options include: 
                vacuum or reflective.
*/

import std.algorithm : canFind;
import std.stdio;
import core.stdc.stdlib: exit;

/**
* System boundary conditions
*/
struct Boundary
{
    int top;        /**< top boundary condition. */
    int bottom;     /**< bottom boundary condition. */
    int left;       /**< left boundary condition. */
    int right;      /**< right boundary condition. */
}

Boundary boundaryConditions;

void setBoundaryConditions(string[] line, int lineCount)
{
    
    try
    {
        assert(canFind(["all", "top", "right", "left", "bottom"], line[1]));

        assert(canFind(["reflective", "vacuum"], line[2]));  
    }
    catch (core.exception.AssertError e)
    {
        writefln("\n+++Error: Incorrect parameter definition at line: %s\n", lineCount - 1 );

        exit(0);
    }
    catch (core.exception.RangeError e)
    {
        writefln("\n+++Error: Incorrect parameter definition at line: %s\n", lineCount - 1 );

        exit(0);
    }

    int cond = (line[2] == "reflective") ? 1 : 0;

    final switch (line[1])
    {
        case "all":

            boundaryConditions.top = cond;

            boundaryConditions.bottom = cond;

            boundaryConditions.right = cond;

            boundaryConditions.left = cond;

            break;

        case "top":

            boundaryConditions.top = cond;

            break;

        case "bottom":

            boundaryConditions.bottom = cond;

            break;

        case "right":

            boundaryConditions.right = cond;

            break;

        case "left":

            boundaryConditions.left = cond;
            
            break;
    }
}

/** getter method, return boundary conditions*/
Boundary getBoundaryConditions()
{
    return boundaryConditions;
}