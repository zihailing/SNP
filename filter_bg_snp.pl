#!/usr/bin/perl
use warnings; use strict;
##version 2
#
die "$0 [fg_gile.vcf] [bg_file.bam] [bg_treshhold] \n" if @ARGV == 0;
my($fg_file,$bg_file,$tr) = @ARGV;


open FG,$fg_file or die $!;
while (<FG>){
	chomp;
	if ($_ =~ /^#/){
		print "$_\n";
	}else{
		my ($chr,$pos,$ref,$alt) = (split /\t/,$_)[0,1,3,4];
		next if ($alt =~ /,/);
		my $ref_l = length ($ref);
		my $alt_l = length ($alt);
		
		if($ref_l == 1 and $alt_l == 1){
			my $bg = `samtools mpileup -A  -r $chr:$pos-$pos $bg_file 2>/dev/null`;
			unless($bg){
				print STDERR "no hit in bg : samtools mpileup -A  -r $chr:$pos-$pos $bg_file\n";
				next;
			}
			my ($chr_b,$pos_b,$dep_b,$pile_b) = (split /\t/,$bg)[0,1,3,4];
			my $num = $pile_b =~ s/$alt/$alt/ig;
			unless ($dep_b){
				print STDERR "$chr\t$pos\tBG:$bg\n" unless ($dep_b);
				next;
			}
			if($tr =~ /\+/){
				print "$_\n" if ($num/$dep_b > $tr );
			}else{
				print "$_\n" if ( $num/$dep_b < $tr or $num/$dep_b == $tr );
			}
		}elsif($ref_l > 1){
			my $s = $pos - 30;
			my $e = $pos + 30;
			warn "pleae normalize your vcf file with vcf-annotate:$chr,$pos,$ref,$alt\n" if ($alt_l >1);	
			my @bg = `samtools mpileup -A  -r $chr:$s-$e $bg_file 2>/dev/null`;

			print "$_\n" unless (@bg ~~ /\-/);
		}elsif($alt_l > 1){
			my $s = $pos - 30;
			my $e = $pos + 30;
			warn "pleae normalize your vcf file with vcf-annotate:$chr,$pos,$ref,$alt\n" if ($ref_l > 1);
			my @bg = `samtools mpileup -A  -r $chr:$s-$e $bg_file 2>/dev/null`;
			
			print "$_\n" unless (@bg ~~ /\+/);
		}
	}
}

