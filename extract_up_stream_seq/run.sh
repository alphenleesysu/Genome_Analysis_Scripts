#!/bin/bash
# Usage: ./run.sh [genome fasta file(one-line format)] [gff: gene scaffold start end sign(+/-)] [up_seq length] > [output]
# if up_seq shorter than input length, add "|SHORT_(up_seq_length)" at the end of the seq ID
# affliated script: rev_com.pl
# tmp file: tmp.fa

	awk 'NR==FNR{if(/^>/){id=$1}else{seq[id]=$1}} NR!=FNR{ chr=seq[">"$2]; len=length(chr); if( $5=="+" ){      if($3>'$3'){up=substr(chr,$3-'$3','$3'); print ">"$1"\t"$5"\n"up} else{up=substr(chr,1,$3-1); print ">"$1"|SHORT_"$3-1"\t"$5"\n"up} }  else{ if( (len-$4)>='$3' ){up=substr(chr,$4+1,'$3'); print ">"$1"\t"$5"\n"up} else{up=substr(chr,$4+1,len-$4); print ">"$1"|SHORT_"len-$4"\t"$5"\n"up} } }' $1 $2 |awk 'NR>1 && /^>/{print ""}{printf "%s",/^>/?$0" ":$0}' > tmp.fa

	./rev_com.pl tmp.fa 

# check shorter up_seq 
#	awk '/^>/ && /SHORT/{print}' [output]

