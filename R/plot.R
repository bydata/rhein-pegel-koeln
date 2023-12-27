library(ggplot2)
library(lubridate)

df <- readr::read_csv(file.path("data", "pegel-combined.csv"))

ylim_lower <- 0

ggplot(df, aes(datetime, water_level)) +
  geom_step(color = "steelblue") +
  scale_x_datetime(expand = c(0, 0)) +
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
  geom_point(color = "grey80", size = 0.01) +
  geom_smooth(method = "loess", se = TRUE, span = 0.01, color = "steelblue",
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


# Last year only
df |>
  subset(date >= today() - duration("1 year")) |>
  ggplot(aes(datetime, water_level)) +
  geom_point(color = "grey80", size = 0.01) +
  geom_smooth(method = "loess", se = TRUE, span = 0.05, color = "steelblue",
              fill = alpha("#B9DAFF", 0.7)) +
  scale_x_datetime(expand = c(0, 0)) +
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
ggsave(file.path("plots", "wasserpegel-live-smoothed-1y.png"), width = 5, height = 4,
       scale = 1.5)



#' Langfristiges Mittel: 2,97 m
#' https://www.elwis.de/DE/dynamisch/gewaesserkunde/wasserstaende/index.php?target=2&pegelId=a6ee8177-107b-47dd-bcfd-30960ccc6e9c

ggplot(df, aes(datetime, water_level)) +
  geom_area(fill = "steelblue") +
  geom_hline(aes(yintercept = 2.97), col = "grey20") +
  annotate("label", label = "Langfristiger Durchschnitt 2,97 m",
           x = min(df$datetime), y = 2.97,
           hjust = 0, vjust = 0, label.size = 0, fill = alpha("grey8", 0.2)) +
  scale_x_datetime(expand = c(0, 0)) +
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

# Last year only
df |>
  subset(date >= today() - duration("1 year")) |>
  ggplot(aes(datetime, water_level)) +
  geom_area(fill = "steelblue") +
  geom_hline(aes(yintercept = 2.97), col = "grey20") +
  annotate("label", label = "Langfristiger Durchschnitt 2,97 m",
           x = max(df$datetime), y = 2.97,
           hjust = 1, vjust = 0, label.size = 0, fill = alpha("grey8", 0.2)) +
  annotate(
    "text",
    x = max(df$datetime), 
    y = df$water_level[which.max(df$datetime)] + 0.5,
    label = paste0(df$water_level[which.max(df$datetime)], "m"), size = 6,
    fontface = "bold", hjust = 1, color = "grey20"
  ) +
  scale_x_datetime(expand = c(0, 0)) +
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
ggsave(file.path("plots", "wasserpegel-live-reference-1y.png"), width = 5, height = 4,
       scale = 1.5)

# Last day only
df |>
  subset(date >= today() - duration("1 day")) |>
  ggplot(aes(datetime, water_level)) +
  geom_area(fill = "steelblue") +
  geom_hline(aes(yintercept = 2.97), col = "grey20") +
  annotate("label", label = "Langfristiger Durchschnitt 2,97 m",
           x = max(df$datetime), y = 2.97,
           hjust = 1, vjust = 0, label.size = 0, fill = alpha("grey8", 0.2)) +
  annotate(
    "text",
    x = max(df$datetime), 
    y = df$water_level[which.max(df$datetime)] + 0.5,
    label = paste0(df$water_level[which.max(df$datetime)], "m"), size = 6,
    fontface = "bold", hjust = 1, color = "grey20"
  ) +
  scale_x_datetime(expand = c(0, 0)) +
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
ggsave(file.path("plots", "wasserpegel-live-reference-1d.png"), width = 5, height = 4,
       scale = 1.5)


# Last week only
df |>
  subset(date >= today() - duration("1 week")) |>
  ggplot(aes(datetime, water_level)) +
  geom_area(fill = "steelblue") +
  geom_hline(aes(yintercept = 2.97), col = "grey20") +
  annotate("label", label = "Langfristiger Durchschnitt 2,97 m",
           x = max(df$datetime), y = 2.97,
           hjust = 1, vjust = 0, label.size = 0, fill = alpha("grey8", 0.2)) +
  annotate(
    "text",
    x = max(df$datetime), 
    y = df$water_level[which.max(df$datetime)] + 0.5,
    label = paste0(df$water_level[which.max(df$datetime)], "m"), size = 6,
    fontface = "bold", hjust = 1, color = "grey20"
  ) +
  scale_x_datetime(expand = c(0, 0)) +
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
ggsave(file.path("plots", "wasserpegel-live-reference-1w.png"), width = 5, height = 4,
       scale = 1.5)


