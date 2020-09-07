#!/bin/bash

# Usage:$0 [blast output] [query fasta file] [db fasta file]

# get query and db sequence length
	awk 'NR>1 && /^>/{print ""}{printf "%s",/^>/?$0" ":$0}' $2 |perl -pe 's/\*$//' |awk '{print $1,length($2)}' |perl -pe 's/^>//' > query.len
	awk 'NR>1 && /^>/{print ""}{printf "%s",/^>/?$0" ":$0}' $3 |perl -pe 's/\*$//' |awk '{print $1,length($2)}' |perl -pe 's/^>//' > db.len

# add query and db length to blast.out
	awk 'NR==FNR{seen[$1]=$2}NR!=FNR{print $0"\t"seen[$1]}' query.len $1 >tmp.blastout.1
	awk 'NR==FNR{seen[$1]=$2}NR!=FNR{print $0"\t"seen[$2]}' db.len    tmp.blastout.1 >tmp.blastout.2 

# filter: 
# identy $3>=30
# alignment_length/query_length>=0.3
# alignment_length/query_length>=0.3
	awk 'BEGIN{OFS="\t"}  $3>=30 && $4/$13>=.3 && $4/$14>=.3{$13=null; $14=null; print}' tmp.blastout.2 > blast.out.flt

#* E value filter *
#	awk '{print $0"\t"$(NF-1)}' raw_data/new_OLD.blastout |perl -pe 's/(\S+)e\-(\d+)$/$2/' |awk 'BEGIN{OFS="\t"}$NF=="0.0" || $NF>=30{$NF=null; print}' > new_OLD.blast.e30.flt
