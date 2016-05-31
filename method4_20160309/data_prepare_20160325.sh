#!/bin/sh
perl data_prepare_20160323.pl FP1_without_fp2_0.1_0.9_common_in_Fdown.vcf >FP1_Fdown_data.txt
perl data_prepare_20160323.pl FP1_without_fp2_0.1_0.9_common_in_Fup.vcf >FP1_Fup_data.txt
perl data_subtract.pl FP1_Fdown_data.txt FP1_Fup_data.txt >aa
