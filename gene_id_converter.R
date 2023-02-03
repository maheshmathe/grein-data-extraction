#Author: Mahesh Mahadeo Mathe
#Date: February 02, 2023
#Goal: one time process to obtain specific gene IDs from a list of another set of gene ids
#listAttributes: to list all the possible attributes that can be downloaded for any ID
#filters: the type of gene ID you're using to filter the attributes
#values: a vector of gene IDs you're using

#set working directory
setwd("~/Downloads/mahesh/nsc-rnaseq-grein")

#import essential libraries
library("biomaRt")
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl", host = "https://asia.ensembl.org")

# list all the csv files in a directory
files <- list.files(path = "~/Downloads/mahesh/nsc-rnaseq-grein", pattern = "*.csv", full.names = TRUE)

#extract gene symbols as a character vector 
gene_list <-  read.csv("./gene_list.csv")
gene_symbols <- c(gene_list[,1])

#obtain ensembl ids from gene symbols as a df
ensemblIDs <- getBM(attributes=c("ensembl_gene_id","hgnc_symbol"), 
                    filters = 'hgnc_symbol', 
                    values = gene_symbols, 
                    mart = ensembl)

#save to gene_list df [had to remove duplicate entries]
gene_list <- ensemblIDs[-c(51,53), ]
write.csv(gene_list, "./gene_list.csv", row.names=FALSE)