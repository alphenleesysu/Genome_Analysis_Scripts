#!/bin/bash
# ./run.sh <Pfam output> <prefix for output> <coils.res.txt from RGAugury>
# example: ./run.sh  ../../raw_data/pfam/Salba_pfam.out  alba  ../RGAugury/alba/public2.coils.res.txt

# identify NBS domain from Pfam output
	awk '$6=="PF00931.21"{print $1,$2,$3}' $1 |awk '{seen[$1]++;start[$1]=$2;end[$1]=$3}END{for(i in seen){print i"\t"seen[i]"\t"start[i]"\t"end[i]}}' > $2\.NBS.count

# identify CC motif according to output of COILS program by RGAugury
	awk 'NR==FNR && $2~/^domain/{seen[$1]=1;pos[$1]=$2}NR!=FNR {printf"%s\n",seen[$1]==1?$0"\t""CC""\t"pos[$1]:$0}' $3  $2\.NBS.count  > $2\.cc.type

# identify TIR domain from Pfam output
	awk 'NR==FNR && $6~/^PF01582/{seen[$1]=1;start[$1]=$2;end[$1]=$3}NR!=FNR {printf"%s\n",seen[$1]==1?$0"\t""TIR""\t"start[$1]"\t"end[$1]:$0}' $1  $2\.cc.type > $2\.cc.TIR.type 

# identify RPW8 domain from Pfam output
	awk 'NR==FNR && $6~/^PF05659/{seen[$1]=1;start[$1]=$2;end[$1]=$3}NR!=FNR {printf"%s\n",seen[$1]==1?$0"\t""RPW8""\t"start[$1]"\t"end[$1]:$0}' $1  $2\.cc.TIR.type > $2\.cc.TIR.RPW8.type
	
# awk: identify LRR domain from Pfam output
# perl -pe: grep the start and end position of CC domain
	awk 'NR==FNR {if($6~/^PF00560/ || $6~/^PF07723/ || $6~/^PF07725/ || $6~/^PF12799/ || $6~/^PF13306/ || $6~/^PF13516/ || $6~/^PF13504/ || $6~/^PF13855/ || $6~/^PF08263/){seen[$1]=1;start[$1]=$2;end[$1]=$3}}NR!=FNR {printf"%s\n",seen[$1]==1?$0"\t""LRR""\t"start[$1]"\t"end[$1]:$0}' $1  $2\.cc.TIR.RPW8.type |perl -pe 's/domain_CC\|(\d+)-(\d+)/$1\t$2/' > $2\.cc.TIR.RPW8.LRR.type

# format the output
	perl classify.pl  $2\.cc.TIR.RPW8.LRR.type |awk '{printf "%-25s\t",$1; for(i=2;i<=NF;i++){printf "%-5s\t",$i} print "";}' > $2\.final.type 

# summary
awk '{seen[$NF]++}END{for(i in seen){print i"\t"seen[i]}}' $2\.final.type > $2\.summary.txt
