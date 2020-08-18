#!/bin/tcsh

set ftrait = $1
set foutput = $2

set trait = `basename $ftrait`

echo "*** Beginning LDSC ..."
echo "Trait: $trait"
echo "Output: $foutput"

/ifshome/smedland/bin/anaconda2/bin/python /ifshome/smedland/bin/ldsc/ldsc.py  --h2 ${ftrait} --out ${foutput} --ref-ld-chr /ifs/loni/faculty/dhibar/ENIGMA3/MAe3ukw3/evolution/resources/eur_w_ld_chr/ --w-ld-chr /ifs/loni/faculty/dhibar/ENIGMA3/MAe3ukw3/evolution/resources/eur_w_ld_chr/


echo "Finished!"