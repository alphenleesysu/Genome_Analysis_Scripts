awk '/\|\|/{print NR}' result.txt >tmp.tandem.NR.list 
awk 'NR==FNR{seen[$1]=1} NR!=FNR{sign=0; for(i in seen){if(FNR==i-1 || FNR==i+1){sign=1}}  if(sign==1){print}  }' tmp.tandem.NR.list result.txt >tandem.list

awk '$3~/^pg-/{pg++}$3!~/^pg-/{normal++}END{print "total\t"NR"\nnormal\t"normal"\npgene\t"pg}' R.pg.gff 

awk '$3~/^pg-/{pg++; type[$5]++}$3!~/^pg-/{normal++}END{print "tandem_total\t"NR"\nnormal\t"normal"\npgene\t"pg; for(i in type){print i"\t"type[i]}}' tandem.list 

awk 'NF==2{pair++}NF==1{single++}END{total=pair*2+single; print "WGD_total\t"total"\npair\t"pair*2"\nsingle\t"single}' R.coll 
