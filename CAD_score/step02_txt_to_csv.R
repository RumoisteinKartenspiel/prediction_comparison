setwd("C:/Users/noahh/OneDrive - Uppsala universitet/Erasmus Oslo/01_Project/04_Data/CAD_score_voronota/")
file_names<- list.files()
names_col <- c("PDBchain1","PDBchain2","query_code","n_res","CAD_score","target_total_area","corresponding_model_total_area")

list_of_tables <- list()
k=1
for (name in file_names) {
  
  name <- read.table(name, stringsAsFactors = F, header = F, col.names = names_col)
  for (i in 1:nrow(name)) {
    n_last <- 7
    n_rem <- 4
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