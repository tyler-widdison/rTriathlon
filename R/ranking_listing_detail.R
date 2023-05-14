#' The Ranking Detail method returns the output of a specified ranking and contains all the
#' summary information required for basic ranking information. A Rankings Listing object is
#' returned containing the summary information about the ranking returned while the rankings
#' themselves are contained within a corresponding rankings object.
#'
#' @references \url{https://developers.triathlon.org/reference/ranking-detail}
#' @param no :ranking id
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   tri_ranking_detail(11)
#' }
#'
#' @export

tri_ranking_detail <- function(rank_id) {
  tryCatch({
    url <-  paste0("https://api.triathlon.org/v1/rankings/", rank_id)
    res <- httr::GET(url, httr::add_headers(c("apikey" = "2649776ef9ece4c391003b521cbfce7a")))
    df <- jsonlite::fromJSON(rawToChar(res$content))
    prog <- df$data$rankings
    prog$week <- df$data$week
    prog$region_name <- df$data$region_name
    prog$region_id <- df$data$region_id
    prog$ranking_name <- df$data$ranking_name
    prog$ranking_cat_name <- df$data$ranking_cat_name
    prog$ranking_cat_id <- df$data$ranking_cat_id
    prog$ranking_id <- df$data$ranking_id
    return(prog)
  }, error = function(e) {
    message("An error occurred: ", e$message)
    return(NULL)
  })
}
