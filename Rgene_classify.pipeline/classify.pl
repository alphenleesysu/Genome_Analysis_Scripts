#!/usr/bin/perl
use strict;

die "Usage: perl $0 <type file>" unless @ARGV==1;

open my $in,"<$ARGV[0]"||die;
while(<$in>){
	chomp;
	my @LINE=split();

	if (/RPW8/){
		if (/TIR/){
			print $_,"\terror";
		}
		elsif(/LRR/){
			print $_,"\tRNL";
	
		}
		else{
			print $_,"\tRN";
		}
	}
	elsif(/TIR/){
		if (/LRR/){
			print $_,"\tTNL";
		}
		else{
			print $_,"\tTN";
		}

	}
	elsif(/CC/){
		if ( ($LINE[2]<=$LINE[5] && $LINE[5]<=$LINE[3]) || ($LINE[2]<=$LINE[6] && $LINE[6]<=$LINE[3]) || ($LINE[3]<=$LINE[5] && $LINE[6]>=$LINE[3])){
			print $_,"\tNBS";
		}
		elsif(/LRR/){
			print $_,"\tCNL";
		}
		else{
			print $_,"\tCN";
		}
	}
	else{
		if(/LRR/){
			print $_,"\tNL";
		}
		else{
			print $_,"\tNBS";
		}
	}
	
	print "\n";
}
