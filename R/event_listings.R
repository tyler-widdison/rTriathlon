#' The Event Listings method returns a paginated, filterable list of basic event objects matching the search criteria.
#'
#' @references \url{https://developers.triathlon.org/reference/event-listings}
#' @param startdate date: start date to search for events
#' @param enddate date: end date to search for events
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   tri_get_event_list('2023-01-01', '2023-02-01')
#' }
#'
#' @export

tri_get_event_list <- function(startdate, enddate){
  # function to get events based on filter parameters #
  url = "https://api.triathlon.org/v1/search/events"
  npage <- 1
  bfirst <- TRUE
  while (npage > 0) {
    # Query the API
    res <- httr::GET(url, httr::add_headers(c("apikey" = "2649776ef9ece4c391003b521cbfce7a")),
               query = list(page = npage, per_page = 100, start_date = startdate, end_date = enddate))
    # Turn the result in a dataframe
    df <- jsonlite::fromJSON(rawToChar(res$content))
    events <- df$data
    if (length(df$data) > 0 ) {
      npage <- npage + 1
      events <- events %>% dplyr::filter(event_cancelled == FALSE) %>% dplyr::select(-`_highlightResult`)
      #events <- events[,c("event_id","event_title","event_venue","event_country","event_finish_date")]
      if (bfirst == TRUE) {
        dfout <- events
        bfirst <- FALSE
      } else {
        dfout <- rbind(dfout,events)
      }
    } else{
      npage <- 0
    }
  }
  return(dfout)
}
