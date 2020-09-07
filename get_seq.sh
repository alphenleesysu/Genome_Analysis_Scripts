#!/bin/bash
# substr(seq_id, start_position, length)
	awk '{if(/^>/){id=$1}else{seq[id]=$1}}END{print substr(seq[">000242F_pilon"],970701,8)}' raw_data/Acorniculatum_genome.fa
