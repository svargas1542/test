module setmaterial;
/*
material <materialId> <masicDensity>
    <isotopeId_1>  <atomicDensity_1>
    ...
    <isotopeId_n>  <atomicDensity_n>

where:
    <materialId>    is the material identifier
    <masicDensity>  is the masic density of the material [gr/cm^3]
    <isotopeId_n>   is the isotope identifier
    <atomicDensity_n>   is the atomic density of each isotope [atm/barn-cm]
*/

import std.stdio;
import std.conv;
import core.stdc.stdlib : exit;

import main;
import readinput;
import cleanline;

/**
* Data for material
*/
struct MaterialInformation
{
    double masicDensity; /**< Masic density */
    double[string] atomicDensity; /**< Atomic density array for each material*/
}

string materialId; /**< Identifier of material*/
double masicDensity; //**< Masic density */
MaterialInformation[string] materialDict;

string[] lineData;

void setMaterial(string[] paramLine, int lineCount)
{
    string isotopeId;

    double[string] atomicDensity;

    materialId  = paramLine[1];

    masicDensity = to!double(paramLine[2]);
    debug(10)
    {
        logFile.writefln("readmaterial.setMaterial.materialId:\t%s", materialId );
    }

    while(true)
    {
        lineCount++;

        lineData = getNewCleanLine(inputFile, outputFile, lineCount);

        if(lineData.length ==2)
        {
            isotopeId = lineData[0];

            atomicDensity[isotopeId] = to!double(lineData[1]);

            materialDict[materialId] = MaterialInformation(masicDensity, atomicDensity);

        }
        else
        {
            if(lineData.length == 0)
            {
                break;
            }
            
        }

        debug(10)
        {
            logFile.writefln("readmaterial.setMaterial.isotopeId:\t%s, atomicDensity:\t%s", isotopeId, to!double(lineData[1]) );
        }

    }
}