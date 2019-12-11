#!/usr/bin/perl
use warnings; use strict;
my($vcf,@bams) = @ARGV;
die "$0 <vcfs> <bams>\n" if (@ARGV ==0);

open VCF,$vcf or die $!;


print "Chr\tPos\tRef\tAlt\tQual\tfg\tAF_fg\tAF_bg\tAnno\n";
while (<VCF>){
	chomp;
	next if (/^#/);
	my @arr = split /\t/,$_;
	my ($chr,$pos,$id,$ref,$alt,$qual,$filter,$anno,$format,@gts) = @arr;
	
	my $par ;
	if (length ($ref) == length ($alt)){
		$par = $alt;
	}else{
		my $ld = length ($ref) - length ($alt);
		if($ld < 0){
			my $st = substr($alt,$ld);
			$ld = abs($ld);
			$par = "INDEL";
			#$par = "$ref\\+${ld}$st";
		}elsif($ld > 0){
			my $st = "N" x $ld;
			$par = "INDEL";
			#$par = "$alt-${ld}$st";
		}

	}
	my $piles = `samtools mpileup -A @bams -r $chr:$pos-$pos 2>/dev/null | tail -n 1`;
	my @p = split /\t/,$piles;
	
	my @deps ;
	for (my $i = 3;$i < @p;$i+=3){
		if ($p[$i]){
			push @deps,$p[$i];
		}else{
			push @deps,0;
		}
	}
	
	my @pis	;
	for (my $i = 4;$i < @p;$i+=3){
		if ($p[$i]){
			push @pis,$p[$i];
		}else{
			push @pis,"#";
		}
	}
	
	my @nums;
	for (my $i =0;$i < @pis;$i++){
		my $ps = $pis[$i];
		$ps =~ s/[\+-][0-9]+[ATCGNatcgn]+/INDEL/g;
		$nums[$i] = ($ps =~ s/$par/$par/ig);
		$nums[$i] = 0 unless ($nums[$i]);
	}
	
	my @afs;
	for(my $i = 0;$i< @nums;$i++){
		if($deps[$i]){
			my $af= $nums[$i]/$deps[$i];
			$afs[$i] = sprintf "%.2f",$af;
		}else{
			$afs[$i] = "NA";
			$deps[$i] = 0;
		}
	}
		
	for (my $i = 0 ; $i < @gts; $i ++){
		$gts[$i] =~ s/(\d\/\d):.*/'$1/;
	}

	$anno =~ s/.*;ANN=(.*)/$1/;

	my @out = ($chr,$pos,$ref,$alt,$qual);
	for (my $i=0 ; $i < @bams; $i++){
		my $af = "$afs[$i]=$nums[$i]/$deps[$i]";
		if($gts[$i]){
			push @out,$gts[$i],$af;
		}else{
			push @out,$af,
		}
	}
	my $out_p = join "\t",@out;
	print "$out_p\t$anno\n";
}



