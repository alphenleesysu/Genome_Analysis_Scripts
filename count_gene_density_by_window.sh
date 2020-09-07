#!/bin/bash
if [ $# != 5 ]
then
  echo "1. Usage: $0 [bin length] [minimum tail_length] [chromosome_length file] [gff file] [prefix of chrmosome]
		eg.
			./count_gene_density_by_window.sh 200000 0 al.chr.len al.gene.gff  al 
	Warning: this script can only output the chromosomes with names like "chr1-chr12" "al1-al12",that is,the format of [prefix]+[number]
                 so you have to modify the definition of the chromosome name when needed, such as unplaced scaffold 
	and no matter how many scaffolds in the [gff file], it only count gene density of those scaffolds in [chromosome_length file]
        2. example of chr_len file:
             al1        25107552
             al2        22925000
        3. example of gff file(this can be obtained from the input gff file of MCScan) (chr gene start end):
             al10       evm.model.scaffold77.1  6287819 6312849
             al10       evm.model.scaffold77.2  6331567 6331935
        4. output file
             chr start end gene_number
       "
  exit 1
fi


awk 'NR==FNR{total[$1]=$2}NR!=FNR{count[$1,int(($3-1)/'$1')]++}END{for(i=1;i<=12;i++){last=int((total["'$5'"i]-1)/'$1');for (j=0;j<=last;j++){if(j<last){print "'$5'"i,j*'$1'+1,(j+1)*'$1',"'$1'",count["'$5'"i,j]}else{if(total["'$5'"i]-last*'$1'>='$2'){print "'$5'"i,j*'$1'+1,total["'$5'"i],total["'$5'"i]-last*'$1',count["'$5'"i,j]  }}}}}'  $3 $4

 
