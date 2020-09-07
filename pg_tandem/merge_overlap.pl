#!/usr/bin/perl
use strict;

my $overlap=`awk '{cur_chr=\$1; cur_str=\$2; cur_end=\$3}  NR>=2{if(cur_chr==pre_chr && cur_str<=pre_end){print NR} }  {pre_chr=cur_chr; pre_str=cur_str; pre_end=cur_end; pre_gene=\$4}' Rg.pg.txt `;

while( $overlap ne ""){
	system("./merge.sh");
	$overlap=`awk '{cur_chr=\$1; cur_str=\$2; cur_end=\$3}  NR>=2{if(cur_chr==pre_chr && cur_str<=pre_end){print NR} }  {pre_chr=cur_chr; pre_str=cur_str; pre_end=cur_end; pre_gene=\$4}' Rg.pg.txt `;
}
