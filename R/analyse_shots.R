usethis::use_package("ggplot2")
usethis::use_package("dplyr")
usethis::use_package("patchwork")

#' Bar chart and tibble of shot type in the 2001-2002 and 2021-2022 seasons filtered by NBA team
#'
#' Creates two bar charts and a tibble that show either the total number of points from 2 and 3-point attempts
#' or the total number of shots, filtered by team and split by season from NBA data
#' @return `ggplot2` a summary tibble and side by side bar charts
#' @examples
#' analyse_shots(data = clean_data, team_filter = "BOS", metric = "points")$plot
#' analyse_shots(data = clean_data, team_filter = "ATL", metric = "shots")$summary
#'
#' @export
analyse_shots <- function(data, team_filter = NULL, metric = c("shots", "points")) { #function input
  metric <- match.arg(metric)

  #Turn match_id into season 2001-2002 or 2021-2022
  data <- data %>%
    mutate(
      year = as.numeric(substr(match_id, 1, 4)),
      season = case_when(
        year %in% c(2001, 2002) ~ "2001-2002", #rename seasons
        year %in% c(2021, 2022) ~ "2021-2022",
        TRUE ~ NA_character_
      )
    ) |>
    filter(!is.na(season))  #get rid of any irrelevant seasons

  #Filter by team if applicable
  if (!is.null(team_filter)) {
    data <- data %>% filter(team == team_filter)
  }

  #Data summary
  summary_data <- data %>%
    group_by(season, shot_type) %>% #grouping by 2 or 3 pointers
    summarise(total_shots = n(), .groups = "drop")

  #convert shots to total points (since 3 pointers are worth more then 2 pointers)
  if (metric == "points") {
    summary_data <- summary_data %>%
      mutate(total_points = ifelse(shot_type == "3-pointer", total_shots * 3, total_shots * 2))
  }

  #side by side plots
  plot_metric <- ifelse(metric == "points", "total_points", "total_shots") #metric for the plot
  y_label <- ifelse(metric == "points", "Total Points", "Total Shots") #label depending on metric

  #split data based on seasons
  data_2001 <- summary_data %>% filter(season == "2001-2002")
  data_2021 <- summary_data %>% filter(season == "2021-2022")

  #construct plot for 2001-2002 season
  p1 <- ggplot(data_2001, aes(x = shot_type, y = .data[[plot_metric]], fill = shot_type)) +
    geom_bar(stat = "identity", width = 0.6) +
    labs(title = "2001–2002 Season", x = "Shot Type", y = y_label) +
    theme_minimal() +
    theme(legend.position = "none")

  #construct plot for 2021-2022 season
  p2 <- ggplot(data_2021, aes(x = shot_type, y = .data[[plot_metric]], fill = shot_type)) +
    geom_bar(stat = "identity", width = 0.6) +
    labs(title = "2021–2022 Season", x = "Shot Type", y = y_label) +
    theme_minimal() +
    theme(legend.position = "none")

  #final side-by-side plot
  combined_plot <- p1 + p2 + plot_layout(ncol = 2)

  return(list(summary = summary_data, plot = combined_plot))
}
