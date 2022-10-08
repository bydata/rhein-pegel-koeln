library(purrr)
library(dplyr)

# Merge files into a combine dataset
filepath <- file.path("data", "fetched-results")
files <- list.files(filepath, pattern = "pegel.\\d+.csv")
filepath_combined <- file.path("data", "pegel-combined.csv")
new_data <- purrr::map_dfr(file.path(filepath, files), read.csv)
combined <- read.csv(filepath_combined)

# translate the German month name to English
de_months <- c(
  "Januar", "Februar", "März", "April", "Mai", "Juni" , "Juli", "August", 
  "September", "Oktober", "November",  "Dezember"
)
en_months <- month.name
names(en_months) <- de_months

result <- new_data %>% 
  mutate(month_de = stringr::str_extract(Datum, paste(de_months, collapse = "|")),
         month_en = en_months[month_de],
         date_str_en = stringr::str_replace(Datum, month_de, month_en),
         datetime_str_en = paste(date_str_en, Uhrzeit),
         date = strptime(date_str_en, "%d. %B %Y", tz = "Europe/Berlin") %>% as.character(),
         datetime = strptime(datetime_str_en, "%d. %B %Y %H:%M", tz = "Europe/Berlin") %>% as.character()) %>% 
  arrange(datetime) %>% 
  select(date, datetime, water_level = Pegel)

new_combined <- bind_rows(combined, result) %>% 
  distinct()

# throws an error if file size is not correct and therefore interrupts the Github action
testthat::expect_equal(nrow(new_combined), nrow(combined) + 1)
write.csv(new_combined, filepath_combined, row.names = FALSE)
