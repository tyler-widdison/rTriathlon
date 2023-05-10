
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rTriathlon

<!-- badges: start -->
<!-- badges: end -->

rTriathlon is a client for <https://www.triathlon.org/>.

## Installation

You can install the development version of rTriathlon from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tyler-widdison/rTriathlon")
```

## Example

Get a list of triathlon events:

``` r
library(rTriathlon)
#> Loading required package: magrittr
event_list <- tri_get_event_list('2022-01-01', '2023-01-01')
nrow(event_list)
#> [1] 358
```

Get details for a specific event:

``` r
event_id <- event_list$event_id[1:5]
prog_list <- tri_program_list_get(event_id)
prog_list %>% dplyr::select(prog_id, event_id, prog_name) %>% head
#>   prog_id event_id   prog_name
#> 1  583767   174221   Elite Men
#> 2  583768   174221 Elite Women
#> 3  581593   173705   Elite Men
#> 4  581594   173705 Elite Women
#> 5  559799   168057   Elite Men
#> 6  559800   168057 Elite Women
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

### Version control

Currently in a developmental state
