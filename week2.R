
#connecting and listing databases

ucscDB <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(ucscDB, "show databases;"); dbDisconnect(ucscDB);

#connecting to hg19 and listing tables

hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")

allTables <- dbListTables(hg19)

length(allTables)

allTables[1:6]

dbListFields(hg19, "affyU133Plus2")

dbGetQuery(hg19, "select count(*) from affyU133Plus2")

affyData <-dbReadTable(hg19, "affyU133Plus2") 

head(affyData)


#selecting a specific subset

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")

affyMis <- fetch(query); quantile(affyMis$misMatches)

affyMisSmall <- fetch(query, n= 10); dbClearResult(query);

dim(affyMisSmall)

dbDisconnect(hg19)


#HDF5 

source("http://bioconductor.org/biocLite.R")
BiocManager("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created


#create groups 

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")


A = matrix(1:10, nrow = 5, ncol = 2)
h5write(A, "example.h5", "foo/A")

B = array(seq(0.1, 2.0, by = 0.1), dim = c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")


#write a dataset

df = data.frame(1L:5L, seq(0,1,length.out  = 5), c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = F)
h5write(df, "example.h5", "df")
h5ls("example.h5")


#reading data

readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readf = h5read("example.h5", "df")

readA


#writing and reading chunks

h5write(c(12, 13, 14), "example.h5", "foo/A", index = list(1:3, 1))
h5read("example.h5", "foo/A")


#getting data off  webpages

con = url("https://www.theatlantic.com/technology/archive/2014/01/how-netflix-reverse-engineered-hollywood/282679/")
htmlCode = readLines(con)
close(con)
htmlCode

#
















