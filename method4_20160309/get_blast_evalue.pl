#!/usr/bin/perl
use strict; use warnings; 
use FileHandle;

my($blast_out) = @ARGV;
die "Please input <blast_out.file>!" if(@ARGV != 1);

my $in = FileHandle->new("< $blast_out");

my %hash;

while(<$in>){
	chomp;
	my @array = split("\t", $_);
	my $key = $array[0]."\t".$array[1];
	if(!exists($hash{$key})){
		$hash{$key} = $array[10];
		print "$key\t$hash{$key}\n";
	}
}
