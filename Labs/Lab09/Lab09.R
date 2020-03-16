# Import camera data
camData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = F)

# Date/time: formatted as a POSIXlt, timezone is "Africa/Nairobi", which is the timezone name for Tanzania as well
DateTime <- strptime(camData$DateTime,format='%d/%m/%Y %H:%M',tz="Africa/Nairobi")
# That does NOT account for date/time entered in a different format

camData$DateTime[505]

date1 <- strptime(camData$DateTime[1:5])