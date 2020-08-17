module setcell;
/*
cell <cellId> <cellUniverse> <material> <surfId_1> <surfId_2> ...

where:
    <cellId>                    is the cell identifier. 
    <universeId>                is the universe identifier, read as a string
    <material>                  is the cell material
    <surfId_1> <surfId_2> ...   are the surfaces boundaries.
*/
import std.stdio;
import std.conv;
import core.stdc.stdlib : exit;
import std.algorithm;

final class SetCell
{
    private:

    string cellId; /**< Cell identifier */

    string material;    /**< material */

    int cellUniverse;   /**< Cell universe identifier*/

    string[] surfId;    /**< surfaces boundary of each cell*/

    int[][int] map; /**< Cell map struct*/

    int topLevel;   /**< */

    string[int] surfaceMats;    /**< surface material array*/

    int outer;  /**< */

    int[] inner;    /**< */

    Cell[string] cellDict;  /**< Global cell Dictionary*/

    Cell setCellDict;   /**< Cell dictionary for each cell*/

    void setCell(string[] line, int lineCount)
    {
        try
        {
            cellId = line[1];

            cellUniverse = to!int(line[2]);

            material = line[3];

            assert(line[4 .. $].length != 0);

            surfId = line[4 .. $];
        }
        catch(std.conv.ConvException e)
        {
            writefln("\n+++ Error: Incorrect parameters definition at line: %s\n", lineCount - 1);
            exit(0);
        }
        catch(core.exception.AssertError e)
        {
            writefln("\n+++ Error: Incorrect parameters definition at line %s\n", lineCount - 1);
            exit(0);
        }

        if(cellId in cellDict)
        {
            writefln("\n+++ Error: cellId already exist at line: %s\n", lineCount - 1);
            exit(0);
        }
        else
        {
            

            if( surfId.length > 1)
            {
                auto updated = sweepSurfaceArray( surfId, lineCount);

                outer = updated[0] * -1;

                inner = updated[1 .. $];

                return;
            }
            else if( surfId.length == 1)
            {
                try
                {
                    assert(to!int(surfId[0]) < 0);
                }
                catch(core.exception.AssertError e)
                {
                    writefln("\n+++ Error: Incorrect cell definition at line: %s", lineCount);

                    writefln("+++ Must have a negative inner surface");

                    exit(0);
                }

                outer = to!int(surfId[0]) * - 1;

                return;
            }
        }

        topLevel = outer;

        map[outer] = inner;

        surfaceMats[outer] = material;
    }

    /**
    * Parses all inner surfaces and checks correctness.
    * @param  surfaces inner surfaces.
    * @param  line     input file line, needed for error message.
    * @see    getSurfaces().
    * @throws cLogicError incorrect cell card definition.
    * @return inner surfaces that are checked and converted to int type.
    */
    int[] sweepSurfaceArray(const string[] surfaces, int lineCount) 
    {
        int[] updatedValues;

        foreach (surf; surfaces) 
        {
            auto value = to!int(surf);

            updatedValues ~= value;
        }

        updatedValues.sort!("a < b");

        auto rest = updatedValues[1 .. $];

        if (any!"a < 0"(rest))
        {
            writefln("\n+++ Error: Incorrect cell definition at line: %s", lineCount - 1 );

            writeln("+++ Too many inner surfaces\n");

            exit(0);
        }
        return updatedValues;
    }

    public:

    this(string[] line, int lineCount, Cell[string] cellDict)
    {
        this.cellDict = cellDict;

        setCell(line, lineCount);

        setCellDict = Cell(cellUniverse, material, surfId);
    }

    /**
    *@return cell identifier
    */
    @property string getCellId()
    {
        return cellId;
    }

    /**
    * @return cel map structure.
    */
    @property int[][int] getMap()
    {
        return map;
    }

    /**
    * @return topLevel.
    */
    @property int getTop()
    {
        return topLevel;
    }

    /**
    * @return Surface material array.
    */
    @property string[int] getSurfaceMats()
    {
        return surfaceMats;
    }

    /**
    *@return cell dictionary
    */
    @property Cell getCellDict()
    {
        return setCellDict;
    }
}

/** Struct for cel dictionary*/
struct Cell
{
    int cellUniverse;
    string material;
    string[] surfId;
}


