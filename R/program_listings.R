#' The Program Listings method returns an array of basic program objects for an event id.
#'
#' @references \url{https://developers.triathlon.org/reference/program-listings}
#' @param no :event number
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   tri_program_list_get(90162)
#' }
#'
#' @export

tri_program_list_get <- function(no) {
  tryCatch({
    do.call(rbind, lapply(no, function(event_id) {
      url <- paste0("https://api.triathlon.org/v1/events/", event_id, "/programs")
      res <- httr::GET(url, httr::add_headers(c("apikey" = "2649776ef9ece4c391003b521cbfce7a")))
      df <- jsonlite::fromJSON(rawToChar(res$content))
      prog <- df$data
      #prog <- prog %>% dplyr::filter(results == TRUE)
      return(prog)
    }))
  }, error = function(e) {
    message("An error occurred: ", e$message)
    return(NULL)
  })
}
