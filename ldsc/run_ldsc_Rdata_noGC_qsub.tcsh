#!/bin/tcsh

# This script loops over each annotation for each set of summary statistics (e.g. global surface area, global thickness), 
# makes a directory for the results, and makes new 'slave' scripts from the template. At the end, it checks if there are
# already results files for that set of sumstats, and if not, the edited slave script is sent to the queue.


## Genreating LDSC results for sumstats WITHOUT GC Correction
# This will run versions with and without ancestry regression.
# The differences are just which columns from the original Rdata files were put into the sumstats pipeline. 

# With ancestry regression
foreach E3MA (`cat /ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/LDSC/ancreg_noGC_munged_sumstats.txt`) 
	set baseE3MA = `basename $E3MA`
	## Make an output directory
	set outputdir = /ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/LDSC/w_1KGP3_ancreg/${baseE3MA}
	mkdir -p ${outputdir}
	echo "/ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/LDSC/run_ldsc_slave.tcsh $E3MA ${outputdir}" > scripts/ldsc_MAe3ukw3_${baseE3MA}.sh
	chmod a+x scripts/ldsc_MAe3ukw3_${baseE3MA}.sh
	if (! -f /ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/LDSC/w_1KGP3_ancreg/${baseE3MA}.results) then
	    qsub -o `pwd`/shelloutput/ldsc_MAe3ukw3_${baseE3MA}.out -j y `pwd`/scripts/ldsc_MAe3ukw3_${baseE3MA}.sh
	endif
end

# Without ancestry regression
foreach E3MA (`cat /ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/LDSC/nonancreg_noGC_munged_sumstats.txt`) 
	set baseE3MA = `basename $E3MA`
	## Make an output directory
	set outputdir = /ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/LDSC/wo_1KGP3_ancreg/${baseE3MA}
	mkdir -p ${outputdir}
	echo "/ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/LDSC/run_ldsc_slave.tcsh $E3MA ${outputdir}" > scripts/ldsc_MAe3ukw3_${baseE3MA}.sh
	chmod a+x scripts/ldsc_MAe3ukw3_${baseE3MA}.sh
	if (! -f /ifs/loni/faculty/dhibar/ENIGMA3/MA6/evolution/LDSC/wo_1KGP3_ancreg/${baseE3MA}.results) then
	    qsub -o `pwd`/shelloutput/ldsc_MAe3ukw3_${baseE3MA}.out -j y `pwd`/scripts/ldsc_MAe3ukw3_${baseE3MA}.sh
	endif
end


#the end!
