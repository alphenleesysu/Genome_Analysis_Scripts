#!/bin/bash
if [ $# != 4 ]
then
  echo "1. Usage: $0 [bin length] [minimum tail_length] [chromosome_length file] [gff file]
		eg.
			./count_gene_density_by_window.sh 200000 0 al.chr.len al.gene.gff 
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


awk 'NR==FNR{seen[$1]=1; total[$1]=$2}NR!=FNR{count[$1,int(($3-1)/'$1')]++}END{for(i in seen){last=int((total[i]-1)/'$1');for (j=0;j<=last;j++){if(j<last){print i,j*'$1'+1,(j+1)*'$1',"'$1'",count[i,j]==""?"0":count[i,j]}else{if(total[i]-last*'$1'>='$2'){print i,j*'$1'+1,total[i],total[i]-last*'$1',count[i,j]==""?"0":count[i,j]  }}}}}'  $3 $4

 
