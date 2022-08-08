# Merge files into a combine dataset
filepaths <- list.files("data", pattern = "pegel.*.csv")
combined <- purrr::map_dfr(file.path("data", filepaths), read.csv)
write.csv(combined, file.path("data", "pegel-combined.csv"))
