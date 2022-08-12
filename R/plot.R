library(ggplot2)

df <- readr::read_csv(file.path("data", "pegel-combined.csv"))

ggplot(df, aes(datetime, water_level)) +
  geom_step(color = "steelblue") +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.01, decimal.mark = ",")) + 
  coord_cartesian(ylim = c(0.5, NA)) +
  labs(
    title = "Pegelstand des Rheins bei Köln",
    caption = "Stadtentwässerungsbetriebe Köln, Stadt Köln",
    x = NULL,
    y = "Pegelstand (in m)"
  ) +
  theme_minimal() +
  theme(
    plot.background = element_rect(color = NA, fill = "grey98"),
    text = element_text(color = "grey20"),
    plot.title = element_text(face = "bold", color = "grey4"),
    plot.title.position = "plot",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )

ggsave(file.path("plots", "wasserpegel-live.png"), width = 5, height = 4,
       scale = 1.5)


ggplot(df, aes(datetime, water_level)) +
  geom_point(color = "grey50") +
  geom_smooth(method = "loess", se = TRUE, span = 0.3, color = "steelblue",
              fill = alpha("#B9DAFF", 0.7)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.01, decimal.mark = ",")) + 
  coord_cartesian(ylim = c(0.5, NA)) +
  labs(
    title = "Pegelstand des Rheins bei Köln",
    caption = "Stadtentwässerungsbetriebe Köln, Stadt Köln",
    x = NULL,
    y = "Pegelstand (in m)"
  ) +
  theme_minimal() +
  theme(
    plot.background = element_rect(color = NA, fill = "grey98"),
    text = element_text(color = "grey20"),
    plot.title = element_text(face = "bold", color = "grey4"),
    plot.title.position = "plot",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )
ggsave(file.path("plots", "wasserpegel-live-smoothed.png"), width = 5, height = 4,
       scale = 1.5)




#' Normalpegel: 3,48 m
#' https://de.wikipedia.org/wiki/Pegel_K%C3%B6ln#:~:text=Der%20Normalpegel%20liegt%20bei%203%2C48%20Metern.

ggplot(df, aes(datetime, water_level)) +
  geom_area(fill = "steelblue") +
  geom_hline(aes(yintercept = 3.48), col = "grey20") +
  annotate("label", label = "Normalpegel 3,48m",
           x = min(df$datetime), y = 3.48,
           hjust = 0, vjust = 0, label.size = 0, fill = alpha("grey8", 0.2)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.01, decimal.mark = ",")) + 
  coord_cartesian(ylim = c(0, 9)) +
  labs(
    title = "Pegelstand des Rheins bei Köln",
    caption = "Stadtentwässerungsbetriebe Köln, Stadt Köln",
    x = NULL,
    y = "Pegelstand (in m)"
  ) +
  theme_minimal() +
  theme(
    plot.background = element_rect(color = NA, fill = "grey98"),
    text = element_text(color = "grey20"),
    plot.title = element_text(face = "bold", color = "grey4"),
    plot.title.position = "plot",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )

ggsave(file.path("plots", "wasserpegel-live-reference.png"), width = 5, height = 4,
       scale = 1.5)

