#!/usr/bin/perl
use strict; use warnings;
use FileHandle;

my($infile) = @ARGV;
die "Please input <file>!" if(@ARGV != 1);

my $in = FileHandle->new("< $infile");

while(<$in>){
	chomp;
	if($_ =~ /^Chr/){
		my @array = split(/\t/, $_);
		$array[7] =~ /DP4=(.+),(.+),(.+),(\d+);/;
		my $index1 = ($3+$4)/($1+$2+$3+$4);
		my $index2 = sprintf "%.2f",$index1;
		print "$array[0]\t$array[1]\t$index2\n";
	}
}
