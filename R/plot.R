library(ggplot2)

df <- readr::read_csv(file.path("data", "pegel-combined.csv"))

ggplot(df, aes(datetime, water_level)) +
  geom_step(color = "steelblue") +
  labs(
    title = "Wasserpegel des Rheins bei Köln",
    caption = "Stadtentwässerungsbetriebe Köln, Stadt Köln",
    x = NULL,
    y = "Wasserpegel (in m)"
  ) +
  theme_minimal() +
  theme(
    text = element_text(color = "grey20"),
    plot.title = element_text(face = "bold", color = "grey4"),
    plot.title.position = "plot"
  )

ggsave(file.path("plots", "wasserpegel-live.png"), width = 5, height = 4)
