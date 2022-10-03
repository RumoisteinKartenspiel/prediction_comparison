#!/bin/bash

############################################
#heavy chain begins
##############################################


#############
#crystal_ABB H-chain
#############

docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest crystal_ABB_H.py \
>> output_single_residue_cry_ABB_H_lddt.txt 

mkdir single_res_lddt

mkdir single_res_lddt/crystal_ABB_H
cd single_res_lddt/crystal_ABB_H

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_cry_ABB_H_lddt.txt

csplit -z -n 4 /home/noahho/output_single_residue_cry_ABB_H_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_H_crystal_ABB.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

  
cd /home/noahho/

#############
#crystal_AF2 H-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest crystal_AF2_H.py \
>> output_single_residue_cry_AF2_H_lddt.txt

mkdir single_res_lddt/crystal_AF2_H
cd single_res_lddt/crystal_AF2_H

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_cry_AF2_H_lddt.txt


csplit -z -n 4 /home/noahho/output_single_residue_cry_AF2_H_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_H_crystal_ABB.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

  

 cd /home/noahho/
#############
#crystal_IgFold H-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest crystal_IgFold_H.py \
>> output_single_residue_cry_IgFold_H_lddt.txt

mkdir single_res_lddt/crystal_IgFold_H
cd single_res_lddt/crystal_IgFold_H

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_cry_IgFold_H_lddt.txt

csplit -z -n 4 /home/noahho/output_single_residue_cry_IgFold_H_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_H_crystal_IgFold.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

  

 cd /home/noahho/
#############
#ABB_AF2 H-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest ABB_AF2_H.py \
>> output_single_residue_ABB_AF2_H_lddt.txt

mkdir single_res_lddt/ABB_AF2_H
cd single_res_lddt/ABB_AF2_H

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_ABB_AF2_H_lddt.txt 

csplit -z -n 4 /home/noahho/output_single_residue_ABB_AF2_H_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_H_ABB_AF2.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

  

 cd /home/noahho/
#############
#ABB_IgFold H-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest ABB_IgFold_H.py \
>> output_single_residue_ABB_IgFold_H_lddt.txt


mkdir single_res_lddt/ABB_IgFold_H
cd single_res_lddt/ABB_IgFold_H

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_ABB_IgFold_H_lddt.txt
csplit -z -n 4 /home/noahho/output_single_residue_ABB_IgFold_H_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_H_ABB_IgFold.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

  

 cd /home/noahho/
#############
#IgFold_AF2 H-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest IgFold_AF2_H.py \
>> output_single_residue_IgFold_AF2_H_lddt.txt

mkdir single_res_lddt/IgFold_AF2_H
cd single_res_lddt/IgFold_AF2_H

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_IgFold_AF2_H_lddt.txt

csplit -z -n 4 /home/noahho/output_single_residue_IgFold_AF2_H_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_H_IgFold_AF2.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

 

 cd /home/noahho/
 ########################################
 #light chain begins
 ########################################
 #############
#crystal_ABB L-chain
#############

docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest crystal_ABB_L.py \
>> output_single_residue_cry_ABB_L_lddt.txt 

mkdir single_res_lddt

mkdir single_res_lddt/crystal_ABB_L
cd single_res_lddt/crystal_ABB_L

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_cry_ABB_L_lddt.txt

csplit -z -n 4 /home/noahho/output_single_residue_cry_ABB_L_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_L_crystal_ABB.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done


 

 cd /home/noahho/
#############
#crystal_AF2 L-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest crystal_AF2_L.py \
>> output_single_residue_cry_AF2_L_lddt.txt

mkdir single_res_lddt/crystal_AF2_L
cd single_res_lddt/crystal_AF2_L

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_cry_AF2_L_lddt.txt

csplit -z -n 4 /home/noahho/output_single_residue_cry_AF2_L_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_L_crystal_ABB.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

 

 cd /home/noahho/
  
#############
#crystal_IgFold L-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest crystal_IgFold_L.py \
>> output_single_residue_cry_IgFold_L_lddt.txt

mkdir single_res_lddt/crystal_IgFold_L
cd single_res_lddt/crystal_IgFold_L

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_cry_IgFold_L_lddt.txt

csplit -z -n 4 /home/noahho/output_single_residue_cry_IgFold_L_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_L_crystal_IgFold.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

  

 cd /home/noahho/
#############
#ABB_AF2 L-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest ABB_AF2_L.py \
>> output_single_residue_ABB_AF2_L_lddt.txt

mkdir single_res_lddt/ABB_AF2_L
cd single_res_lddt/ABB_AF2_L

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_ABB_AF2_L_lddt.txt

csplit -z -n 4 /home/noahho/output_single_residue_ABB_AF2_L_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_L_ABB_AF2.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

  

 cd /home/noahho/
#############
#ABB_IgFold L-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest ABB_IgFold_L.py \
>> output_single_residue_ABB_IgFold_L_lddt.txt


mkdir single_res_lddt/ABB_IgFold_L
cd single_res_lddt/ABB_IgFold_L

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_ABB_IgFold_L_lddt.txt

csplit -z -n 4 /home/noahho/output_single_residue_ABB_IgFold_L_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_L_ABB_IgFold.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done

  

 cd /home/noahho/
#############
#IgFold_AF2 L-chain
#############
docker run --rm -iv $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest IgFold_AF2_L.py \
>> output_single_residue_IgFold_AF2_L_lddt.txt

mkdir single_res_lddt/IgFold_AF2_L
cd single_res_lddt/IgFold_AF2_L

sed -i "/^Inclusion/,+10d" /home/noahho/output_single_residue_IgFold_AF2_L_lddt.txt

csplit -z -n 4 /home/noahho/output_single_residue_IgFold_AF2_L_lddt.txt  /Chain/ "{*}" &&

while IFS=',' read -ra array; do 
  ar1+=("${array[0]}")
 done < /home/noahho/name_single_res_lldt_L_IgFold_AF2.csv #change this according to analyis conducted

#general syntax for this purpose is mv "$LoopVar" "${LoopVar/PreviousName.txt/NewName.txt}"
i=1
for file in xx*
 do
   name="${ar1[i]}.txt"
   mv "$file" "${file/xx*/${name}}" 
   ((i++))
 done

for k in ?????*
 do 
	mv -i "$k" "${k%????}"
 done
  

 cd /home/noahho/single_res_lddt

for k in $(dir)
do
  cd $k
  echo $k
for i in *.pdb
  do  
    mv -- "$i" "${i%.pdb}.txt"
  done

cd ..
done