library(ggplot2)
data <- read.table("supply_data.csv", header=F, sep=",") 

gp = ggplot(data = data) + scale_color_grey(name="Supply") + geom_line(aes(x = V1, y = V2, color = "chickens")) + geom_line(aes(x = V1, y = V3, color = "ducks")) + scale_y_continuous("amount") + scale_x_continuous("time")

print(gp)