#!/usr/bin/perl
use strict; use warnings; 
use FileHandle;

my($same_phe, $diff_phe) = @ARGV;
die "Please input <same_phe.file><diff_phe.file>!" if(@ARGV != 2);

my $in1 = FileHandle->new("< $same_phe");
my $in2 = FileHandle->new("< $diff_phe");

my(%same, %diff);

while(<$in1>){
	chomp;
	my @array1 = split(/\t/, $_);
	my $name1 = $array1[0]."\t".$array1[1];
	$same{$name1} = $array1[2];
}

while(<$in2>){
	chomp;
	my @array2 = split(/\t/, $_);
	my $name2 = $array2[0]."\t".$array2[1];
	$diff{$name2} = $array2[2];
}

foreach my $key (keys %same){
	my($index);
	if(exists($diff{$key})){
		$index = $same{$key} - $diff{$key};
	}else{
		$index = $same{$key};
	}
	$index = sprintf"%.2f",$index;
	print "$key\t$index\n"
}
