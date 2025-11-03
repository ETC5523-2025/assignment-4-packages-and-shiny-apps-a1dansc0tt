#' Shot data from the NBA 2001-2002 and 2021-2022 seasons
#'
#' @format ## 'clean_data.rda'
#' A data frame with 596023 rows and 16 columns
#' \describe{
#'   \item{match_id}{A unique game identifier for each matchup}
#'   \item{shotX}{x coordinate of shot location}
#'   \item{shotY}{y coordinate of shot location}
#'   \item{quarter}{quarter of the game}
#'   \item{time_remaining}{time remaining in the quarter}
#'   \item{player}{name of player who took the shot}
#'   \item{team}{3 letter abbreviation of offensive team}
#'   \item{made}{whether the shot was successful or not}
#'   \item{shot_type}{2 or 3 pointer}
#'   \item{distance}{distance from the hoop (dunks are zero distance from hoop)}
#'   \item{score}{game score after shot}
#'   \item{opp}{3 letter abbreviation of defensive team}
#'   \item{status}{gane status after the shot (leads, trails, tied)}
#' }
#' @source <https://www.basketball-reference.com/>
"clean_data"
#usethis::use_data(clean_data, overwrite = TRUE)
