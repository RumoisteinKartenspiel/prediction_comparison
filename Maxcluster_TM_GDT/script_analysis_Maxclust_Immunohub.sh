#!/bin/bash


#source /doctorai/noaheh/per_conda/phenix/phenix-installer-1.20.1-4487-intel-linux-2.6-x86_64-centos6/phenix-1.20.1-4487/phenix_env.sh

# standing in this direcotry in this conda env: (maxquant-1.6.10.43) noaheh@immunohub01:/doctorai/noaheh/per_conda/MaxCluster$ 

#$(pwd)/maxcluster64bit /doctorai/noaheh/per_conda/Pymol/data/crystal/H/12E8.pdb /doctorai/noaheh/per_conda/Pymol/data/AF2/H/12E8.pdb -gdt 4 -in -noalign 



#-gdt 4 provides gdt_TS (total score) score, -gdt 2 provides high accuracy score. 
#-in only strucural alignment after TM-align algorithm
#-noalign prevents output of superposition structres to output.rsm

#path to one of crystal home directories to find all possible names
cd /doctorai/noaheh/per_conda/Pymol/data/crystal/H
names_crystal=($(ls))

#Real alignment happening here, path has to point to USalign home dir. 
cd /doctorai/noaheh/per_conda/MaxCluster
#rm -r results_data #If code is run twice or more times 
mkdir results_data
today=$(date +"%Y-%m-%d")

#paired chain doesnt seem to work
for chain in "H" "L" 
do 
for ((i=0;i<=${#names_crystal[@]};i++)); do

crystal=(/doctorai/noaheh/per_conda/Pymol/data/crystal/$chain/${names_crystal[i]})
ABB=(/doctorai/noaheh/per_conda/Pymol/data/ABB/$chain/${names_crystal[i]})
AF2=(/doctorai/noaheh/per_conda/Pymol/data/AF2/$chain/${names_crystal[i]})
IgFold=(/doctorai/noaheh/per_conda/Pymol/data/IgFold/$chain/${names_crystal[i]})

        $(pwd)/maxcluster64bit "${crystal}" "${ABB}" -gdt 4 -in -noalign | \
        grep "Iter 1:" -A 6 | sed "s|Iter 1:|${names_crystal[i]}|g" |\
        sed 's/.pdb/ score,/g' | sed "/Percentage/d" | \
        sed "s/=/ /g" | sed "s/, /\n/g" | \
        sed "s/. L/\nL/g"| sed "s/. gRMSD/\ngRMSD/g"| \
        awk '!($3="")' >> results_data/${today}_crystal_ABB_$chain.txt

        $(pwd)/maxcluster64bit "${crystal}" "${IgFold}" -gdt 4 -in -noalign | \
        grep "Iter 1:" -A 6 | sed "s|Iter 1:|${names_crystal[i]}|g" |\
        sed 's/.pdb/ score,/g' | sed "/Percentage/d" | \
        sed "s/=/ /g" | sed "s/, /\n/g" | \
        sed "s/. L/\nL/g"| sed "s/. gRMSD/\ngRMSD/g"| \
        awk '!($3="")' >> results_data/${today}_crystal_IgFold_$chain.txt
        
        $(pwd)/maxcluster64bit "${crystal}" "${AF2}" -gdt 4 -in -noalign | \
        grep "Iter 1:" -A 6 | sed "s|Iter 1:|${names_crystal[i]}|g" |\
        sed 's/.pdb/ score,/g' | sed "/Percentage/d" | \
        sed "s/=/ /g" | sed "s/, /\n/g" | \
        sed "s/. L/\nL/g"| sed "s/. gRMSD/\ngRMSD/g"| \
        awk '!($3="")' >> results_data/${today}_crystal_AF2_$chain.txt

        $(pwd)/maxcluster64bit "${ABB}" "${AF2}" -gdt 4 -in -noalign | \
        grep "Iter 1:" -A 6 | sed "s|Iter 1:|${names_crystal[i]}|g" |\
        sed 's/.pdb/ score,/g' | sed "/Percentage/d" | \
        sed "s/=/ /g" | sed "s/, /\n/g" | \
        sed "s/. L/\nL/g"| sed "s/. gRMSD/\ngRMSD/g"| \
        awk '!($3="")' >> results_data/${today}_ABB_AF2_$chain.txt

        $(pwd)/maxcluster64bit "${ABB}" "${IgFold}" -gdt 4 -in -noalign | \
        grep "Iter 1:" -A 6 | sed "s|Iter 1:|${names_crystal[i]}|g" |\
        sed 's/.pdb/ score,/g' | sed "/Percentage/d" | \
        sed "s/=/ /g" | sed "s/, /\n/g" | \
        sed "s/. L/\nL/g"| sed "s/. gRMSD/\ngRMSD/g"| \
        awk '!($3="")' >> results_data/${today}_ABB_IgFold_$chain.txt

        $(pwd)/maxcluster64bit "${IgFold}" "${AF2}" -gdt 4 -in -noalign | \
        grep "Iter 1:" -A 6 | sed "s|Iter 1:|${names_crystal[i]}|g" |\
        sed 's/.pdb/ score,/g' | sed "/Percentage/d" | \
        sed "s/=/ /g" | sed "s/, /\n/g" | \
        sed "s/. L/\nL/g"| sed "s/. gRMSD/\ngRMSD/g"| \
        awk '!($3="")' >> results_data/${today}_IgFold_AF2_$chain.txt

done
done