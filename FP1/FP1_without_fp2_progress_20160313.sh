#!/bin/sh
grep -v '#' FP1_without_fp2.vcf|grep -v 'INDEL'|grep -v 'Saff' >FP1_without_fp2_without_INDEL_Scaff.vcf
perl ~/zihailing/tool/format_snp_eff_vcf_2_tab.pl FP1_without_fp2_without_INDEL_Scaff.vcf FP1.sort.bam ../FP2/FP2.sort.bam >FP1_without_fp2_without_INDEL_Scaff_format.txt
