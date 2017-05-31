#!/bin/sh
for i in *_in_range_20161221
do
	cat ${i}|awk 'BEGIN{OFS="\t"};{print $1,$2-101,$2-1}' >aa
	cat ${i}|awk 'BEGIN{OFS="\t"};{print $1,$2,$2+100}' >ee
	bedtools getfasta -fi ~/data_old_sever/zihailing/Cucumber/Cucumbercut.fa -bed aa >bb
	bedtools getfasta -fi ~/data_old_sever/zihailing/Cucumber/Cucumbercut.fa -bed ee >ff
	grep '>' bb >cc
	grep -v '>' bb >dd
	grep '>' ff >gg
	grep -v '>' ff >hh
	paste  cc dd gg hh ${i} >${i}_add_sequence.xls
	rm aa bb cc dd ee ff gg hh
done
