#!/usr/bin/perl
use warnings; use strict;

while (<>){
	chomp;
	if ($_ =~ /^#/){
		print "$_\n";
	}else{
		my @arr = split /\t/,$_;
		if ($arr[3] eq "C" and $arr[4] eq "T"){
			print "$_\n";
		}elsif($arr[3] eq "G" and $arr[4] eq "A"){
			print "$_\n";
		}
	}
}

