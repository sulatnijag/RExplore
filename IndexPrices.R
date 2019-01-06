#install.packages("quantmod")
#install.packages("Rbbg", repos = "http://r.findata.org")

#clear environment varialbles.
rm(list=ls())

#load libraries
library("quantmod")

EURUSD = getSymbols("USDJPY=X", src="yahoo", auto.assign = FALSE)

dt <- EURUSD["2018-08-10::"]

#average of high
center <- xts(rowSums(HLC(dt))/3, order.by = index(dt))

#first RESISTANCE (R1) = (2*P) - Low
R1 <- (2*center) - Lo(dt)

#first SUPPORT (S1) = (2*P) - High
S1 <- (2*center) - Hi(dt)

#second RESISTANCE (R2) = P + (R1-S1)
R2 <- center + (R1 - S1)

#second SUPPORT (S2) = P - (R1-S1)
S2 <- center - (R1 - S1)

ret <- cbind(center, R1, R2, S1, S2)

colnames(ret) <- c('center', 'R1', 'R2', 'S1', 'S2')

dat <- cbind(dt, ret)

chartSeries(dat, TA=NULL)

#adding SUPPORT line 1
addTA(dat$S1, on=1, col='green')

#adding SUPPORT line 2
#addTA(dat$S2, on=1, col='yellow')

#adding RESISTANCE line 2
addTA(dat$R1, on=1, col='pink')

#adding RESISTANCE line 2
#addTA(dat$R2, on=1, col='red')



EURUSD_closeprice = Cl(EURUSD) # We assign the closing price to a new variable called Apple_closeprice.

plot(EURUSD_closeprice) # Plotting the close price

hist(EURUSD_closeprice)

#XTS
nyears(`EURUSD=X`)
str(`EURUSD=X`)
