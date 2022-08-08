library(xml2)

# set locale to DE time format
Sys.setlocale("LC_TIME", locale = "de_DE")

# get the data from the endpoint
endpoint <- "https://www.stadt-koeln.de/interne-dienste/hochwasser/pegel_ws.php"
result <- read_xml(endpoint)

# transform XML into dataframe
result_list <- purrr::flatten(purrr::flatten(as_list(result)))
df <- as.data.frame(result_list)

# format data
df$Grafik <- NULL
df$Pegel <- as.numeric(gsub(",", ".", df$Pegel))
str(df)
df$Datum2 <- strptime(df$Datum, "%d. %B %Y", tz = "Europe/Berlin")

# store result
write.csv(
  df, 
  file.path("data", paste0("pegel-", format(Sys.time(), "%Y%m%d%H%M%S"), ".csv")),
  row.names = FALSE)
