#!/bin/bash

#path to one of crystal home directories to find all possible names
cd /doctorai/noaheh/per_conda/Pymol/data/crystal/H
names_crystal=($(ls))
echo ${names_crystal[5]} #just a control test

#Real alignment happening here, path has to point to USalign home dir. 
cd /doctorai/noaheh/per_conda/USalign
rm -r output_scripts_try #If code is run twice or more times 
mkdir output_scripts_try

for chain in "H" "L" "paired" 
do 
for ((i=0;i<=${#names_crystal[@]};i++)); do

crystal=(/doctorai/noaheh/per_conda/Pymol/data/crystal/$chain/${names_crystal[i]})
ABB=(/doctorai/noaheh/per_conda/Pymol/data/ABB/$chain/${names_crystal[i]})
AF2=(/doctorai/noaheh/per_conda/Pymol/data/AF2/$chain/${names_crystal[i]})
IgFold=(/doctorai/noaheh/per_conda/Pymol/data/IgFold/$chain/${names_crystal[i]})


        TM_score1=$(./USalign -outfmt 2 "${crystal}" "${ABB}")
        echo -e "${TM_score1}" >> output_scripts_try/crystal_ABB_$chain.txt

        TM_score2=$(./USalign -outfmt 2 "${crystal}" "${AF2}")
        echo -e "${TM_score2}" >> output_scripts_try/crystal_AF2_$chain.txt

        TM_score3=$(./USalign -outfmt 2 "${crystal}" "${IgFold}")
        echo -e "${TM_score3}" >> output_scripts_try/crystal_IgFold_$chain.txt

        TM_score4=$(./USalign -outfmt 2 "${ABB}" "${AF2}")
        echo -e "${TM_score4}" >> output_scripts_try/ABB_AF2_$chain.txt

        TM_score5=$(./USalign -outfmt 2 "${ABB}" "${IgFold}")
        echo -e "${TM_score5}" >> output_scripts_try/ABB_IgFold_$chain.txt

        TM_score6=$(./USalign -outfmt 2 "${AF2}" "${IgFold}")
        echo -e "${TM_score6}" >> output_scripts_try/AF2_IgFold_$chain.txt

done
done