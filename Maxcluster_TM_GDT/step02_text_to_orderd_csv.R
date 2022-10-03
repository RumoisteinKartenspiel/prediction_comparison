
setwd("C:/Users/noahh/OneDrive - Uppsala universitet/Erasmus Oslo/01_Project/04_Data/Maxcluster_TM_GDT/")

#Formatting the tables an reading in the csv
file_names <- list.files(,pattern=".txt")


for (k in 1:length(file_names)){
  
H_chain <- read.table(file_names[k], head =F)

df_k <- data.frame(matrix(ncol = 9, nrow = 0))
colnames(df_k) <- c("PDBchain","Pairs","RMSD","MAXSUB","lenght","gRMSD", "TM","%ID","GDT_TS")

name <- paste(file_names[k], ".csv", sep ="")

#the naming of the variabels of for loop is stolen from other script, thats why thay dont make sense. -> outcome is still fine, only variable name is off

for (x in 1:(nrow(H_chain)/9)) {
  
  n_pdb = 1 + (9 * x) - 9
  n_rama_o = 2 + (9 * x) - 9
  n_rama_f = 3 + (9 * x) - 9
  n_rota_o = 4 + (9 * x) - 9
  n_cB_dev = 5 + (9 * x) - 9
  n_clash = 6 + (9 * x) - 9
  n_rms_b = 7 + (9 * x) - 9
  n_rms_a = 8 + (9 * x) - 9
  n_molP = 9 + (9 * x) - 9
  
  df_k[x,1] <- H_chain[n_pdb,1]
  df_k[x,2] <- H_chain[n_rama_o,2]
  df_k[x,3] <- H_chain[n_rama_f,2]
  df_k[x,4] <- H_chain[n_rota_o,2]
  df_k[x,5] <- H_chain[n_cB_dev,2]
  df_k[x,6] <- H_chain[n_clash,2]
  df_k[x,7] <- H_chain[n_rms_b,2]
  df_k[x,8] <- H_chain[n_rms_a,2]
  df_k[x,9] <- H_chain[n_molP,2]
}

write.csv(df_k, name) 

}

