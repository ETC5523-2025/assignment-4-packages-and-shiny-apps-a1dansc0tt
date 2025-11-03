
# nbashotpackage

<!-- badges: start -->
<!-- badges: end -->

## Purpose

**nbashotpackage** is an R package developed by Aidan Scott. The purpose of this package is to investigate how the shot selection in the National Basketball League (NBA) has changed over time. 

Specifically, this package examines the changes in shot selection (between 2-pointers and 3-pointers) that occur between the 2001-2002 and 2021-2022 NBA seasons. This investigation was sparked by the general sentiment around the league that NBA offences have shifted to shooting a much higher volume of 3-pointers compared to 2-pointers. These 3-point shots becoming a larger proportion of shots as the art of midrange 2-pointers goes extinct. This package aims to investigate and quantify this change. 

## Example

This is a basic example which shows you how to solve a common problem. Here we aim to plot the type of shots taken in the 2001-2002 season compared to those in the 2021-2022 season for the Boston Celtics. We also select the metric to be points which displays the total amount of points scored from 2-pointers and 3-pointers. 

``` r
library(nbashotpackage)
analyse_shots(clean_data, team_filter = "BOS", metric = "points")$plot
```

## Installation

You can install the nbashotpackage from [GitHub](https://github.com/ETC5523-2025/assignment-4-packages-and-shiny-apps-a1dansc0tt) with:

``` r
# install.packages("remotes")
remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-a1dansc0tt")
```

## Main Components

Here are some of the main components contained within the package that may be of interest to users:

- Data set `cleaned_data` that contains a cleaned data set of shot data for all games from the 2001-2002 NBA season and half of the 2021-2022 NBA season.
- Function `run_my_app()` that launches a shiny app which can be used for an interactive investigation of how shot selection in the NBA has changed between the 2001-2002 and 2021-2022 NBA seasons. 
- Function `analyse_shots()` that creates a plot and summary table (which can be called using the suffix `$plot` or `$summary`) that displays side-by-side bar charts for shot selection for the entire league. Teams can be filtered using the team_filter field as well as options for the metric (either number of shots or number of points).
