#!/bin/bash
#source /doctorai/noaheh/per_conda/phenix/phenix-installer-1.20.1-4487-intel-linux-2.6-x86_64-centos6/phenix-1.20.1-4487/phenix_env.sh
#path to one of crystal home directories to find all possible names
cd /doctorai/noaheh/per_conda/Pymol/data/crystal/H
names_crystal=($(ls))
echo ${names_crystal[5]} #just a control test

#Real alignment happening here, path has to point to phenix home dir. 
cd /doctorai/noaheh/per_conda/phenix/
#rm -r results_data #If code is run twice or more times 
mkdir results_data
today=$(date +"%Y-%m-%d")
for chain in "H" "L" "paired" 
do 
for ((i=0;i<=${#names_crystal[@]};i++)); do

crystal=(/doctorai/noaheh/per_conda/Pymol/data/crystal/$chain/${names_crystal[i]})
ABB=(/doctorai/noaheh/per_conda/Pymol/data/ABB/$chain/${names_crystal[i]})
AF2=(/doctorai/noaheh/per_conda/Pymol/data/AF2/$chain/${names_crystal[i]})
IgFold=(/doctorai/noaheh/per_conda/Pymol/data/IgFold/$chain/${names_crystal[i]})

        phenix.molprobity "${crystal}" nproc=12 >/dev/null
        grep Summary -A 9 molprobity.out | sed "s|Summary|${names_crystal[i]}|" | sed 's/=//g' | sed 's/Ramachandran outliers/Ramachandran_outliers/g' |sed 's/Rotamer outliers/Rotamer_outliers/g' | sed 's/C-beta deviations/C-beta_deviations/g' | sed 's/MolProbity score/MolProbity_score/g'| sed 's/%//g'| sed 's/.pdb/ score/g' >> results_data/${today}_crystal_$chain.txt
        
        phenix.molprobity "${ABB}" nproc=12 >/dev/null
        grep Summary -A 9 molprobity.out | sed "s|Summary|${names_crystal[i]}|" | sed 's/=//g' | sed 's/Ramachandran outliers/Ramachandran_outliers/g' |sed 's/Rotamer outliers/Rotamer_outliers/g' | sed 's/C-beta deviations/C-beta_deviations/g' | sed 's/MolProbity score/MolProbity_score/g'| sed 's/%//g'| sed 's/.pdb/ score/g' >> results_data/${today}_ABB_$chain.txt
        
        phenix.molprobity "${AF2}" nproc=12 >/dev/null
        grep Summary -A 9 molprobity.out | sed "s|Summary|${names_crystal[i]}|" | sed 's/=//g' | sed 's/Ramachandran outliers/Ramachandran_outliers/g' |sed 's/Rotamer outliers/Rotamer_outliers/g' | sed 's/C-beta deviations/C-beta_deviations/g' | sed 's/MolProbity score/MolProbity_score/g'| sed 's/%//g'| sed 's/.pdb/ score/g' >> results_data/${today}_AF2_$chain.txt

        phenix.molprobity "${IgFold}" nproc=12 >/dev/null
        grep Summary -A 9 molprobity.out | sed "s|Summary|${names_crystal[i]}|" | sed 's/=//g' | sed 's/Ramachandran outliers/Ramachandran_outliers/g' |sed 's/Rotamer outliers/Rotamer_outliers/g' | sed 's/C-beta deviations/C-beta_deviations/g' | sed 's/MolProbity score/MolProbity_score/g'| sed 's/%//g'| sed 's/.pdb/ score/g' >> results_data/${today}_IgFold_$chain.txt





done
echo ${chain}
done

