#!/bin/bash
# Usage: $0 [coll input]

# group.pl: the first grouping from raw coll input
# awk: remove replicates WITHIN each row 
perl group.pl $1 |awk '{delete seen; for(i=1;i<=NF;i++){seen[$i]=1} for(i in seen){printf "%s ",i} print ""}' > tmp.groups

# GROUP.pl: remove replicates BETWEEN rows
while [ "`awk '{for(i=1;i<=NF;i++){if(seen[$i]==1){print NR,$i}else{seen[$i]=1}}}' tmp.groups`" != "" ]
do
	perl GROUP.pl tmp.groups |awk '{delete seen; for(i=1;i<=NF;i++){seen[$i]=1} for(i in seen){printf "%s ",i} print ""}'> tmp.groups.1
	rm tmp.groups
	mv tmp.groups.1 tmp.groups
done

mv tmp.groups final.groups
