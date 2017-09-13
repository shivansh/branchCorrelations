data<-read.csv("output.csv")
#print(data)
data<-data[2:nrow(data),2:ncol(data)]
colnames(data)[colnames(data)=="TestCase"]<-"LineNumber"
print(data)
rownames(data)<-seq(length=nrow(data))
print(typeof(data[1,5]))
print("Started Loop")
#data[rownames(data)[3],colnames(data)[5]]<-0
#data[rownames(data)[3],colnames(data)[6]]<-3
df<-data.frame(LineNumber=data[,1],Hit0=integer(nrow(data)),Hit1=integer(nrow(data)),Hit2=integer(nrow(data)), Hit3=integer(nrow(data)))
for(i in 1:nrow(df)){
    for(j in 2:ncol(data)){
        #print(df[rownames(df)[i],colnames(df)[data[rownames(data)[i],colnames(data)[j]]+1]])
        df[rownames(df)[i],colnames(df)[data[rownames(data)[i],colnames(data)[j]]+2]]<- df[rownames(df)[i],colnames(df)[data[rownames(data)[i],colnames(data)[j]]+2]] + 1
    }
}
print("Completed loop")
print(df)
rownames(df)<-df[,1]
df<-df[,2:ncol(df)]

print("Transposed correlation matrix:")
print(t(df))
cor = cor(t(df))
print("Correlation matrix between branches:")
print(cor)
library(plyr)

#df<-t(df)

#combos <- combn(ncol(df),2)

#adply(combos, 2, function(x) {
#  test <- chisq.test(df[, x[1]], df[, x[2]])

#  out <- df.frame("Row" = colnames(df)[x[1]]
#                    , "Column" = colnames(df[x[2]])
#                    , "Chi.Square" = round(test$statistic,3)
#                    ,  "df"= test$parameter
#                    ,  "p.value" = round(test$p.value, 3)
#                    )
#  return(out)

#})  

#print(test)


k<-nrow(df)
result=matrix(1,nr=k,nc=k)
#print(result)
rownames(result)<-colnames(result)<-rownames(df)
for(i in 1:k){
	for(j in 1:k){
#        print("inner loop")
#        print(t(data[i,2:ncol(data)]))
		result[i,j]<-chisq.test(t(data[i,2:ncol(data)]),t(data[j,2:ncol(data)]))$p.value
	}
}
print("matrix of p-values for each pair of branches")
print(result)
#print(chisq.test(df)$p.value)
