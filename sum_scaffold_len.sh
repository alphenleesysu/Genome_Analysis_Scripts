#!/bin/bash
#Usage: $0 <input_genome.fasta> <type "all" to choose the all_scaffold mode OR type how many scaffolds you count(choose the select_scaffold mode>(first sort the scaffolds from long to short and decide how many scaffolds you wanna count)


# count scaffold length
#select the [all scaffolds] mode or [select scaffolds] mode according to the second argument/parameter
if [ $2 = "all" ]
then
	awk 'NR>1&&/^>/{print ""}{printf"%s",/^>/?$0" ":$0}' $1|awk '{print $1,length($2)}'|sort -k2 -n -r >tmp_scaffold_len.txt
else
	awk 'NR>1&&/^>/{print ""}{printf"%s",/^>/?$0" ":$0}' $1|awk '{print $1,length($2)}'|sort -k2 -n -r|head -$2 >tmp_scaffold_len.txt
fi

# count scaffold nums
awk 'END{print "num""\t"NR}' tmp_scaffold_len.txt

# count total length
awk '{SUM+=$2}END{print "sum""\t"SUM}' tmp_scaffold_len.txt

# count N50
awk '{seen[NR]=$2;SUM+=$2}END{for(i=1;i<=length(seen);i++){sum+=seen[i];if(sum>=SUM*0.5){print "N50""\t"seen[i];print "N50 count\t"i;break}}}' tmp_scaffold_len.txt

# count N90
awk '{seen[NR]=$2;SUM+=$2}END{for(i=1;i<=length(seen);i++){sum+=seen[i];if(sum>=SUM*0.9){print "N90""\t"seen[i];print "N90 count\t"i;break}}}' tmp_scaffold_len.txt 

# count max,min,mean,median
awk 'NR==1{print "max""\t"$2}{seen[NR]=$2;SUM+=$2}END{mean=SUM/NR;print "min""\t"$2;printf "mean\t%d\n",mean;     if(NR%2==0){median=(seen[NR/2]+seen[NR/2+1])/2}else{median=seen[NR/2+0.5]}printf "median\t%d\n",median}' tmp_scaffold_len.txt
