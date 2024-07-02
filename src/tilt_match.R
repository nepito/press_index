library(tidyverse)
library(jsonlite)
library(wstools)
library(pression)

league <- "135_2024"
teams_names_by_league <- list(
  "39" = c("Liverpool", "Chelsea", "Manchester City", "Tottenham Hotspur", "Arsenal", "Brighton", "Crystal Palace", "Aston Villa", "Brentford", "Everton", "Fulham", "Manchester United", "Newcastle United", "Nottingham Forest", "Southampton", "West Ham United", "Wolverhampton Wanderers", "Bournemouth", "Burnley", "Luton_Town", "Sheffield_United"),
  "78" = c("Augsburg", "Bayer Leverkusen", "Bayern München", "Bochum", "Borussia Dortmund", "Borussia Mgladbach", "Darmstadt 98", "Eintracht Frankfurt", "Freiburg", "Heidenheim", "Hoffenheim", "Köln", "Mainz 05", "RB Leipzig", "Stuttgart", "Union Berlin", "Werder Bremen", "Wolfsburg"),
  "94" = c("Arouca", "Benfica", "Boavista", "Casa Pia AC", "Chaves", "Estoril", "Famalicão", "Gil Vicente", "Marítimo", "Paços de Ferreira", "Portimonense", "Porto", "Rio Ave", "Santa Clara", "Sporting Braga", "Sporting CP", "Vitória Guimarães", "Vizela", "Santos Laguna", "Tigres UANL", "Toluca"),
  "262" = c("América", "Atlas", "Atlético de San Luis", "Club Tijuana", "Cruz Azul", "Guadalajara", "Juárez", "León", "Mazatlán", "Monterrey", "Necaxa", "Pachuca", "Puebla", "Pumas UNAM", "Querétaro", "Santos Laguna", "Tigres UANL", "Toluca"),
  "263" = c("Alebrijes de Oaxaca", "Cancún", "Dorados", "Raya2", "Universidad Guadalajara", "Atlante", "Celaya", "Durango", "Tapatío", "Venados", "Atlético Morelia", "Cimarrones de Sonora", "Mineros de Zacatecas", "Tepatitlán de Morelos", "CA La Paz", "Correcaminos UAT", "Pumas Tabasco", "Tlaxcala"),
  "135" = c("Cremonese", "Sampdoria", "Internazionale", "Hellas Verona", "Monza", "Fiorentina", "Milan", "Lecce", "Juventus", "Empoli", "Sassuolo", "Napoli", "Spezia", "Lazio", "Roma", "Atalanta", "Bologna", "Torino", "Salernitana", "Udinese"),
  "135_2024" = c("Cagliari", "Fiorentina", "Sassuolo", "Milan", "Lecce", "Genoa", "Juventus", "Internazionale", "Atalanta", "Hellas Verona", "Monza", "Salernitana", "Empoli", "Napoli", "Udinese", "Lazio", "Roma", "Torino", "Frosinone", "Bologna"),
  "140" = c("Almería", "Athletic Bilbao", "Atlético Madrid", "Barcelona", "Cádiz", "Celta de Vigo", "Deportivo Alavés", "Getafe", "Girona", "Granada", "Las Palmas", "Mallorca", "Osasuna", "Rayo Vallecano", "Real Betis", "Real Madrid", "Real Sociedad", "Sevilla", "Valencia", "Villarreal")
)
names <- obtain_files_names("/workdir/data/serie_a_2023-24")

all_team_stats <- list()
for (team in names) {
  team_name <- str_replace_all(team, " ", "_")
  path <- glue::glue("/workdir/data/{team_name}.csv")
  team_stats <- read_team_stats(path) |>
    #    filter_premier_league() |>
    add_tilt() |>
    filter(Team == team) |>
    mutate(delta_tilt_pose = tilt - `Possession, %`)
  all_team_stats[[team]] <- team_stats
}
all_team_tilt <- list()
all_team_delta <- list()
all_team_tempo <- list()
for (team in names(all_team_stats)) {
  all_team_tilt[[team]] <- quantile(all_team_stats[[team]]$tilt)
  all_team_delta[[team]] <- all_team_stats[[team]]$delta_tilt_pose |> mean()
  all_team_tempo[[team]] <- all_team_stats[[team]]$`Match tempo` |> mean()
}
ListJSON <- toJSON(all_team_tilt, pretty = TRUE, auto_unbox = TRUE)
path_tilt <- glue::glue("quantiles_tilt_{league}.json")
write(ListJSON, path_tilt)

ListJSON <- toJSON(all_team_delta, pretty = TRUE, auto_unbox = TRUE)
path_tilt <- glue::glue("quantiles_delta_{league}.json")
write(ListJSON, path_tilt)

ListJSON <- toJSON(all_team_tempo, pretty = TRUE, auto_unbox = TRUE)
path_tilt <- glue::glue("quantiles_tempo_{league}.json")
write(ListJSON, path_tilt)

# to_vec(for (team in names) if(sum(all_team_stats[[team]]$tilt[1:3] > 63.441) > 0) team)
