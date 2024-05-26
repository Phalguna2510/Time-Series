names(data)
ts_data_zone1 <- ts(data$`Zone.1.Power.Consumption`, frequency = 144*30)
decomposed_ts_zone1 <- stl(ts_data_zone1, s.window = "periodic")
plot(decomposed_ts_zone1$time.series[, "seasonal"],
     xlab = "Time",
     ylab = "Seasonal Component")

