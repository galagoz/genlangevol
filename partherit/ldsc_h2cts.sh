#!/bin/bash

# Test run for h2-cts with custom annots
/home/gokala/ldsc/ldsc.py --h2-cts /data/clusterfs/lag/users/gokala/enigma-evol/ancreg/munged/replication_v1/surfaceDK_parstriangularis_globalCov_ancreg_munged.txt.sumstats.gz \
--ref-ld-chr /data/clusterfs/lag/users/gokala/enigma-evol/partherit/baselineLD/baselineLD. --out test_output_chimp_promoters \
--ref-ld-chr-cts /data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/chimp_PFC_promoters_hg19.ldcts \
--w-ld-chr /data/workspaces/lag/shared_spaces/Resource_DB/LDscores/Phase3/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC.

# This script makes genomic annotations suitable for the LDSC h2-cts flag.

# First, rename all annotations as shown below and put them into a single "evol_annots" folder.

for f in chimp_PFC_promoters_hg19.*; do mv $f ${f/${f:0:24}/evol_annots.1}; done
for f in chimp_PFC_enhancers_hg19.*; do mv $f ${f/${f:0:24}/evol_annots.2}; done
for f in HAR.*; do mv $f ${f/${f:0:3}/evol_annots.3}; done
for f in filtered.neanDepRegions.*; do mv $f ${f/${f:0:23}/evol_annots.4}; done
for f in nean_SNPs.*; do mv $f ${f/${f:0:9}/evol_annots.5}; done
for f in macaque_PFC_enhancers_hg19.*; do mv $f ${f/${f:0:26}/evol_annots.6}; done
for f in macaque_PFC_promoters_hg19.*; do mv $f ${f/${f:0:26}/evol_annots.7}; done
for f in Sweeps.*; do mv $f ${f/${f:0:6}/evol_annots.8}; done
for f in fetal_hge.sorted.merged.*; do mv $f ${f/${f:0:23}/evol_annots.9}; done
for f in E073_active_marks.*; do mv $f ${f/${f:0:17}/evol_annots.control1}; done
for f in E081_active_marks.*; do mv $f ${f/${f:0:17}/evol_annots.control2}; done

# As opposed to h2 flag, h2-cts requires your annotation files to have the exact same SNP set with your baseline model.
# So, make sure your annotation files have the same number and set of SNPs with the baseline.

# Reformat .annot files. h2-cts flag requires .annot files only with the "annot_name" column (5. column in current .annot files).
# However, I am not sure if h2-cts even reads .annot files at all, see: https://github.com/bulik/ldsc/issues/136#issuecomment-452324374

gunzip *.annot.gz
for i in *annot; do
	awk '{print $5}' $i > tmp && mv tmp $i;
done
gzip *.annot

# Make a .ldcts file with two columns: A list of annotations and paths to their directories
# Mine looks like the following:

#ChimpPFCPromoters	/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.1.
#ChimpPFCEnhancers	/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.2.
#HAR	/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.3.
#NeanderthalDepleted	/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.4.
#NeanderthalIntrogressed	/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.5.
#MacaquePFCEnhancers	/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.6.,/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.control1.
#MacaquePFCPromoters	/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.7.,/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.control1.
#AncientSelectiveSweeps	/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.8.
#FetalHGE	/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.9.,/data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots/evol_annots.control2.

# RUN PART. H2 with h2-cts FLAG and CUSTOM ANNOTATIONS!
/home/gokala/ldsc/ldsc.py \
--h2-cts /data/clusterfs/lag/users/gokala/genlang-evol/sumstats/munged/MTAG_WR_NREAD_SP_PA_trait_1_formatted_munged.txt.sumstats.gz \
--ref-ld-chr /data/clusterfs/lag/users/gokala/enigma-evol/partherit/baselineLD/baselineLD. \
--out /data/workspaces/lag/workspaces/lg-genlang/Working/Evolution/results/partitioned_heritability/mtag/nonancestry_regressed/genlang_nonancreg_newannots \
--ref-ld-chr-cts /data/workspaces/lag/workspaces/lg-ukbiobank/projects/enigma_evol/enigma_evo/evolution/resources/amanda_annotations/evol_annots.ldcts \
--w-ld-chr /data/workspaces/lag/shared_spaces/Resource_DB/LDscores/Phase3/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. 
