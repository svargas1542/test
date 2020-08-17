module readinput;
/*
 * Read the input file
 */

import std.stdio;
import std.algorithm : findSplit, canFind;
import std.typecons : Tuple;
import std.conv : to;
import std.array;
import core.stdc.stdlib : exit;

import main;

import cleanline;
import verifydict;

import setpins;
import setquadrature;
import setboundary;
import setsystem;
import setrun;
import setlib;
import setmaterial;
import setlattice;
import setrefine;
import setsurface;
import setcell;
import setmacro;

/*------------------------------------------------------------------------------------------------*/
final class ReadInput
{
    private:

    string system = "None"; /**< system universe identifier. */

    Quadrature quadrature; /**< quadrature information struct*/

    Boundary boundaryConditions; /**< boundary conditions struct*/

    double[int] run; /**< run parameters [maxIter: tolerance]*/

    int lineCount = 1; /**< counter of lines */

    string cleanedLine; /**< Clean line*/

    string[] paramLine; /**< parameters line*/

    Pin[int] pinDict; /**< pin dictionary*/

    string inventoryPath; /**< Path to inventory.dat file*/

    SurfaceInfo[int] surfaceDict; /**< dictionary of defined surfaces. */

    Cell[string] cellDict; /**< cel dictionary*/

   



    Universes[int] universes; /**< Universes Dictionary, see readpins module*/

    string[string] mUniverseType; /**< dictionary of defined universe types. */

    Lattice[int] mLatticeDict; /**< dictionary of defined lattce information. */

    //Material[string] mMaterialDict; /**< dictionary of specified materials. */

    void readInputFile()
    {
        foreach(line; inputFile.byLine)
        {
            outputFile.writefln("%s-\t%s", lineCount, line);

            lineCount ++;

            paramLine = cleanline.getCleanLine(to!string(line));            

            if(paramLine.length == 0)
            {
                continue; // blank line
            }
            else
            {
                /*--------------------------------------------------------------------------------*/
                if(paramLine[0] == "quadrature")
                {
                    setquadrature.setQuadrature(paramLine, lineCount);

                    quadrature = setquadrature.getQuadrature(); 

                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "boundary")
                {
                    setboundary.setBoundaryConditions(paramLine, lineCount);

                    boundaryConditions = setboundary.getBoundaryConditions();
                }
                
                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "refine")
                {
                    setrefine.setRefineParameters(paramLine, lineCount);

                    verifydict.verifyPinDictionary( setrefine.getRefineId(), pinDict, lineCount);

                    pinDict[setrefine.getRefineId()].parameters = setrefine.getParameters();
                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "system")
                {
                    setsystem.setSystem(paramLine, lineCount);

                    system = setsystem.getSystem();
                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "run")
                {
                    setrun.setRun( paramLine, lineCount );
                    run[ setrun.getMaxIter() ] = setrun.getTolerance();
                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "lib")
                {
                    setlib.setLib(paramLine, lineCount);

                    inventoryPath = setlib.getPath();
                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "surf")
                {
                    setsurface.setSurface(paramLine, lineCount);

                    surfaceDict[setsurface.getSurfId()] = setsurface.getSurfaceInfo();

                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "macro")
                {
                    setmacro.setMacro(paramLine, lineCount);
                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "cell")
                {
                    SetCell setCell = new SetCell(paramLine, lineCount, cellDict);

                    cellDict[setCell.getCellId()] = setCell.getCellDict();
                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "pin")
                {                    
                    ReadPins readpins = new ReadPins(paramLine, lineCount, universes);

                    lineCount = readpins.getCountLine();

                    universes = readpins.getUniverses();

                    pinDict[ readpins.getPinId() ] = Pin(readpins.getMat());
                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "lattice")
                {
                    setlattice.setLattice(paramLine, lineCount, universes);

                    mUniverseType = setlattice.getUniType();

                    mLatticeDict = setlattice.getLattice();

                }

                /*--------------------------------------------------------------------------------*/
                else if(paramLine[0] == "material")
                {
                    setmaterial.setMaterial(paramLine, lineCount);

                }

                /*--------------------------------------------------------------------------------*/
                else
                {
                    outputFile.writefln("+++ Error +++ unrecognized input card \"%s\"", paramLine[0]);

                    writefln("+++ Error: Unrecognized input card \"%s\" at line: %s ", paramLine[0], lineCount);

                    exit(0);
                }
                
            }     
            
        }

    }
    
    public:

    this()
    {
        outputFile.writeln("\nInput data:");

        readInputFile();
    }

    /**
     * @return run parameters: <maxIter> <tolerance>
     * in form: [maxIter: tolerance]
     */
    double[int] getRun()
    {
        return run;
    }

    /**
     * @return duadrature struct
     * @see readquadrature module
     */
    Quadrature getQuadrature()
    {
        return quadrature;
    }

    /**
     * @return boundary conditions struct,
     * @see readboundary module
     */
    Boundary getBoundaryConditions()
    {
        return boundaryConditions;
    }

    /**
    * @returns universe system.
    */
    @property string getSystem()
    {
        return system;
    }

    /**
     * @return Path to inventoru.dat file
     */
    @property string getInventoryPath()
    {
        return inventoryPath;
    }



    Universes[int] getUniverses()
    {
        return universes;
    }

    string getInventory()
    {
        return inventoryPath;
    }


    MaterialInformation[string] getMatInfo()
    {
        return materialDict;
    }
    /**
    * Getter method: universe type.
    * @returns universe type.
    */
    @property string getUniType()
    {
        return mUniverseType[system];
    }


    @property Pin[int] getPinDict()
    {
        return pinDict;
    }
    /**
    * Getter method: lattice dictionary.
    * @returns latticeDict.
    */
    @property Lattice[int] getLattice()
    {
        return mLatticeDict;
    }
}


