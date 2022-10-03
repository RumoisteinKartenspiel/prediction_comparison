#install.packages("bio3d", dependencies=TRUE)
# Source: Grant, B.J. et al. (2006) Bioinformatics 22, 2695--2696

library(bio3d) 

setwd("C:/Users/noahh/OneDrive - Uppsala universitet/Erasmus Oslo/01_Project/03_Raw_data/")



##################
paired_input <- (list(data.frame(list.files("ABB/paired")),
                      data.frame(list.files("IgFold/paired")),
                      data.frame(list.files("AF2/paired"))))

L_input <- (list(data.frame(list.files("ABB/L")),
                      data.frame(list.files("IgFold/L")),
                      data.frame(list.files("AF2/L"))))

H_input <- (list(data.frame(list.files("ABB/H")),
                 data.frame(list.files("IgFold/H")),
                 data.frame(list.files("AF2/H"))))

joint_paired <- join_all(dfs = paired_input)
joint_paired <- joint_paired$list.files..ABB.paired..

joint_L <- join_all(dfs = L_input)
joint_L <- joint_L$list.files..ABB.L..

joint_H <- join_all(dfs = H_input)
joint_H <- joint_H$list.files..ABB.H..

##################

RMSD <- function(chain, joint){

i =1
rmsd_matrix <- data.frame(matrix(ncol = 6, nrow = 0))
for (name in joint) {
  crystal_file_name <- paste("crystal/",chain,"/", name, sep="")
  crystal_file<- read.pdb(crystal_file_name) 
  
  ABB_file_name <- paste("ABB/", chain,"/", name, sep = "")
  ABB_file <- read.pdb(ABB_file_name)
  
  IGFold_file_name <- paste("IGFold/", chain,"/", name, sep="")
  IGFold_file <- read.pdb(IGFold_file_name)
  
  AF2_file_name <- paste("AF2/", chain,"/", name, sep="")
  AF2_file <- read.pdb(AF2_file_name)
  
  rmsd_matrix[i,1] <- name
  rmsd_matrix[i,2] <- rmsd(crystal_file,ABB_file,fit=T)
  rmsd_matrix[i,3] <- rmsd(crystal_file,IGFold_file,fit=T)
  rmsd_matrix[i,4] <- rmsd(crystal_file,AF2_file,fit=T)
  rmsd_matrix[i,5] <- rmsd(ABB_file,IGFold_file,fit=T)
  rmsd_matrix[i,6] <- rmsd(ABB_file,AF2_file,fit=T)
  rmsd_matrix[i,7] <- rmsd(IGFold_file,AF2_file,fit=T)
  
  i=i+1
  
 }

colnames(rmsd_matrix) <- c("paired_chain_name","crystal_vs_ABB","crystal_vs_IGFold","crystal_vs_AF2","ABB_vs_IGFold","ABB_vs_AF2","IGFold_vs_AF2")

file_names <- paste("Bio3D_",chain,"_chain_rmsd.csv" )

write.csv(rmsd_matrix, file = file_names,quote = F)
}

#light
RMSD("L", joint_L)
#heavy
RMSD("H",joint_H)
#paired
RMSD("paired",joint_paired)
