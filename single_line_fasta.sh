#!/bin/bash
awk '/^>/&&NR>1{print ""}{if(/^>/){printf "%s\n",$0}else{printf"%s",$0}}' ./tmp/pal2nal_tmp.fna > ./tmp/pal2nal_tmp.fna1

