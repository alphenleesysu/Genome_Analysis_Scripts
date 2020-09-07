#!/bin/bash

if [ ! -d ./output  ];then
  mkdir ./output
else
  rm -r ./output && mkdir ./output
fi

for file in `ls ./input`
do
	perl -i -pe 's?input\/(\S+)?input/'$file'?;  s?outfile = (\S+)?outfile = ./output/'${file}'.out?' codeml.ctl
	
	codeml codeml.ctl 1>>nohup.out	
done
