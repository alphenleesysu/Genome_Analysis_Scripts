#!/bin/bash
# Usage: $0 [parsed gff file] [parsed genome file] [output cds file name]
#        eg. ./run.sh sample/input.gff sample/input.genome output.cds
# Format Requirement:
#	gff: #gene #scaffold #"CDS" #start #end #"+"/"-"
#	genome: single line fasta WITHOUT ">"
# Affliated script: rev_com.pl
# tmp file: tmp.gff, tmp.cds
 
	# sort gff file by start position
	sort -k1,1 -k4,4n $1 > tmp.gff

	# extract CDS
	awk 'NR==FNR{if(num[$1]==""){count[$2]++}  seq[$2,count[$2]]=$1; num[$1]++; str[$1,num[$1]]=$4; end[$1,num[$1]]=$5;  sign[$1]=$6}NR!=FNR{for(i=1;i<=count[$1];i++){ cds=""; for(j=1;j<=num[seq[$1,i]];j++){tmp=substr($2,str[seq[$1,i],j],end[seq[$1,i],j]-str[seq[$1,i],j]+1); cds=cds""tmp}  print ">"seq[$1,i]"\t"sign[seq[$1,i]]"\t"cds    }}' tmp.gff $2 > tmp.cds

	# reverse-complete of cds on minus("-") chain
	perl rev_com.pl tmp.cds > $3
