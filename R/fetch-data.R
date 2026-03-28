library(xml2)
library(purrr)

# Define the endpoint
endpoint <- "https://www.stadt-koeln.de/interne-dienste/hochwasser/pegel_ws.php"

# Get endpoint data
result <- tryCatch(
  read_xml(endpoint),
  error = function(e) {
    stop("Error getting endpoint data: ", e)
  }
)

# Transform XML into dataframe
result_list <- flatten(flatten(as_list(result)))
df <- as.data.frame(result_list, stringsAsFactors = FALSE)

# Formatting the dataset
df$Grafik <- NULL
df$Pegel <- as.numeric(gsub(",", ".", df$Pegel))

# Check the destination folder if it exists and create it if not 
output_dir <- file.path("data", "fetched-results")
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Store the result
output_file <- file.path(output_dir, paste0("pegel-", format(Sys.time(), "%Y%m%d%H%M%S"), ".csv"))
write.csv(df, output_file, row.names = FALSE)

message("Data stored in: ", output_file)
