#!/bin/sh
perl ~/zihailing/tool/format_snp_eff_vcf_2_tab.pl FP2_common_Fup_annotation ../FP2/FP2.sort.bam ../Fup/Fup.sort.bam ../FP1/FP1.sort.bam ../Fdown/Fdown.sort.bam >FP2_common_Fup_annotation_4_sample
perl eff_table_modify_20160317.pl FP2_common_Fup_annotation_4_sample >FP2_common_Fup_annotation_4_sample_modified
cat FP2_common_Fup_annotation_4_sample_modified |tr 'M' 'G' >FP2_common_Fup_annotation_4_sample_modified_V2
perl ~/myprogram/function_annotate.pl FP2_common_Fup_annotation_4_sample_modified_V2 ~/zihailing/Cucumber/cuc.ann >FP2_common_Fup_annotation_4_sample_modified_V2_function
grep -P 'nonsense|missense|splice_region|UTR_variant' FP2_common_Fup_annotation_4_sample_modified_V2_function >FP2_common_Fup_annotation_4_sample_candidate_sites
perl ~/zihailing/tool/format_snp_eff_vcf_2_tab.pl FP1_common_Fdown_annotation ../FP1/FP1.sort.bam ../Fdown/Fdown.sort.bam ../FP2/FP2.sort.bam ../Fup/Fup.sort.bam >FP1_common_Fdown_annotation_4_sample
perl eff_table_modify_20160317.pl FP1_common_Fdown_annotation_4_sample >FP1_common_Fdown_annotation_4_sample_modified
cat FP1_common_Fdown_annotation_4_sample_modified |tr 'M' 'G' >FP1_common_Fdown_annotation_4_sample_modified_V2
perl ~/myprogram/function_annotate.pl FP1_common_Fdown_annotation_4_sample_modified_V2 ~/zihailing/Cucumber/cuc.ann >FP1_common_Fdown_annotation_4_sample_modified_V2_function
grep -P 'nonsense|missense|splice_region|UTR_variant' FP1_common_Fdown_annotation_4_sample_modified_V2_function >FP1_common_Fdown_annotation_4_sample_candidate_sites
