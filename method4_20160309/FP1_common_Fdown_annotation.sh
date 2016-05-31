#!/bin/sh
~/zihailing/tool/snpEff/snpEff eff Csativus FP1_without_fp2_0.1_0.9_common_in_Fdown.vcf >FP1_common_Fdown_annotation
perl ~/zihailing/tool/format_snp_eff_vcf_2_tab.pl FP1_common_Fdown_annotation ../Fdown/Fdown.sort.bam ../FP1/FP1.sort.bam  >FP1_common_Fdown_annotation_table
perl ~/zihailing/tool/eff_table_modify.pl FP1_common_Fdown_annotation_table >FP1_common_Fdown_modified_annotation_table
cat FP1_common_Fdown_modified_annotation_table|tr 'M' 'G' >FP1_common_Fdown_modified_annotation_table_V2
perl ~/myprogram/function_annotate.pl FP1_common_Fdown_modified_annotation_table_V2 ~/zihailing/Cucumber/cuc.ann >FP1_common_Fdown_modified_annotation_function_table
grep -P 'nonsense|missense|splice_region' FP1_common_Fdown_modified_annotation_function_table >FP1_common_Fdown_candidate_sites
