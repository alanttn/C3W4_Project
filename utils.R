## Utils.R is a collection of common used functions

## library
library(RCurl)
library(dplyr)
library(tidyr)
library(readr)

workingDir<-getwd()

## download zip file from the given URL and then unzip to desired destination
util_downloadNUnzip<-function(downloadURL,destFileName,targetZip,destDir,needUnzip){
        if(!file.exists(targetZip)){
                download.file(downloadURL,destfile = destFileName)
                if(needUnzip){
                        unzip(targetZip, exdir = destDir)
                }
        } else{
                print("Zip file has downloaded")
        }
        
}

## 
util_loadData<-function(targetFilePath,loadOptions,separator){
        ## Validate whether target file is exist
        targetFilePath<-paste(getwd(),targetFilePath,sep="")
        
        ## Validate parameters
        if(missing(separator)){
                separator=""
        }
        
        if(!file.exists(targetFilePath)){
                ## If not exists, inform user of the current path
                print(paste0("Current value is: ", targetFilePath))
                stop("The target file could not be found.")
        } else {
                ## If exists proceed in validating the load options
                ## if invalid option is given, stop and inform user
                if((loadOptions!="CSV")&&(loadOptions!="TABLE")){
                        stop("invalid load options, please enter CSV or TABLE")
                }
                
                ## if correct option is given, proceed on reading the data
                if(loadOptions=="CSV"){
                        return(read.csv(targetFilePath, stringsAsFactors = FALSE, strip.white = TRUE, na.strings = c("NA","")))
                } else{
                        myTable<-read.table(targetFilePath, sep=separator, stringsAsFactors = FALSE, strip.white = TRUE, na.strings = c("NA",""))
                        return(tbl_df(myTable))
                }
                
        }
}