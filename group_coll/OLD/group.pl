#!usr/bin/perl
use strict;

open my $IN,"<$ARGV[0]" ||die;

my @GROUP;
my $num=0;
$GROUP[0]=[""];

while(<$IN>){
	my @LINE=split();
	my $gene1=$LINE[0];
	my $gene2=$LINE[1];

	my $sign=0;
	for my $i(0 .. $#GROUP){
		for my $j(0 .. $#{$GROUP[$i]}){
			if ($GROUP[$i][$j] eq $gene1 || $GROUP[$i][$j] eq $gene2){
				$sign=1;
				push @{$GROUP[$i]},$gene1;
				push @{$GROUP[$i]},$gene2;
			}
		}
	}

	if ($sign==0){
		$num++;
		push @{$GROUP[$num]},$gene1;
		push @{$GROUP[$num]},$gene2;		
	}
}

for my $i(1 .. $#GROUP){
	for my $j(0 .. $#{$GROUP[$i]}){
		print $GROUP[$i][$j]," ";
	}
	print "\n";
}
