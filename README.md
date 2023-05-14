
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rTriathlon

<!-- badges: start -->
<!-- badges: end -->

rTriathlon is a client for <https://www.triathlon.org/>.

Resources regarding Triathlon qualifications:

- <https://www.teamusa.org/-/media/USA_Triathlon/PDF/Elite-International/2023/TRI_2024_OLY_ATH_FINAL-With-Signature-NEW.pdf?la=en&hash=327A5F72C8CA11AB41CFEEC84B8D6E1A5CE544C3>

- <https://en.wikipedia.org/wiki/Triathlon_at_the_2024_Summer_Olympics_%E2%80%93_Qualification>

- <https://olympics.com/en/news/pathway-to-paris-triathlon-qualification-system-explained>

- <https://www.triathlon.org/news/article/ioc_approves_the_olympic_qualification_criteria_for_paris_2024_olympics>

- <https://www.triathlon.org/uploads/docs/Paris2024_Olympic_Qualification_Principles.pdf?fbclid=IwAR2daD8STkBG8uBQfAYEXAGFArwEGFUT5xABpDaCYxvp_EPpRpVZ2P-FFV0>

## Installation

You can install the development version of rTriathlon from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tyler-widdison/rTriathlon")
```

## Example

Get a list of triathlon events (this date range happens to be the
Olympic qualification range):

``` r
library(rTriathlon)
#> Loading required package: magrittr
event_list <- tri_get_event_list('2022-05-27', '2024-05-27')
nrow(event_list)
#> [1] 460
```

Get details for a specific event:

``` r
event_id <- event_list$event_id[1:5]
prog_list <- tri_program_list_get(event_id)
prog_list %>% dplyr::select(prog_id, event_id, prog_name) %>% head
#>   prog_id event_id     prog_name
#> 1  560870   168315 Elite Coaches
#> 2  560868   168315     Elite Men
#> 3  560869   168315   Elite Women
#> 4  547740   165006 Elite Coaches
#> 5  547741   165006     Elite Men
#> 6  547742   165006   Elite Women
```

We can then get results from events:

``` r
tri_results_list_get(174221, 583767)
#>    event_id prog_id athlete_id           athlete_title athlete_gender
#> 1    174221  583767     143563            François Vie           male
#> 2    174221  583767      10572             Rui Dolores           male
#> 3    174221  583767     123733          António Barata           male
#> 4    174221  583767      55786              Tiago Maia           male
#> 5    174221  583767     124763             Hugo Baluga           male
#> 6    174221  583767     143281              Joao Jesus           male
#> 7    174221  583767     174222              Rui Matias           male
#> 8    174221  583767      81871 Afonso Silvestre Garcia           male
#> 9    174221  583767     123295            David Coelho           male
#> 10   174221  583767     133923              Nuno Silva           male
#> 11   174221  583767     174223            Alex Cabrita           male
#> 12   174221  583767     174224            Luís Cancela           male
#> 13   174221  583767     174225          Ricardo Rosado           male
#> 14   174221  583767     133889             Paulo Ajuda           male
#> 15   174221  583767     174226           Nuno Carvalho           male
#>    athlete_yob athlete_noc position total_time  split_1  split_2  split_3
#> 1         2002         POR        1   02:40:09 00:18:24 00:01:05 01:40:38
#> 2         1984         POR        2   02:52:12 00:20:19 00:01:05 01:48:47
#> 3         1999         POR        3   02:53:52 00:20:02 00:01:09 01:51:13
#> 4         1990         POR        4   03:02:15 00:18:53 00:01:08 01:55:43
#> 5         1996         POR        5   03:05:23 00:23:42 00:01:15 01:55:26
#> 6         1990         POR        6   03:06:47 00:23:41 00:01:25 01:55:44
#> 7         1995         POR        7   03:10:41 00:24:49 00:01:52 01:57:39
#> 8         1995         POR        8   03:11:07 00:19:13 00:01:32 02:02:36
#> 9         1981         POR        9   03:14:18 00:29:28 00:01:39 02:00:42
#> 10        1978         POR       10   03:19:03 00:30:33 00:01:42 02:02:23
#> 11          NA         POR       11   03:19:26 00:23:54 00:01:53 02:05:10
#> 12        1973         POR       12   03:20:37 00:32:40 00:01:48 02:02:13
#> 13        1984         POR       13   03:20:47 00:23:32 00:01:43 02:09:31
#> 14        1980         POR       14   03:20:56 00:28:11 00:02:15 02:04:11
#> 15        1986         POR       15   03:21:21 00:31:07 00:02:06 01:59:25
#>     split_4  split_5
#> 1  00:00:42 00:39:20
#> 2  00:00:41 00:41:20
#> 3  00:00:47 00:40:41
#> 4  00:00:43 00:45:48
#> 5  00:00:51 00:44:09
#> 6  00:00:47 00:45:10
#> 7  00:00:46 00:45:35
#> 8  00:01:00 00:46:46
#> 9  00:00:51 00:41:38
#> 10 00:00:55 00:43:30
#> 11 00:01:11 00:47:18
#> 12 00:00:59 00:42:57
#> 13 00:00:59 00:45:02
#> 14 00:00:43 00:45:36
#> 15 00:01:16 00:47:27
```

If we only want to consider USA athletes Olympic qualifying events per
<https://triathlon.org/rankings>

``` r
# Get events in qualifying current date range
oly_events <- event_list %>%
    dplyr::mutate(event_date = as.Date(event_date)) %>% 
    tidyr::unnest(event_categories, keep_empty = T) %>% 
    dplyr::filter(cat_id %in% c(351, 348, 345, 349, 341, 340) & event_id != '159913') %>% # filtering out 2022 GBR has used this to qualify already
    dplyr::mutate(keep = ifelse(grepl('Continental', cat_name) & !grepl('America', event_title), 'toss', 'keep')) %>% 
    dplyr::filter(keep == 'keep') %>%
    dplyr::mutate(Year = lubridate::year(event_date),
           Month = lubridate::month(event_date, label = F, abbr = F),
           Day = lubridate::wday(event_date, label = T),
           mday = lubridate::mday(event_date),
           Month_week = (5 + lubridate::day(event_date) + lubridate::wday(lubridate::floor_date(event_date, 'month'))) %/% 7)

oly_events %>% head
#> # A tibble: 6 × 47
#>   event_id event_title      event_slug event_edit_date event_venue event_country
#>      <int> <chr>            <chr>      <chr>           <chr>       <chr>        
#> 1   163471 2022 World Tria… 2022_worl… 2022-08-08T08:… Cannigione… Italy        
#> 2   164485 2022 World Tria… 2022_worl… 2022-06-03T04:… Targu Mures Romania      
#> 3   163472 2022 World Tria… 2022_worl… 2022-06-13T10:… Leeds       Great Britain
#> 4   163474 2022 World Tria… 2022_worl… 2022-11-22T08:… Huatulco    Mexico       
#> 5   163476 2022 World Tria… 2022_worl… 2022-07-12T07:… Hamburg     Germany      
#> 6   164176 2022 Americas T… 2022_amer… 2022-07-16T11:… Alamitos B… United States
#> # ℹ 41 more variables: event_latitude <dbl>, event_longitude <dbl>,
#> #   event_date <date>, event_finish_date <chr>, event_country_isoa2 <chr>,
#> #   event_country_noc <chr>, event_region_id <int>, event_country_id <int>,
#> #   event_region_name <chr>, event_website <chr>, event_status <chr>,
#> #   cat_name <chr>, cat_id <int>, cat_parent_id <lgl>,
#> #   event_specifications <list>, event_flag <chr>, event_listing <chr>,
#> #   event_api_listing <chr>, timestamp <int>, sport <list>, …
```

We can then look at the results for the qualifying `oly_events` events.

``` r
prog_list <- tri_program_list_get(oly_events$event_id)
prog_list <- prog_list %>% dplyr::filter(is_race == T & results == T)

# Function to apply tri_results to multiple events/catagories
get_results <- function(event_nos, prog_nos) {
  results_list <- lapply(seq_along(event_nos), function(i) {
    tryCatch(
      tri_results_list_get(event_no = event_nos[i], prog_no = prog_nos[i]),
      error = function(e) {
        message(paste0("Error retrieving results for event ", event_nos[i], " and program ", prog_nos[i], ": ", e$message))
        return(NULL)
      }
    )
  })
  results_df <- do.call(plyr::rbind.fill, results_list)
  return(results_df)
}

data <- get_results(prog_list$event_id, prog_list$prog_id)

# Join the results back to the oly_events data for event data
df <- data %>% 
  dplyr::left_join(oly_events %>% 
              dplyr::select(event_id, cat_id, event_title, event_date, cat_name), 
            by = c('event_id'))
#> Warning in dplyr::left_join(., oly_events %>% dplyr::select(event_id, cat_id, : Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 3601 of `x` matches multiple rows in `y`.
#> ℹ Row 1 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.

df %>% head
#>   event_id prog_id athlete_id           athlete_title athlete_gender
#> 1   163471  544380      11378       Jonathan Brownlee           male
#> 2   163471  544380      69143          Manoel Messias           male
#> 3   163471  544380      63651             Tom Richard           male
#> 4   163471  544380      56153              Márk Dévay           male
#> 5   163471  544380      70032              Max Studer           male
#> 6   163471  544380      74419 Alberto Gonzalez Garcia           male
#>   athlete_yob athlete_noc position total_time  split_1  split_2  split_3
#> 1        1990         GBR        1   00:54:08 00:08:52 00:00:38 00:28:58
#> 2        1996         BRA        2   00:54:24 00:00:00 00:00:00 00:00:00
#> 3        1993         FRA        3   00:54:35 00:08:56 00:00:39 00:28:52
#> 4        1996         HUN        4   00:54:41 00:08:44 00:00:40 00:29:03
#> 5        1996         SUI        5   00:55:00 00:00:00 00:00:00 00:00:00
#> 6        1998         ESP        6   00:55:13 00:09:01 00:00:40 00:29:36
#>    split_4  split_5 split_6 split_7 split_8 split_9 split_10 split_11 cat_id
#> 1 00:00:22 00:15:16    <NA>    <NA>    <NA>    <NA>     <NA>     <NA>    349
#> 2 00:00:00 00:00:00    <NA>    <NA>    <NA>    <NA>     <NA>     <NA>    349
#> 3 00:00:21 00:15:44    <NA>    <NA>    <NA>    <NA>     <NA>     <NA>    349
#> 4 00:00:22 00:15:50    <NA>    <NA>    <NA>    <NA>     <NA>     <NA>    349
#> 5 00:00:00 00:00:00    <NA>    <NA>    <NA>    <NA>     <NA>     <NA>    349
#> 6 00:00:20 00:15:33    <NA>    <NA>    <NA>    <NA>     <NA>     <NA>    349
#>                          event_title event_date  cat_name
#> 1 2022 World Triathlon Cup Arzachena 2022-05-28 World Cup
#> 2 2022 World Triathlon Cup Arzachena 2022-05-28 World Cup
#> 3 2022 World Triathlon Cup Arzachena 2022-05-28 World Cup
#> 4 2022 World Triathlon Cup Arzachena 2022-05-28 World Cup
#> 5 2022 World Triathlon Cup Arzachena 2022-05-28 World Cup
#> 6 2022 World Triathlon Cup Arzachena 2022-05-28 World Cup
```

We can check out each NOC is fairing thus far:

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />

### Version control

Currently in a developmental state
