#!/usr/bin/perl
use strict; use warnings; 
use FileHandle;

my($file, $function_list) = @ARGV;
die "Please input eff_modified.file function_list.file!" if(@ARGV!=2);

my $in1 = FileHandle->new("< $file");
my $in2 = FileHandle->new("< $function_list");

my %hash;
my $header = <$in2>;
while(<$in2>){
	chomp;
	my @array = split;
	my $key = $array[0];
	shift @array;
	my $value = join(" ", @array);
	$hash{$key} = $value;
}

my $title = <$in1>;
chomp $title;
print "$title\tgene_function\n";
while(<$in1>){
	chomp;
	if($_=~/.*;.*;.*;(.{11})/){
		if(exists($hash{$1})){
			print"$_\t$hash{$1}\n";
		}else{
			print"$1\n";
		}
	}else{
		print"$_\n";
	}
}
