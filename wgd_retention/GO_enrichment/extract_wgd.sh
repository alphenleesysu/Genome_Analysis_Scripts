awk 'NF==7{print $1 >> "wgd_1.list"; print $4 >> "wgd_2.list"}NF==3{print $1 >> "singleton.list"}' final.coll 

awk 'NR==FNR{seen[$1]=1}NR!=FNR && seen[$1]==1{print }' wgd_1.list ../raw_data/all_genes_GO.list >wgd_1.go.list
awk 'NR==FNR{seen[$1]=1}NR!=FNR && seen[$1]==1{print }' wgd_2.list ../raw_data/all_genes_GO.list >wgd_2.go.list
awk 'NR==FNR{seen[$1]=1}NR!=FNR && seen[$1]==1{print }' singleton.list ../raw_data/all_genes_GO.list >singleton.go.list

grep -v '#' ../raw_data/ppipe_output_pgenes.txt |awk '{print $5}' >pgenes.list
awk 'NR==FNR{seen[$1]=1}NR!=FNR && seen[$1]==1{print}' pgenes.list singleton.go.list >pgenes.singletons.go.list


#cat singleton.go.list >> wgd_1.go.list 
#cat singleton.go.list >> wgd_2.go.list
