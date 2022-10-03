setwd("C:/Users/noahh/OneDrive - Uppsala universitet/Erasmus Oslo/01_Project/04_Data/phenix_molprobity")

file_names <- list.files(,pattern=".txt")


for (k in 1:length(file_names)){
  
  chain <- read.table(file_names[k], head =F)
  
  df_k <- data.frame(matrix(ncol = 9, nrow = 0))
  
  name <- paste(file_names[k], ".csv", sep ="")

  colnames(df_k) <- c("PDBchain", "Rama_outliers %", "Rama_favored %", "Rotamer_outliers","C-beta_deviation", "Clashscore", "RMS(bonds)", "RMS(angels)", "MolProbity_score")


for (x in 1:(nrow(chain)/9)) {
  
  n_pdb = 1 + (9 * x) - 9
  n_rama_o = 2 + (9 * x) - 9
  n_rama_f = 3 + (9 * x) - 9
  n_rota_o = 4 + (9 * x) - 9
  n_cB_dev = 5 + (9 * x) - 9
  n_clash = 6 + (9 * x) - 9
  n_rms_b = 7 + (9 * x) - 9
  n_rms_a = 8 + (9 * x) - 9
  n_molP = 9 + (9 * x) - 9
  
  df_k[x,1] <- chain[n_pdb,1]
  df_k[x,2] <- chain[n_rama_o,2]
  df_k[x,3] <- chain[n_rama_f,2]
  df_k[x,4] <- chain[n_rota_o,2]
  df_k[x,5] <- chain[n_cB_dev,2]
  df_k[x,6] <- chain[n_clash,2]
  df_k[x,7] <- chain[n_rms_b,2]
  df_k[x,8] <- chain[n_rms_a,2]
  df_k[x,9] <- chain[n_molP,2]
}

  write.csv(df_k, name) 
  
}

