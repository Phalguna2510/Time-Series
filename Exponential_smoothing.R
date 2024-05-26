install.packages("forecast")
library(forecast)
library(readr)
data <- read.csv("power.csv")
head(data)
train_size <- 9 * 30 * 24 * 6  # 30 days * 24 hours * 6 observations per hour


zone1_power_ts <- ts(data$`Zone.1.Power.Consumption`, frequency = 1)


zone1_power_train <- window(zone1_power_ts, end = c(1, train_size))
zone1_power_test <- window(zone1_power_ts, start = c(1, train_size + 1))

alpha <- 0.3

fit_es <- ets(zone1_power_train, alpha = alpha)

# Print model summary
print(fit_es)
 

# Forecast on the test set
forecast_power <- forecast(fit_es, h = length(zone1_power_test))


# Plot the forecast against actual test values
plot(forecast_power)#, main = "Forecasted vs Actual Power Consumption for Zone 1", xlim = c(start(zone1_power_ts), end(zone1_power_ts)), ylim = c(min(zone1_power_ts), max(zone1_power_ts) + 50), xlab = "Date", ylab = "Power Consumption")
lines(zone1_power_test, col = 'red')
legend("topright", legend = c("Forecast", "Actual"), col = c("blue", "red"), lty = 1:1)

accuracy_result <- accuracy(forecast_power, zone1_power_test)

mae <- accuracy_result[1]

# Print MAE
print(paste("Mean Absolute Error (MAE):", mae))
