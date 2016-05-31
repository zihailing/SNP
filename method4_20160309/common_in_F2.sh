#!/bin/sh
perl common_snp_vcf_20160305.pl FP1_without_fp2_0.1_0.9 /psc/home/zihailing/zihailing/zhaowensheng_20151204/Fdown/Fdown.filter.vcf >FP1_without_fp2_0.1_0.9_common_in_Fdown.vcf
perl common_snp_vcf_20160305.pl FP1_without_fp2_0.1_0.9 /psc/home/zihailing/zihailing/zhaowensheng_20151204/Fup/Fup.filter.vcf >FP1_without_fp2_0.1_0.9_common_in_Fup.vcf
perl common_snp_vcf_20160305.pl FP2_without_fp1_0.1_0.9 /psc/home/zihailing/zihailing/zhaowensheng_20151204/Fdown/Fdown.filter.vcf >FP2_without_fp1_0.1_0.9_common_in_Fdown.vcf
perl common_snp_vcf_20160305.pl FP2_without_fp1_0.1_0.9 /psc/home/zihailing/zihailing/zhaowensheng_20151204/Fup/Fup.filter.vcf >FP2_without_fp1_0.1_0.9_common_in_Fup.vcf
