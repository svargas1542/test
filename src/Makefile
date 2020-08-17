#
# Gemma Makefile
#

#GNU compiler

DC = dmd
DFLAGS = -w -de -O -version=windows

#

OBJS = 	checkfile.obj\
		cleanline.obj\
		main.obj\
		readinput.obj\
		setboundary.obj\
		setcell.obj\
		setlattice.obj\
		setlib.obj\
		setmacro.obj\
		setmaterial.obj\
		setpins.obj\
		setquadrature.obj\
		setrefine.obj\
		setrun.obj\
		setsurface.obj\
		setsystem.obj\
		verifyargs.obj\
		verifydict.obj\

#EXE = gemma0.1
EXE = gemmaw0.1.exe
#

.PHONY : all
all : $(EXE)
	@echo " gemma code compiled *OK.* "

#

$(EXE) : $(OBJS)
	$(DC) $(OBJS) $(CFLAGS) -of=$(EXE)

#
clean : 
	del $(OBJS) $(EXE)

# --------------------------------------------------
checkfile.obj: checkfile.d 
	$(DC) $(DFLAGS) -c checkfile.d
#
cleanline.obj: cleanline.d
	$(DC) $(DFLAGS) -c cleanline.d

main.obj: main.d
	$(DC) $(DFLAGS) -c main.d
#
readinput.obj: readinput.d
	$(DC) $(DFLAGS) -c readinput.d
#
setboundary.obj: setboundary.d
	$(DC) $(DFLAGS) -c setboundary.d
#
setcell.obj: setcell.d
	$(DC) $(DFLAGS) -c setcell.d
#
setlattice.obj: setlattice.d
	$(DC) $(DFLAGS) -c setlattice.d
#
setlib.obj: setlib.d
	$(DC) $(DFLAGS) -c setlib.d
#
setmacro.obj: setmacro.d
	$(DC) $(DFLAGS) -c setmacro.d
#
setmaterial.obj: setmaterial.d
	$(DC) $(DFLAGS) -c setmaterial.d
#
setpins.obj: setpins.d
	$(DC) $(DFLAGS) -c setpins.d
#
setquadrature.obj: setquadrature.d
	$(DC) $(DFLAGS) -c setquadrature.d
#
setrefine.obj: setrefine.d
	$(DC) $(DFLAGS) -c setrefine.d
#
setrun.obj: setrun.d
	$(DC) $(DFLAGS) -c setrun.d
#
setsurface.obj: setsurface.d
	$(DC) $(DFLAGS) -c setsurface.d
#
setsystem.obj: setsystem.d
	$(DC) $(DFLAGS) -c setsystem.d
#
verifyargs.obj: verifyargs.d
	$(DC) $(DFLAGS) -c verifyargs.d
#
verifydict.obj: verifydict.d
	$(DC) $(DFLAGS) -c verifydict.d
#