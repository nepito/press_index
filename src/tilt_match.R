library(tidyverse)
library(jsonlite)
library(wstools)

league <- "263"
teams_names_by_league <- list(
  "39" = c("Liverpool", "Chelsea", "Manchester City", "Tottenham Hotspur", "Arsenal", "Brighton", "Crystal Palace", "Aston Villa", "Brentford", "Everton", "Fulham", "Leeds United", "Leicester City", "Manchester United", "Newcastle United", "Nottingham Forest", "Southampton", "West Ham United", "Wolverhampton Wanderers", "Bournemouth"),
  "262" = c("América", "Atlas", "Atlético de San Luis", "Club Tijuana", "Cruz Azul", "Guadalajara", "Juárez", "León", "Mazatlán", "Monterrey", "Necaxa", "Pachuca", "Puebla", "Pumas UNAM", "Querétaro", "Santos Laguna", "Tigres UANL", "Toluca"),
  "263" = c("Alebrijes de Oaxaca", "Cancún", "Dorados", "Raya2", "Universidad Guadalajara", "Atlante", "Celaya","Durango","Tapatío","Venados","Atlético Morelia","Cimarrones de Sonora", "Mineros de Zacatecas","Tepatitlán de Morelos","CA La Paz","Correcaminos UAT","Pumas Tabasco","Tlaxcala")
)
names <- teams_names_by_league[[league]]

all_team_stats <- list()
for (team in names) {
  team_name <- str_replace_all(team, " ", "_")
  path <- glue::glue("/workdir/data/{team_name}.csv")
  team_stats <- read_team_stats(path) |>
    #    filter_premier_league() |>
    add_tilt() |>
    filter(Team == team)
  all_team_stats[[team]] <- team_stats
}
all_team_tilt <- list()
for (team in names(all_team_stats)) {
  all_team_tilt[[team]] <- quantile(all_team_stats[[team]]$tilt)
}
ListJSON <- toJSON(all_team_tilt, pretty = TRUE, auto_unbox = TRUE)
path_tilt <- glue::glue("quantiles_tilt_{league}.json")
write(ListJSON, path_tilt)


