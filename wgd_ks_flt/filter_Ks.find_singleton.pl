#!/usr/bin/perl
use strict;

#die "Usage: perl $0 [Ks_min] [Ks_max]" unless @ARGV==2;

# find median Ks 
system("grep -v '#' ./result/tmp.coll |awk 'NF==3{print}' |sort -k 3,3 -rn > ./result/tmp.coll.1");

my $rows=` wc -l ./result/tmp.coll.1 |awk '{print \$1}' `;
my $median;
my $count=1;
my ($first,$second);

open (my $in,"< ./result/tmp.coll.1")||die;
while(<$in>){
	my @LINE=split();
	if ($rows%2==0){
		if ($count==$rows/2){
			$first=$LINE[2];
		}
		if ($count==$rows/2+1){
			$second=$LINE[2];
			$median=($first+$second)*0.5;
			last;
		}
		
	}
	else{
		if ($count==$rows/2+0.5){
			$median=$LINE[2];
			last;
		}
	}
	$count++;
}

# add median Ks
if ($median>=0.2 && $median<=0.7){
	system("awk 'NR==1{print \$0,$median}NR!=1{print}' ./result/tmp.coll >> ./result/ks.flt.coll");
# add gff info
#system("awk 'BEGIN{OFS=\"\t\"}NR==FNR{chr[\$4]=\$1;start[\$4]=\$2}NR!=FNR{if(/^#/){print}else{print \$1,chr[\$1],start[\$1],\$2,chr[\$2],start[\$2],\$3}}' ./gff.input ./result/tmp.median.coll >./result/tmp.median.gff.coll");

# find singletons
#system("awk 'NR==FNR{seen[\$1]=1;chr[\$1]=\$3;start[\$1]=\$4}NR!=FNR{print}FNR==2{chr1=\$2;start1=\$3;chr2=\$5;start2=\$6}END{end1=\$3;end2=\$6;   for(i in seen){if( (chr[i]==chr1 && start[i]>start1 && start[i]<end1) || (chr[i]==chr2 && start[i]>start2 && start[i]<end2)   ){print i\"\t\"chr[i]\"\t\"start[i]}}}' ./singleton.input  ./result/tmp.median.gff.coll >> ./result/tmp.median.gff.singleton.coll");

# add chromosome position at the end of the # line
#system("awk -f chr_pos.awk ./result/tmp.median.gff.singleton.coll > final.coll");

}




