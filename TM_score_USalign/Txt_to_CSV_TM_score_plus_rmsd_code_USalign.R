setwd("C:/Users/noahh/OneDrive - Uppsala universitet/Erasmus Oslo/01_Project/04_Data/TM_score_USalign_RMSD")
file_names<- list.files()
names_col <- c("PDBchain1","PDBchain2","TM1","TM2","RMSD","ID1","ID2","IDali","L1",	"L2","Lali")

list_of_tables <- list()
k=1
for (name in file_names) {
  
  name <- read.table(name, stringsAsFactors = F, header = F, col.names = names_col)
  for (i in 1:nrow(name)) {
    n_last <- 9
    n_rem <- 6
    name[i,1]<- substr(name[i,1], nchar(name[i,1]) - n_last, (nchar(name[i,1]) - n_rem ))
    name[i,2]<- substr(name[i,2], nchar(name[i,2]) - n_last, (nchar(name[i,2]) - n_rem ))
  }
  list_of_tables[[k]] <- name
  k=1+k
}
names(list_of_tables) <- file_names


for (file in 1:length(file_names)) {
csv_name <- paste(file_names[file], ".csv", sep="")
write.csv(list_of_tables[file], csv_name, quote = F)
}
remove(i,k,n_last,n_rem,names_col,name,file_names,file,csv_name,list_of_tables)
#####################################################
#Info: You should use TM-score normalized by length of the reference structure, here normally TM1 !
#BUT, for comparison of NON-crystal structures both values can be used.
#list entry name: First name vs second name = TM1 , second name vs first = TM2; e.g. ABB_AF2_H = ABB = structure 1 = ref for TM1, AF2 = structure 2 = ref for TM2

