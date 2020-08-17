module setsurface;
/*
surf <surfId> <surfType> <surfParam>

where:
    <surfId>    is the surface identifier.
    <surfType>  is the surface type
    <surParam>  are the parameters required for the surface type.

    +++++++++++++++++++++++++++++++++
    |surfType    |   surfParam      |
    +++++++++++++++++++++++++++++++++
    |sqr         |   x0, y0, s      |
    +-------------------------------+
    |rect        |   x0, y0, s1, s2 |
    +-------------------------------+
    |cyl         |   x0, y0, r      |
    +-------------------------------+
*/
import std.stdio;
import std.conv;
import core.stdc.stdlib: exit;

/**
* Macro information struct for a surface.
* used in geometry.d, track.d, reader.d
*/
struct SurfaceInfo
{
  string type; /**< surface type. */
  double xc; /**< center x value. */
  double yc; /**< center y value. */
  double param1; /**< first parameter. */
  double param2; /**< second parameter. */
  double refinement; /**< refinement value. */
}

int surfId;
string surfType;
double x, y, p1, p2;

/**set surface */
void setSurface(string[] line, int countLine)
{
    try
    {
        setSurfaceInfo(line);
    }
    catch(std.conv.ConvException e)
    {
        writefln("\n+++ Error: Incorrect parameters definition at line: %s\n", countLine -1);
        
        exit(0);
    }

}

void setSurfaceInfo(string[] line)
{
    surfId = to!int(line[1]);

    surfType = line[2];
    
    x = to!double(line[3]);

    y = to!double(line[4]);

    getSurfParam(surfType, line, p1, p2);

}

SurfaceInfo getSurfaceInfo()
{
    return SurfaceInfo( surfType, x, y, p1, p2);
}

int getSurfId()
{
    return surfId;
}

/**
  * obtains the surface parameters.
  * @param type the surface type.
  * @param param list of surface parameters.
  * @param[out] p1 surface parameter 1.
  * @param[out] p2 surface parameter 2.
  * @see parseSurf().
  */
  void getSurfParam(const string type, const string[] param, out double p1, out double p2)
  {
    switch (type)
    {
    case "rect":
      p1 = to!double(param[5]);
      p2 = to!double(param[6]);
      break;
    case "sqr":
      p1 = to!double(param[5]);
      p2 = p1;
      break;
    case "cyl":
      p1 = to!double(param[5]);
      p2 = 0.0;
      break;
    default:
      writefln("\n+++ Error: Unsupported surface: %s\n", type);
      exit(0);
    }
  }