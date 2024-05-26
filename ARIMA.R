library(forecast)
library(readr)
data1 <- read.csv("power.csv")
head(data1)
train_size <- 9 * 30 * 24 * 6  # 30 days * 24 hours * 6 observations per hour


zone1_ts <- ts(data1$`Zone.1.Power.Consumption`, frequency = 1)


zone1_power_train <- window(zone1_ts, end = c(1, train_size))
zone1_power_test <- window(zone1_power_ts, start = c(1, train_size + 1))
arima_model <- auto.arima(zone1_power_train)
forecast_values <- forecast(arima_model, h = length(zone1_power_test))

max_train <- max(zone1_power_train)
ylim_value <- max_train * 1.2
plot(forecast_values, ylim = c(0, ylim_value))
lines(zone1_power_test, col = 'red')
legend("topright", legend = c("Forecast", "Actual"), col = c("blue", "red"), lty = 1:1)

accuracy_result <- accuracy(forecast_values, zone1_power_test)

mae <- accuracy_result[1]

# Print MAE
print(paste("Mean Absolute Error (MAE):", mae))
