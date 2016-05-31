#!/usr/bin/perl
use strict; use warnings;
use FileHandle;

my($file) = @ARGV;
die "Please input <$file>!" if(@ARGV!=1);

my $in = FileHandle->new("< $file");

while(<$in>){
	chomp;
	if($_=~/=/ && $_!~/NA=/){
		my @array = split(/\t/, $_);
		$array[6] =~ /(.+)=/;
		my $fre1 = $1;
		$array[7] =~ /(.+)=/;
		my $fre2 = $1;
		if($fre1 > 0.9 && $fre2 < 0.1){
			print "$_\n";
		}
	}
}
