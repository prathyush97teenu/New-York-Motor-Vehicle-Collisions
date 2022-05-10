#Load the CSV file into data variable one after the other
data = read.csv(file.choose(),na.strings=c(""),encoding="UTF-8")
head(data)
head(crashes,n=15)
crashes <- subset (data, select = -c(ZIP.CODE, LOCATION, ON.STREET.NAME,CROSS.STREET.NAME,OFF.STREET.NAME, 
                                     NUMBER.OF.PEDESTRIANS.INJURED, NUMBER.OF.PEDESTRIANS.KILLED, 
                                     NUMBER.OF.CYCLIST.INJURED, NUMBER.OF.CYCLIST.KILLED, NUMBER.OF.MOTORIST.INJURED,
                                     NUMBER.OF.MOTORIST.KILLED, CONTRIBUTING.FACTOR.VEHICLE.2, CONTRIBUTING.FACTOR.VEHICLE.3,
                                     CONTRIBUTING.FACTOR.VEHICLE.4, CONTRIBUTING.FACTOR.VEHICLE.5, VEHICLE.TYPE.CODE.1, VEHICLE.TYPE.CODE.2,
                                     VEHICLE.TYPE.CODE.3, VEHICLE.TYPE.CODE.4, VEHICLE.TYPE.CODE.5))

colnames(crashes) <- c('Crash_Date','Crash_Time','Borough','Latitude','Longitude','Number_of_Persons_Injured','Number_of_Persons_Killed','Contributing_Factor','Collision_ID')


crashes$Crash_Date <- as.POSIXct(crashes$Crash_Date, format="%m/%d/%Y")
crashes$Crash_Date <- as.Date(crashes$Crash_Date,format = "%Y-%m-%d")
crashes <- crashes[rev(order(crashes$Crash_Date)),]

str(crashes)
crashes$Borough <- as.factor(crashes$Borough)
crashes$Contributing_Factor <- as.factor(crashes$Contributing_Factor)

crashes <- crashes[!is.na(crashes$Latitude),]
crashes <- crashes[!is.na(crashes$Longitude),]
crashes <- crashes[!is.na(crashes$Borough),]
crashes <- crashes[!is.na(crashes$Contributing_Factor),]
crashes <- crashes[!crashes$Contributing_Factor == "Unspecified",]
crashes <- crashes[!crashes$Contributing_Factor == "1",]
crashes <- crashes[!crashes$Contributing_Factor == "80",]

crashes$Contributing_Factor <- gsub("Driver Inattention/Distraction","Driver Inattention",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Pedestrian/Bicyclist/Other Pedestrian Error/Confusion","Pedestrian Confusion",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Cell Phone (hand-held)","Using Cell Phone",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Cell Phone (hand-Held)","Using Cell Phone",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Drugs (illegal)","Under Drug Influence",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Lane Marking Improper/Inadequate","Lane Marking Improper",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Obstruction/Debris","Obstruction By Debris",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Aggressive Driving/Road Rage","Road Rage",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Listening/Using Headphones","Using Headphones",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Shoulders Defective/Improper","Shoulders Defective",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Traffic Control Device Improper/Non-Working","Improper Traffic Control Device",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Cell Phone (hands-free)","Using Cell Phone",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Driverless/Runaway Vehicle","Runaway Vehicle",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Fatigued/Drowsy","Fatigue",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Tire Failure/Inadequate","Tire Failure",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("View Obstructed/Limited","View Obstructed",crashes$Contributing_Factor)

crashes$Contributing_Factor <- gsub("Illnes","Illness",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Cell Phone (hand-held)","Using Cell Phone",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Cell Phone (hand-Held)","Using Cell Phone",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Drugs (illegal)","Under Drug Influence",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Cell Phone (hands-free)","Using Cell Phone",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Drugs (Illegal)","Under Drug Influence",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("Reaction to Other Uninvolved Vehicle","Driver Inattention",crashes$Contributing_Factor)
crashes$Contributing_Factor <- gsub("View Obstructed/Limited","View Obstructed",crashes$Contributing_Factor)



crashes$Borough <- as.factor(crashes$Borough)
crashes$Contributing_Factor <- as.factor(crashes$Contributing_Factor)

levels(crashes$Contributing_Factor)
head(crashes,n=15)
nrow(crashes)

str(crashes)
summary(crashes)

memory.limit(size=56000) 
#Export the cleaned data
write.csv(crashes,"C:\\Users\\prath\\Desktop\\crashes.csv")

#crashes[!complete.cases(crashes),]
