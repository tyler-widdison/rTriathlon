#' The Results method searches a specified collection and returns a corresponding basic object for each.
#' We don’t recommend to merge the results of several queries in a single results list because their ranking criteria are often non-comparable: rather display them in separated sections.
#' @references \url{https://developers.triathlon.org/reference/search-results}
#' @param event_no numeric: event number
#' @param prog_no numeric: program number
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   tri_results_list_get(90162, 270563)
#' }
#'
#' @export

tri_results_list_get <- function(event_no, prog_no){

    url = paste0("https://api.triathlon.org/v1/events/",event_no,"/programs/",prog_no,"/results")
    res <- GET(url,add_headers(c("apikey" = "2649776ef9ece4c391003b521cbfce7a")))
    df <- jsonlite::fromJSON(rawToChar(res$content))
    res <- df$data$results
    res$event_id <- event_no
    res$prog_id <- prog_no
    if(!("athlete_id" %in% colnames(res))){ res$athlete_id <- "" }
    if(!("athlete_title" %in% colnames(res))){ res$athlete_title <- "" }
    if(!("athlete_gender" %in% colnames(res))){ res$athlete_gender <- "" }
    if(!("athlete_yob" %in% colnames(res))){ res$athlete_yob <- "" }
    if(!("athlete_noc" %in% colnames(res))){ res$athlete_noc <- "" }
    if(!("position" %in% colnames(res))){ res$position <- "" }
    if(!("total_time" %in% colnames(res))){ res$total_time <- "" }
    # res$swim <- lapply(res$splits, `[[`, 1)
    # res$T1 <- lapply(res$splits, `[[`, 2)
    # res$bike <- lapply(res$splits, `[[`, 3)
    # res$T2 <- lapply(res$splits, `[[`, 4)
    # res$run <- lapply(res$splits, `[[`, 5)

    temp_res <- res[,c("event_id","prog_id","athlete_id","athlete_title","athlete_gender","athlete_yob","athlete_noc","position","total_time")]

    for(i in 1:length(res$splits[[1]])) {
      temp_res$split_i <- unlist(lapply(res$splits, `[[`, i))
      colnames(temp_res)[length(colnames(temp_res))] <- paste0("split_",i)
    }

    if( bfirst == TRUE ){
      dfout <- temp_res
      bfirst <- FALSE
    } else {
      dfout <- plyr::rbind.fill(dfout,temp_res)
    }

  }

  return(dfout)

}
