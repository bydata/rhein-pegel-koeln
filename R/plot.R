library(ggplot2)

df <- readr::read_csv(file.path("data", "pegel-combined.csv"))

ylim_lower <- 0

ggplot(df, aes(datetime, water_level)) +
  geom_step(color = "steelblue") +
  scale_y_continuous(
    breaks = seq(0, 20, 1),
    labels = scales::number_format(accuracy = 1, decimal.mark = ",")) + 
  coord_cartesian(ylim = c(ylim_lower, NA)) +
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
  geom_point(color = "grey50", size = 0.05) +
  geom_smooth(method = "loess", se = TRUE, span = 0.1, color = "steelblue",
              fill = alpha("#B9DAFF", 0.7)) +
  scale_y_continuous(
    breaks = seq(0, 20, 1),
    labels = scales::number_format(accuracy = 1, decimal.mark = ",")) + 
  coord_cartesian(ylim = c(ylim_lower, NA)) +
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



#' Langfristiges Mittel: 2,97 m
#' https://www.elwis.de/DE/dynamisch/gewaesserkunde/wasserstaende/index.php?target=2&pegelId=a6ee8177-107b-47dd-bcfd-30960ccc6e9c

ggplot(df, aes(datetime, water_level)) +
  geom_area(fill = "steelblue") +
  geom_hline(aes(yintercept = 2.97), col = "grey20") +
  annotate("label", label = "Langfristiger Durchschnitt 2,97 m",
           x = min(df$datetime), y = 2.97,
           hjust = 0, vjust = 0, label.size = 0, fill = alpha("grey8", 0.2)) +
  scale_y_continuous(
    breaks = seq(0, 20, 1),
    labels = scales::number_format(accuracy = 1, decimal.mark = ",")) + 
  coord_cartesian(ylim = c(0, 9)) +
  labs(
    title = "Pegelstand des Rheins bei Köln",
    caption = "Stadtentwässerungsbetriebe Köln, Stadt Köln, ELWIS",
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

