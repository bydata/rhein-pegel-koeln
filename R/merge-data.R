library(purrr)
library(dplyr)

# Merge files into a combine dataset
filepath <- file.path("data", "fetched-results")
files <- list.files(filepath, pattern = "pegel.\\d+.csv")
combined <- purrr::map_dfr(file.path(filepath, files), read.csv)

# translate the German month name to English
de_months <- c(
  "Januar", "Februar", "März", "April", "Mai", "Juni" , "Juli", "August", 
  "September", "Oktober", "November",  "Dezember"
)
en_months <- month.name
names(en_months) <- de_months

result <- combined %>% 
  mutate(month_de = stringr::str_extract(Datum, paste(de_months, collapse = "|")),
         month_en = en_months[month_de],
         date_str_en = stringr::str_replace(Datum, month_de, month_en),
         datetime_str_en = paste(date_str_en, Uhrzeit),
         date = strptime(date_str_en, "%d. %B %Y", tz = "Europe/Berlin"),
         datetime = strptime(datetime_str_en, "%d. %B %Y %H:%M", tz = "Europe/Berlin")) %>% 
  arrange(datetime) %>% 
  select(date, datetime, water_level = Pegel)

write.csv(result, file.path("data", "pegel-combined.csv"), row.names = FALSE)
