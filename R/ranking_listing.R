#' The Rankings Listing method simply returns all available rankings and corresponding supplemental information such as the last published date.
#' You may restrict returned results by either category_id or region_id.
#' For weekly rankings an ISO week date is presented to identify the ranking week.
#'
#' @references \url{https://developers.triathlon.org/reference/rankings-listing}
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   tri_ranking_list()
#' }
#'
#' @export

tri_ranking_list <- function() {
  tryCatch({
    url <-  "https://api.triathlon.org/v1/rankings"
    res <- httr::GET(url, httr::add_headers(c("apikey" = "2649776ef9ece4c391003b521cbfce7a")))
    df <- jsonlite::fromJSON(rawToChar(res$content))
    prog <- df$data
    return(prog)
  }, error = function(e) {
    message("An error occurred: ", e$message)
    return(NULL)
  })
}
