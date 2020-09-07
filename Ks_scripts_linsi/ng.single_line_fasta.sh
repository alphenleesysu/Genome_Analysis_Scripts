#!/bin/bash
awk '/^>/&&NR>1{print ""}{if(/^>/){printf "%s\n",$0}else{printf"%s",$0}}' ./tmp.ng/pal2nal_tmp.fna > ./tmp.ng/pal2nal_tmp.fna1

