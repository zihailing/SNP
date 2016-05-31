#!/usr/bin/perl
use strict; use warnings;
use FileHandle;

my($vcf1, $vcf2) = @ARGV;
die "Please input <vcf1> <vcf2_F2>!" if(@ARGV != 2);

my $in1 = FileHandle->new("< $vcf1");
my $in2 = FileHandle->new("< $vcf2");

my(%hash);
while(<$in1>){
	chomp;
	if($_ !~ /#/){
		my @array1 = split(/\t/, $_);
		my $len1 = length($array1[2]);
		my $len2 = length($array1[3]);
		if(($len1 == 1) & ($len2 == 1)){
			my $name = $array1[0].$array1[1].$array1[3].$array1[2];
			$hash{$name} = $array1[7];
		}
	}
}

while(<$in2>){
	chomp;
	if($_ !~ /#/){
		my @array2 = split(/\t/, $_);
		my $name2 = $array2[0].$array2[1].$array2[3].$array2[4];
		if(exists($hash{$name2})){
			print "$_\n";
#			print "$array2[0]\t$array2[1]\t$array2[3]\t$array2[4]\t$hash{$name2}\t$array2[7]\n";
		}
	}else{
		print "$_\n";
	}
}
