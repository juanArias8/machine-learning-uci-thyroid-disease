library(VIM)
library(mice)
library(tidyr)

base <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/sick-euthyroid.data",header = F, na.strings = "?")
base1 <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/sick-euthyroid.names")

base$V1 <- NULL

base1$nombres <- row.names(base1)
base1 <- separate(base1, col="nombres", into=c("nombres", "f"), sep=":")
nombres <- base1$nombres
colnames(base) <- nombres

dim(base)
aggr(base, numbers=T, sortVar=T)

base$TBG <- NULL

variables <- c("sex", "T3", "TSH", "age", "TT4", "T4U", "FTI")

imputed_data <- mice(base[,names(base) %in% variables], seed=2018, print=F, m=30)
complete.data<- mice::complete(imputed_data)

for (i in 1:length(variables)) {
  base[,variables[i]] <- NULL  
}

base <- data.frame(base, complete.data)
dim(base)

aggr(base,numbers=T, sortVar=T)

write.csv(base, file="dataset.csv")

par(mfrow = c(3,3))
xyplot(imputed_data, T3 ~TSH)
xyplot(imputed_data, age ~TSH)
xyplot(imputed_data, TT4 ~T4U)
xyplot(imputed_data, T3 ~ FTI)
xyplot(imputed_data, FTI ~age)
xyplot(imputed_data, age ~T4U)

