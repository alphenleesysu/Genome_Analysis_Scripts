#!/bin/bash

	awk 'BEGIN{OFS="\t"} {cur_chr=$1; cur_str=$2; cur_end=$3} NR==1{print} NR>=2{if(cur_chr==pre_chr && cur_str<=pre_end){$2=pre_str; $3=(cur_end>pre_end)?cur_end:pre_end; $4=$4"|"pre_gene; print} else{print }}  {pre_chr=cur_chr; pre_str=cur_str; pre_end=cur_end; pre_gene=$4}' Rg.pg.txt > tmp.Rg.pg.txt.1 

	awk 'BEGIN{OFS="\t"} {cur_chr=$1; cur_str=$2; cur_end=$3}  NR>=2{if(cur_chr==pre_chr && cur_str<=pre_end){print NR} }  {pre_chr=cur_chr; pre_str=cur_str; pre_end=cur_end; pre_gene=$4}' Rg.pg.txt > tmp.del.NR.list 

	awk 'NR==FNR{seen[$1]=1}NR!=FNR{sign=0; for(i in seen){if(FNR==i-1){sign=1}}  if(sign==0){print}}' tmp.del.NR.list tmp.Rg.pg.txt.1 > tmp.Rg.pg.txt.2

	cp tmp.Rg.pg.txt.2 Rg.pg.txt 
