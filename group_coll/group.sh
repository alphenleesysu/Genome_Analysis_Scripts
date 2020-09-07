#/bin/bash
# Usage: $0 [coll input] [output file name]

cp $1 test.groups

while [ "`awk '{for(i=1;i<=NF;i++){if(seen[$i]==1){print NR,$i}else{seen[$i]=1}}}' test.groups`" != "" ]
do
	awk '{sign=0; for(i=1;i<=NF;i++){if(seen[$i]==1){sign=1; group[nr[$i]]=group[nr[$i]]" "$0  }}} sign==0{group[NR]=$0; for(i=1;i<=NF;i++){seen[$i]=1; nr[$i]=NR}}  END{for(i=1;i<=NR;i++){if(group[i]!=""){print group[i]}}}' test.groups |awk '{delete seen; for(i=1;i<=NF;i++){seen[$i]=1} for(i in seen){printf "%s ",i} print ""}'> test.groups.1
	rm test.groups
	mv test.groups.1 test.groups
done

mv test.groups $2
