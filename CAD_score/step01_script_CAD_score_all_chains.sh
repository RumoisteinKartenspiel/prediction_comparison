#!/bin/bash



# standing in this direcotry in this conda env: (maxquant-1.6.10.43) noaheh@immunohub01:/doctorai/noaheh/per_conda/MaxCluster$ 

#/doctorai/noaheh/per_conda/CAD_score/voronota/voronota_1.23.3493


#Standard output (one line):
 #   {target file path} {model file path} {query code} {number of residues} {global score} {target total area} {corresponding model total area}

#path to one of crystal home directories to find all possible names
cd /doctorai/noaheh/per_conda/Pymol/data/crystal/H
names_crystal=($(ls))

#Real alignment happening here, path has to point to USalign home dir. 
cd /doctorai/noaheh/per_conda/CAD_score/voronota/voronota_1.23.3493
#rm -r results_data #If code is run twice or more times 
mkdir results_data
today=$(date +"%Y-%m-%d")

#paired chain doesnt seem to work
for chain in "H" "L" "paired"
do 
for ((i=0;i<=${#names_crystal[@]};i++)); do

crystal=(/doctorai/noaheh/per_conda/Pymol/data/crystal/$chain/${names_crystal[i]})
ABB=(/doctorai/noaheh/per_conda/Pymol/data/ABB/$chain/${names_crystal[i]})
AF2=(/doctorai/noaheh/per_conda/Pymol/data/AF2/$chain/${names_crystal[i]})
IgFold=(/doctorai/noaheh/per_conda/Pymol/data/IgFold/$chain/${names_crystal[i]})

        ./voronota-cadscore -t "${crystal}" -m "${ABB}" >> results_data/${today}_crystal_ABB_$chain.txt

        ./voronota-cadscore -t "${crystal}" -m "${IgFold}"  >> results_data/${today}_crystal_IgFold_$chain.txt
        
        ./voronota-cadscore -t "${crystal}" -m "${AF2}"  >> results_data/${today}_crystal_AF2_$chain.txt

        ./voronota-cadscore -t "${ABB}" -m "${AF2}" >> results_data/${today}_ABB_AF2_$chain.txt

        ./voronota-cadscore -t "${ABB}" -m "${IgFold}" >> results_data/${today}_ABB_IgFold_$chain.txt

        ./voronota-cadscore -t "${IgFold}" -m "${AF2}" >> results_data/${today}_IgFold_AF2_$chain.txt

done
done

test for single file
#./voronota-cadscore -t /doctorai/noaheh/per_conda/Pymol/data/crystal/H/12E8.pdb -m /doctorai/noaheh/per_conda/Pymol/data/IgFold/H/12E8.pdb
