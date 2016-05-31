#!/bin/sh
blastall -p blastp -i gene_list_20160327.fasta -d ~/zihailing/species_20151012/Ath/TAIR10_pep_20101214_updated.fa -o gene_list_20160327_blast_ath.txt -v 1 -b 1 -m 8 
blastall -p blastp -i gene_list_20160327.fasta -d ~/zihailing/species_20151012/rice/rice_protein.fasta -o gene_list_20160327_blast_rice.txt -v 1 -b 1 -m 8
blastall -p blastp -i gene_list_20160327.fasta -d ~/zihailing/species_20151012/muskmelon/muskmelon_protein.fasta -o gene_list_20160327_blast_muskmelon.txt -v 1 -b 1 -m 8
