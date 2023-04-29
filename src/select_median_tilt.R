library("tidyverse")
library("comprehenr")
library("jsonlite")
library("wstools")

league <- "135"
teams_names_by_league <- list(
  "39" = c("Liverpool", "Chelsea", "Manchester City", "Tottenham Hotspur", "Arsenal", "Brighton", "Crystal Palace", "Aston Villa", "Brentford", "Everton", "Fulham", "Leeds United", "Leicester City", "Manchester United", "Newcastle United", "Nottingham Forest", "Southampton", "West Ham United", "Wolverhampton Wanderers", "Bournemouth"),
  "262" = c("América", "Atlas", "Atlético de San Luis", "Club Tijuana", "Cruz Azul", "Guadalajara", "Juárez", "León", "Mazatlán", "Monterrey", "Necaxa", "Pachuca", "Puebla", "Pumas UNAM", "Querétaro", "Santos Laguna", "Tigres UANL", "Toluca"),
  "263" = c("Alebrijes de Oaxaca", "Cancún", "Dorados", "Raya2", "Universidad Guadalajara", "Atlante", "Celaya", "Durango", "Tapatío", "Venados", "Atlético Morelia", "Cimarrones de Sonora", "Mineros de Zacatecas", "Tepatitlán de Morelos", "CA La Paz", "Correcaminos UAT", "Pumas Tabasco", "Tlaxcala"),
  "135" = c("Cremonese", "Sampdoria", "Internazionale", "Hellas Verona", "Monza", "Fiorentina", "Milan", "Lecce", "Juventus", "Empoli", "Sassuolo", "Napoli", "Spezia", "Lazio", "Roma", "Atalanta", "Bologna", "Torino", "Salernitana", "Udinese")
)
names <- teams_names_by_league[[league]]
all_team_stats <- list()
all_rivals_team <- list()
for (team in names) {
  team_name <- str_replace_all(team, " ", "_")
  path <- glue::glue("/workdir/data/{team_name}.csv")
  team_stats <- read_team_stats(path) |>
    add_tilt() |>
    filter(Team == team)
  all_team_stats[[team]] <- team_stats
  team_stats <- read_team_stats(path) |>
    filter(Team != team)
  all_rivals_team[[team]] <- team_stats
}

path_tilt <- glue::glue("quantiles_tilt_{league}.json")
all_team_tilts <- fromJSON(path_tilt)
name_teams <- names(all_team_tilts)


all_team_stats[["Napoli"]] |>
  filter(Team == "Napoli") |>
  mutate(rivales = 100 - tilt) |>
  write_csv("napoli_serie_a.csv")

tilt <- to_vec(for (team in name_teams) all_team_tilts[[team]][3])
path_median_tilt <- glue::glue("median_tilt_{league}.csv")
tibble::tibble(team = name_teams, tilt = tilt) |>
  arrange(-tilt) |>
  write_csv(path_median_tilt)


# america <- read_team_stats("data/América.csv") |>
#   filter(Team == "América") |>
#   write_csv("america_liga_mx.csv")
