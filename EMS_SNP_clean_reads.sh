#!/bin/sh
cat /psc/home/zihailing/zihailing/YHH_GKX_20160420/tmp_data/*/Len*/*.paired1 >/psc/home/zihailing/zihailing/YHH_GKX_20160420/clean_data/C42-1_R1.fastq
cat /psc/home/zihailing/zihailing/YHH_GKX_20160420/tmp_data/*/Len*/*.paired2 >/psc/home/zihailing/zihailing/YHH_GKX_20160420/clean_data/C42-1_R2.fastq
#################data_statistics###################################
cat tmp_data/*/*.sta >C42_sequencing_1
perl ~/zihailing/tool/format_reads_report.pl C42_sequencing_1 >C42_sequencing_2
perl ~/zihailing/tool/sta_to_xls.pl C42_sequencing_2 >C42_sequencing_3
##################map_and_call#################################
~/zihailing/tool/run_bwa_dir.pl -p C42 -i ~/zihailing/species_20151012/Ath/TAIR10_genome.fa -r clean_data/C42-1_R#  -d /psc/home/zihailing/zihailing/YHH_GKX_20160420 -o /psc/home/zihailing/zihailing/YHH_GKX_20160420
samtools mpileup -uD -f ~/zihailing/species_20151012/Ath/TAIR10_genome.fa C42.sort.bam |bcftools view -vcg - >C42.vcf
cat C42.vcf|/psc/program/install/vcftools_0.1.12/bin/vcf-annotate -n -H -f +/c=2,10/Q=60/d=3/D=200 > C42.filter.vcf
###################filter_bg_ems###################################
~/zihailing/tool/filter_bg_snp.pl C42.filter.vcf ~/zihailing/clf_59/clf59_all.sort.bam 0.1 >C42_filter_clf_59_ld_1.vcf
~/zihailing/tool/filter_bg_snp.pl C42_filter_clf_59_ld_1.vcf /psc/home/zihailing/zihailing/YHH_GaoZheng_clf_59_ld_3/clf_59_ld_3.sort.bam  0.1 >C42_filter_clf_59_ld_1_ld_3.vcf
perl ~/zihailing/tool/select_ems.pl C42_filter_clf_59_ld_1_ld_3.vcf >C42_filter_clf_59_ld_1_ld_3_ems.vcf
####################shore_map#################################
/psc/program/install/SHOREmap_v3.0/SHOREmap convert --marker C42_filter_clf_59_ld_1_ld_3_ems.vcf --folder MBS_C42 -runid 1
/psc/program/install/SHOREmap_v3.0/SHOREmap backcross --chrsizes ~/zihailing/species_20151012/Ath/chrsize.txt --folder C42_mapping --marker MBS_C42/1_converted_variant.txt --consen MBS_C42/1_converted_consen.txt -plot-bc -plot-win -plot-scale
####################annotation#################################
~/zihailing/tool/snpEff/snpEff eff athalianaTair10 C42_filter_clf_59_ld_1_ld_3_ems.vcf >C42_filter_clf_59_ld_1_ld_3_ems_snp_annotation
samtools index C42.sort.bam
perl ~/zihailing/tool/format_snp_eff_vcf_2_tab.pl C42_filter_clf_59_ld_1_ld_3_ems_snp_annotation C42.sort.bam ~/zihailing/clf_59/clf59_all.sort.bam >C42_filter_clf_59_ld_1_ld_3_ems_snp_annotation_table
perl ~/zihailing/tool/eff_table_modify.pl C42_filter_clf_59_ld_1_ld_3_ems_snp_annotation_table >C42_filter_clf_59_ld_1_ld_3_ems_snp_modified_annotation_table 
perl ~/myprogram/function_annotate.pl C42_filter_clf_59_ld_1_ld_3_ems_snp_modified_annotation_table ~/zihailing/tool/TAIR10_functional_descriptions_20130831.txt >C42_filter_clf_59_ld_1_ld_3_ems_snp_modified_annotation_function_table
cat C42_filter_clf_59_ld_1_ld_3_ems_snp_modified_annotation_function_table |awk '($2>13000000 && $2 < 15000000 && $0~/^Chr2/){print $0}'  >C42_annotated_gene_in_range
