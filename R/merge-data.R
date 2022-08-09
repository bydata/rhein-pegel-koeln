# Merge files into a combine dataset
filepath <- file.path("data", "fetched-results")
files <- list.files(filepath, pattern = "pegel.\\d+.csv")
combined <- purrr::map_dfr(file.path(filepath, files), read.csv)

# # format the dataset
# result <- list()
# result$date <- lubridate::parse_date_time(
#   combined$Datum, "%d. %B %Y", tz = "Europe/Berlin")


write.csv(combined, file.path("data", "pegel-combined.csv"), row.names = FALSE)
