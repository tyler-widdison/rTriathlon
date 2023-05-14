#' This Athlete Ranking Breakdown method returns detailed ranking information for an athlete.
#' It provides the result of all events that are contained within a ranking criteria and contains
#' detailed information as to the status of that event.
#'
#' A basic athlete object and ranking listing object are returned with all rankings details
#' contained within the breakdown object.
#'
#' The output of the breakdown object is ranking specific and you should consult each ranking
#' criteria for more information but the following guidelines may be used:
#'
#' For events with multiple periods the current period is designated as 1 and the prior
#' period 2.
#' The event type corresponds to the points level listed on each ranking criteria which is
#' used to determine the number of scoring positions and maximum number of points.
#' For some ranking criteria the results of the event are modified according to the ranking
#' criteria (e.g. where non-continental athletes are in the results of a Continental event). In
#' these cases the prog_id refers to the results used and the original results are available in
#' the override_prog_id. Similarly the override_prog_time and original_position may be
#' used for the raw non-modified data.
#' The boolean include value displays whether this score has been included in the ranking
#' score
#' For events that are within a separate event e.g. a National Championship event taking
#' place in a Continental Cup the event_container key will show the event_id of the
#' containing event.
#' If the event has been modified and a deduction is applicable the % deduction will be
#' shown
#' The notes key contains specific information as to why the score has not been included if
#' applicable
#'
#' @references \url{https://developers.triathlon.org/reference/athlete-ranking-breakdown}
#' @param rank_no :ranking id
#' @param athlete_no :athlete number
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   tri_athlete_ranking_breakdown(14, 7776)
#' }
#'
#' @export

tri_athlete_ranking_breakdown <- function(rank_no, athlete_no) {
  tryCatch({
    url <- paste0("https://api.triathlon.org/v1/rankings/", rank_no, "/breakdown/", athlete_no)
    res <- httr::GET(url, httr::add_headers(c("apikey" = "2649776ef9ece4c391003b521cbfce7a")))
    df <- jsonlite::fromJSON(rawToChar(res$content))
    prog <- df$data$breakdown
    prog$ranking_id <- df$data$ranking_id
    prog$ranking_cat_id <- df$data$ranking_cat_id
    prog$ranking_cat_name <- df$data$ranking_cat_name
    prog$ranking_name <- df$data$ranking_name
    prog$published <- df$data$published
    prog$region_id <- df$data$region_id
    prog$week <- df$data$week
    prog$region_name <- df$data$region_name
    prog$athlete_id <- df$data$rankings$athlete_id
    prog$athlete_title <- df$data$rankings$athlete_title
    prog$athlete_first <- df$data$rankings$athlete_first
    prog$athlete_last <- df$data$rankings$athlete_last
    prog$athlete_gender <- df$data$rankings$athlete_gender
    prog$validated <- df$data$rankings$validated
    prog$updated_at <- df$data$rankings$updated_at
    prog$athlete_profile_image <- df$data$rankings$athlete_profile_image
    prog$dob <- df$data$rankings$dob
    prog$athlete_country_id <- df$data$rankings$athlete_country_id
    prog$athlete_edit_date <- df$data$rankings$athlete_edit_date
    prog$athlete_yob <- df$data$rankings$athlete_yob
    prog$athlete_slug <- df$data$rankings$athlete_slug
    prog$athlete_noc <- df$data$rankings$athlete_noc
    prog$athlete_country_name <- df$data$rankings$athlete_country_name
    prog$athlete_country_isoa2 <- df$data$rankings$athlete_country_isoa2
    prog$athlete_age <- df$data$rankings$athlete_age
    prog$athlete_listing <- df$data$rankings$athlete_listing
    prog$athlete_flag <- df$data$rankings$athlete_flag
    prog$athlete_api_listing <- df$data$rankings$athlete_api_listing
    prog$athlete_categories <- df$data$rankings$athlete_categories
    prog$rank <- df$data$rankings$rank
    prog$last_rank <- df$data$rankings$last_rank
    prog$change <- df$data$rankings$change
    prog$last_total <- df$data$rankings$last_total
    prog$total <- df$data$rankings$total
    prog$total_current_period <- df$data$rankings$total_current_period
    prog$total_previous_period <- df$data$rankings$total_previous_period
    prog$events_current_period <- df$data$rankings$events_current_period
    prog$events_previous_period <- df$data$rankings$events_previous_period
    prog$ccups_current_period <- df$data$rankings$ccups_current_period
    prog$ccups_previous_period <- df$data$rankings$ccups_previous_period
    return(prog)
  }, error = function(e) {
    message(paste0("Error: ", e$message))
    return(NULL)
  })
}
