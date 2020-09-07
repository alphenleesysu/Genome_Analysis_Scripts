#!/usr/bin/perl
use strict;
# Note: next time if I write such flow control, I would try to zip each block into a single line, then while reading each line(using awk),I can unzip each line into a normal file(this process is like parse fasta file into a single line so that it is easy to parse using awk)

#die "Usage: perl $0 [Ks_min] [Ks_max]" unless @ARGV==2;

# make work dir
if(-d "./result"){
  system("rm -rf ./result && mkdir ./result");
}else{system("mkdir ./result");}

# add Ks info
system("awk 'NR==FNR{ks[\$1,\$2]=\$3}NR!=FNR{print \$0\"\t\"ks[\$1,\$2]}' ./ks.input  ./coll.input > ./result/tmp.bg.coll.1");
# delete the blank line(it is so important to avoid error!)
system("awk '/./{print}' ./result/tmp.bg.coll.1 > ./result/tmp.bg.coll.2 ");


open (my $IN,"< ./result/tmp.bg.coll.2") ||die "cannot open file: $!";
# parse by each collinearity block
my $count=1;
while(<$IN>){
	if (/^#/ && $count>1){
		system("perl filter_Ks.find_singleton.pl ");
		system("rm ./result/tmp.coll");
	}

	open (my $tmp_out,">> ./result/tmp.coll") || die;
	print $tmp_out $_;	
	
	$count++;
}

# do not forget the last block(cause you do not have the last '#' to start parsing the last block)
system("perl filter_Ks.find_singleton.pl");
