library(lpSolveAPI)

#Read the lp file
lprec <- read.lp("NuclearWaste_Disposal.lp")

#Solve the LP
solve(lprec)

#Get Min Value of OF
get.objective(lprec)

CityPath <- c("Pittsburgh - Columbus", "Pittsburgh - Cleveland", "Pittsburgh - Akron", "Pittsburgh - Charleston", "Columbus - Akron", "Columbus - Cincinnati", "Columbus - Indianapolis", "Cleveland - Akron", "Cleveland - Toledo", "Akron - Toledo", "Charleston - Lexington", "Charleston - Knoxville", "Toledo - Chicago", "Toledo - Indianapolis", "Cincinnati - Lexington", "Cincinnati - Indianapolis", "Cincinnati - Louisville", "Lexington - Knoxville", "Lexington - Louisville", "Knoxville - Nashville", "Chicago - Indianapolis", "Chicago - Springfield", "Chicago - Davenport/Moline/Rock Island", "Indianapolis - Louisville", "Indianapolis - Springfield", "Indianapolis - St. Louis", "Louisville - Nashville", "Louisville - Evansville", "Nashville - Memphis", "Evansville  - St. Louis", "Springfield - Davenport/Moline/Rock Island", "Springfield - St. Louis", "Davenport/Moline/Rock Island - Des Monies", "St. Louis - Memphis", "St. Louis - Kansas City", "St. Louis - Tulsa", "Memphis - Little Rock", "Des Monies - Kansas City", "Des Moines - Omaha", "Kansas City - Little Rock", "Kansas City Omaha", "Kansas City - Topeka", "Tulsa - Little Rock", "Tulsa - Wichita", "Tulsa - Oklahoma City", "Little Rock - Oklahoma City", "Omaha - Cheyenne", "Omaha - Denver", "Wichita - Oklahoma City", "Oklahoma City - Amarillo", "Amarillo - Albuquerque", "Cheyenne - Denver", "Cheyenne - Salt Lake City", "Denver - Albuquerque", "Denver - Salt Lake City", "Denver - Las Vegas", "Albuquerque - Las Vegas", "Salt Lake City - Nevada Site", "Las Vegas - Neveda Site")

Cities <- c("Time", "Pittsburgh", "Columbus", "Cleveland", "Akron", "Charleston", "Toledo", "Cincinnati", "Lexington", "Knoxville", "Chicago", "Indianapolis", "Louisville", "Nashvilla", "Evansville", "Springfield", "Davenport/Moline/Rock Island", "St. Louis", "Memphis", "Des Moines", "Kansas City", "Tulsa", "Little Rock", "Omaha", "Topeka", "Wichita", "Oklahoma City", "Amarillo", "Cheyenne", "Denver", "Albuquerque", "Salt Lake City", "Las Vegas", "Nevada Site")

#Get Variable value
Variable_Value <- as.data.frame(get.variables(lprec))

Followed_Path <- as.data.frame(cbind(City = CityPath,Path = Variable_Value[1:59,]))

View(Followed_Path)

#The Minimum path : Solution
Minimum_Path <- Followed_Path[Followed_Path$Path == 1,]

View(Minimum_Path)

Total_Time <- get.constraints(lprec)[1]
Total_Time

#Get Constraint Value
get.constraints(lprec)

#m + n = shadow + reduce, no. of constraints + decision Variables ; 34 + 59

#To compute Shadow price : 
get.sensitivity.rhs(lprec)$duals[1:34]

#To compute Reduced Cost
get.sensitivity.rhs(lprec)$duals[35:93]

#Range of shadow price
cbind(Cities, Shadow_Price=get.sensitivity.rhs(lprec)$duals[1:34], Lower_bound=get.sensitivity.rhs(lprec)$dualsfrom[1:34], Upper_bound=get.sensitivity.rhs(lprec)$dualstill[1:34])

##Range of Reduced Cost
cbind(CityPath, Reduce_Cost=get.sensitivity.rhs(lprec)$duals[35:93], Lower_bound=get.sensitivity.rhs(lprec)$dualsfrom[35:93], Upper_bound=get.sensitivity.rhs(lprec)$dualstill[35:93])

