#!/bin/bash
# Usage:  . $0 gene_list gff fasta >output  
#Example: ./  source/gene.list tmp.genome.gff.2 tmp.genome.fa >cds.fa  |the format of gff and fasta file is as tmp.genome.gff.2(only CDS lines;7 columns, 1st and 2nd column are gene and chromosome) and tmp.genome.fa(single line format and without ">")
# affliated script: rev_com.pl must be in the same folder/directory with this script
# tmp file:tmp.sort.gff tmp.cds

if [ ! -d ./tmp ]
  then
    mkdir ./tmp
  else
    rm -r ./tmp && mkdir ./tmp              
fi

for i in `cat $1`
do
  awk '$1=="'${i}'"{print}' $2 |sort -k4 -n >./tmp/tmp.sort.gff
  awk 'NR==FNR{seq[$1]=$2}NR!=FNR{cds[$1]=cds[$1]""substr(seq[$2],$4,$5-$4+1)}END{printf ">%s\t%s\n%s\n",$1,$6,cds[$1]}' $3 ./tmp/tmp.sort.gff|awk '/^>/&&NR>1{print ""}{if(/^>/){printf "%s ",$0}else{printf"%s",$0}}' >./tmp/tmp.cds
  perl rev_com.pl ./tmp/tmp.cds
done
