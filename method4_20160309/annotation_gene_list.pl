#!/usr/bin/perl
use strict; use warnings; 
use FileHandle;

my($gene_list, $annotation, $basic_list) = @ARGV;
die "Please input <gene_blast_list><annotation><basic_list>!" if(@ARGV != 3);

my $in1 = FileHandle->new("< $gene_list");
my $in2 = FileHandle->new("< $annotation");
my $in3 = FileHandle->new("< $basic_list");

my %list;
while(<$in1>){
	chomp;
	my @array = split(/\t/, $_);
	$list{$array[0]} = $_;
}


my %hash;

while(<$in2>){
	chomp;
	$_ =~ /(\S+)\s/;
	$hash{$1} = $_;
}

while(<$in3>){
	chomp;
	$_ =~ />(.+)/;
	my $ge = $1;
	if(exists($list{$ge})){
		my @arr = split(/\t/, $list{$ge});
		if($arr[1] =~ /^(AT.+)\./){
			print "$list{$ge}\t$hash{$1}\n";
		}else{
			my $gene = ">".$arr[1];
			$hash{$gene} =~ /(.+)\|(.+)/;
			print "$list{$ge}\t$1\t$2\n";
		}
	}else{
		print "$ge\tNA\tNA\tNA\n";
	}
}
###############################################
