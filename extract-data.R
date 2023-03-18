#set working directory
setwd("~/Downloads/mahesh/NSCs/rawdata")

#list the files to extract data from
filenames <- list.files(c(basename("./")))
filenames
gene_list <- read.csv("../gene_list.csv")

# loop through each file
for (filename in filenames) {
  data <- read.csv(filename)

  # extract the information based on the pattern in the genelist columns
  extracted_info <- data[data[,1] %in% gene_list[,1],]
  
  #save to a new file appending _modified to each filename  
  write.csv(extracted_info, file=paste(filename,"_modified", sep = ""), row.names = FALSE)
  }

#after the script runs, copy all the new files to the output folder
file.copy(list.files("./",pattern = "_modified"), "../output")
file.remove(list.files("./",pattern = "_modified"))
