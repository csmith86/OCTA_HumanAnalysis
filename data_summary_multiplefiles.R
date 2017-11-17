
rm(list=ls())

path <- file.path("~","OneDrive - Dalhousie University","R","test.csv")
temp <- list.files(pattern="*.csv")
myfiles <- lapply(temp, read.csv, stringsAsFactors = FALSE)
#raw_data <- read.csv(path, header = TRUE, sep = ",", stringsAsFactors = FALSE)   # read CSV file from MATLAB

##CREATE ONE raw_data TABLE called "raw_data"
raw_data <- do.call(rbind, lapply(temp, function(x) read.csv(x, stringsAsFactors = FALSE)))


dates <- as.Date(raw_data$Date, "%m-%d-%y")
#days <- dates - dates[1]
difftime(dates, dates[1], units = c("days"))

raw_data$Layer <- as.factor(raw_data$Layer)  #layer_vector <- raw_data$Layer
raw_data$Region <- as.factor(raw_data$Region)
#glayers_vector <- factor(layer_vector) #--  this is necessary if in read.csv "stringsAsFactors" is set to FALSE

#perfusion_ratio <- raw_data$Perfusion.Ratio
#branch_points <- raw_data$Branch.Points

##STATISTICS OUTPOUT
aggregate(raw_data[,6:length(raw_data)], list(Layer = raw_data$Layer),mean)
aggregate(raw_data[,6:length(raw_data)], list(Days  = days, Layer = raw_data$Layer),mean)

subset(raw_data,Layer=SVC)

ggplot(raw_data, aes(x=as.numeric(days), y = branch_points)) + geom_point() + facet_grid(.~ Layer)

lp1 <- ggplot(raw_data, aes(x=Vessel.Length, y = Branch.Points, color = Perfusion.Ratio)) + geom_point() + facet_grid(.~ Layer)
lp1 + theme(legend.title=element_blank())

ggplot(raw_data,aes(x=as.numeric(days), y = Branch.Points, color = Perfusion.Ratio)) + geom_point() + facet_grid(.~ Layer)
ggplot(raw_data,aes(x=as.numeric(days), y = Branch.Points, color = Perfusion.Ratio)) + geom_jitter() + facet_grid(.~ Layer)

#plot + theme(legend.position = c(0.9, 0.2)) #change legend position
#plot + theme(legend.position = "bottom", legend.background = element_rect(color = "black", 
#fill = "grey90", size = 1, linetype = "solid"), legend.direction = "horizontal")