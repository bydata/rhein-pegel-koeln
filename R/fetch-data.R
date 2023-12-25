library(xml2)

# get the data from the endpoint
endpoint <- "https://www.stadt-koeln.de/interne-dienste/hochwasser/pegel_ws.php"
result <- read_xml(endpoint)

# transform XML into dataframe
result_list <- purrr::flatten(purrr::flatten(as_list(result)))
df <- as.data.frame(result_list)

# format dataset
df$Grafik <- NULL
df$Pegel <- gsub(",", ".", df$Pegel)

# store result
write.csv(
  df, 
  file.path("data", "fetched-results", paste0("pegel-", format(Sys.time(), "%Y%m%d%H%M%S"), ".csv")),
  row.names = FALSE)
