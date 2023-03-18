#Author: Mahesh Mahadeo Mathe
#Date: March 18, 2023
#Goal: Extract counts data from a data frame in a specific order

#set working directory
setwd("./grein-rawdata")

#list the files to extract data from
filenames <- list.files(c(basename("./")))
filenames
gene_list <- read.csv("../gene_list.csv")
gene_list

# loop through each file
for (filename in filenames) {
  data <- read.csv(filename)
  # extract the information based on the pattern in the genelist columns
  extracted_info <- data[data[,1] %in% gene_list[,3],]
  
  #merge two dataframes and order them by a specific column
  extracted_info <- merge(extracted_info,gene_list, by.x = "gene_symbol", by.y = "hgnc_symbol")
  extracted_info <- extracted_info[order(extracted_info$Order),]
  
  #remove undesired column
  extracted_info <- extracted_info[,-2]
  
  #reorder the columns in a suitable order
  extracted_info <- extracted_info[,c((ncol(extracted_info)-1),ncol(extracted_info),1:(ncol(extracted_info)-2))]
  
  #change rownames of dataframe to default
  row.names(extracted_info) <-1:nrow(extracted_info)
  
  #save to a new file appending _modified to each filename  
  write.csv(extracted_info, file=paste(filename,"_modified", sep = ""), row.names = FALSE)
}

#after the script runs, copy all the new files to the empty output folder. 
#Note: Will not replace existing files in output folder. 
file.copy(list.files("./",pattern = "_modified"), "../output")
file.remove(list.files("./",pattern = "_modified"))
