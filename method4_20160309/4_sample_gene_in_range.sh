#!/bin/sh
cat FP1_common_Fdown_annotation_4_sample_candidate_sites |awk '($2>17000000 && $2< 21000000&& $0~/^Chr1/){print $0}' >FP1_common_Fdown_annotation_4_sample_gene_in_range
cat FP2_common_Fup_annotation_4_sample_candidate_sites |awk '($2>17000000 && $2< 21000000&& $0~/^Chr1/){print $0}' >FP2_common_Fup_annotation_4_sample_gene_in_range
