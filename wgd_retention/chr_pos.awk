BEGIN{OFS="\t"} 
NF==3 && pre==7{ 
	len=length(seen);  
	print seen[0],chr1[1],pos1[1],pos1[len-1],chr2[1],pos2[1],pos2[len-1]; 
	for(i=1;i<=len-1;i++){
		print seen[i]
	}
	print; 
	pre=NF;
	next;
} 

NF==3 && pre==3{
	print;
	next;
	pre=NF;
	next;
} 

/^#/{ 
	delete seen; 
	i=0; 
	seen[i]=$0; 
	i++;
	next; 
}  

NF==7{
	seen[i]=$0; 
	chr1[i]=$2; 
	pos1[i]=$3; 
	chr2[i]=$5; 
	pos2[i]=$6; 
	i++; 
	pre=NF;
	next;
}
