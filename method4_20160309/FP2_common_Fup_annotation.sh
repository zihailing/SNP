#!/bin/sh
~/zihailing/tool/snpEff/snpEff eff  Csativus FP2_without_fp1_0.1_0.9_common_in_Fup.vcf >FP2_common_Fup_annotation
perl ~/zihailing/tool/format_snp_eff_vcf_2_tab.pl FP2_common_Fup_annotation ../Fup/Fup.sort.bam ../FP2/FP2.sort.bam  >FP2_common_Fup_annotation_table
perl ~/zihailing/tool/eff_table_modify.pl FP2_common_Fup_annotation_table >FP2_common_Fup_modified_annotation_table
cat FP2_common_Fup_modified_annotation_table|tr 'M' 'G' >FP2_common_Fup_modified_annotation_table_V2
perl ~/myprogram/function_annotate.pl FP2_common_Fup_modified_annotation_table_V2 ~/zihailing/Cucumber/cuc.ann >FP2_common_Fup_modified_annotation_function_table
grep -P 'nonsense|missense|splice_region' FP2_common_Fup_modified_annotation_function_table >FP2_common_Fup_candidate_sites
