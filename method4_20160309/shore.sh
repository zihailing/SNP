#!/bin/sh
/psc/program/install/SHOREmap_v3.0/SHOREmap convert --marker FP1_without_fp2_0.1_0.9_common_in_Fdown.vcf  --folder MBS_common_FP1_Fdown -runid 1
/psc/program/install/SHOREmap_v3.0/SHOREmap backcross --chrsizes ~/zihailing/zhaowensheng_20151204/FP2/chrsize_cucumber.txt --folder FP1_Fdown_mapping_common --marker MBS_common_FP1_Fdown/1_converted_variant.txt --consen MBS_common_FP1_Fdown/1_converted_consen.txt -plot-bc -plot-win -plot-scale
/psc/program/install/SHOREmap_v3.0/SHOREmap convert --marker FP1_without_fp2_0.1_0.9_common_in_Fup.vcf  --folder MBS_common_FP1_Fup -runid 1
/psc/program/install/SHOREmap_v3.0/SHOREmap backcross --chrsizes ~/zihailing/zhaowensheng_20151204/FP2/chrsize_cucumber.txt --folder FP1_Fup_mapping_common --marker MBS_common_FP1_Fup/1_converted_variant.txt --consen MBS_common_FP1_Fup/1_converted_consen.txt -plot-bc -plot-win -plot-scale
/psc/program/install/SHOREmap_v3.0/SHOREmap convert --marker FP2_without_fp1_0.1_0.9_common_in_Fdown.vcf --folder MBS_common_FP2_Fdown -runid 1
/psc/program/install/SHOREmap_v3.0/SHOREmap backcross --chrsizes ~/zihailing/zhaowensheng_20151204/FP2/chrsize_cucumber.txt --folder FP2_Fdown_mapping_common --marker MBS_common_FP2_Fdown/1_converted_variant.txt --consen MBS_common_FP2_Fdown/1_converted_consen.txt -plot-bc -plot-win -plot-scale
/psc/program/install/SHOREmap_v3.0/SHOREmap convert --marker FP2_without_fp1_0.1_0.9_common_in_Fup.vcf --folder MBS_common_FP2_Fup -runid 1
/psc/program/install/SHOREmap_v3.0/SHOREmap backcross --chrsizes ~/zihailing/zhaowensheng_20151204/FP2/chrsize_cucumber.txt --folder FP2_Fup_mapping_common --marker MBS_common_FP2_Fup/1_converted_variant.txt --consen MBS_common_FP2_Fup/1_converted_consen.txt -plot-bc -plot-win -plot-scale
