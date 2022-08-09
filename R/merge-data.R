# Merge files into a combine dataset
filepath <- file.path("data", "fetched-results")
files <- list.files(filepath, pattern = "pegel.\\d+.csv")
combined <- purrr::map_dfr(file.path(filepath, files), read.csv)

result <- list()
result$date <- lubridate::parse_date_time(
  combined$Datum, "%d. %B %Y", tz = "Europe/Berlin")
result$time <- combined$Uhrzeit
result$water_level <- combined$Pegel
result <- as.data.frame(result)

write.csv(result, file.path("data", "pegel-combined.csv"), row.names = FALSE)
