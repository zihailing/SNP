#!/usr/bin/perl
use strict; use warnings;
use FileHandle;

my($file) = @ARGV;
die "Please input eff_output.file!" if(@ARGV!=1);

my $in = FileHandle->new("< $file");
my $title=<$in>;
print "$title";
while(<$in>){
	chomp;
	my @array = split;
	$array[10] =~ /EFF=([\w\+]*)\([^\|]*\|[^\|]*\|([^\|]*)\|([^\|]*)\|[^\|]*\|[^\|]*\|[^\|]*\|[^\|]*\|([^\|]*)\|/;
	pop @array;
	my $bef = join("\t", @array);
	print "$bef\t$1;$2;$3;$4\n";
}
