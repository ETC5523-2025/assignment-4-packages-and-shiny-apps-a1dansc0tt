library(shiny)
library(ggplot2)
library(dplyr)
library(nbashotpackage)
library(patchwork)

ui <- fluidPage(

#Styling using CSS
  tags$head(
    tags$style(HTML("
      body {
        background-color: #17408B80;
        font-family: 'Helvetica Neue', Arial, sans-serif;
      }

      h1, h2, h3 {
        font-weight: 700;
        letter-spacing: 0.5px;
      }

      h1 {
        font-size: 34px;
        margin-bottom: 25px;
      }

      h3 {
        margin-top: 5px;
        font-size: 22px;
      }

      .sidebar {
        background-color: #89CFF0;
        border-radius: 8px;
        padding: 10px;
        margin-top: 15px;
      }

      .content-box {
        background-color: #89CFF0;
        border-radius: 8px;
        padding: 15px;
        margin-top: 15px;
      }

      .selectize-input {
        border-radius: 6px !important;
      }
    "))
  ),

  #main title
  titlePanel("NBA Shot Type Analyser Across Time"),

  fluidRow(
    #sidebar
    column(
      width = 4,
      div(class = "sidebar",

          h4("Select an NBA team and metric to compare between the 2001-2002 and 2021-2022 seasons."),

          selectInput(
            inputId = "team",
            label = "Choose your favourite NBA team (3 letter abbreviation)",
            choices = sort(unique(clean_data$team)),
            selected = "BOS"
          ),

          selectInput(
            inputId = "metric",
            label = "Select metric to display",
            choices = c("shots", "points"),
            selected = "points"
          ),

          strong("Metric definitions"),
          tags$ul(
            tags$li("'shots' = the total number of 2pt and 3pt attempts"),
            tags$li("'points' = the total points scored by 2pt and 3pt attempts")
          ),

          strong("Important Note"),
          tags$ul(
            tags$li("The purpose of this plot is to compare the proportion of 2pt and 3pt attempts across time. At the time of creation data for the entire 2021-2022 NBA season was not availble, which causes the axis scale on the two plots to vary. This does not effect the analysis as the proportion of each shot type is unlikely to change significantly over the course of a sinlge season."),
            tags$li("Additionally, for some select teams one plot will not display. This is due to teams changing names and abbreviation identifiers across time."),
          )
      )
    ),

    #main content
    column(
      width = 8,

      div(class = "content-box",
          h3("Shot Comparison Plot"),
          plotOutput("plot")
      ),

      div(class = "content-box",
          h3("Summary Table"),
          tableOutput("table"),

          p("Interpretation: When metric 'points' is selected the plots display the given teams total number of points scored in the 2001-2002 and 2021-2022 seasons. When metric 'shots' is selected the plots display the given teams total number of each type of shot in the 2001-2002 and 2021-2022 seasons. The table below displays the numerical data used for the plots."),
          p("The purpose of this app is to compare how shot selection has changed in the NBA over the span of 20 years.")
      )
    )
  )
)

server <- function(input, output, session) {

  #rendering plot
  output$plot <- renderPlot({
    analyse_shots(
      data = clean_data,
      team_filter = input$team,
      metric = input$metric
    )$plot
  })

  #rendering table
  output$table <- renderTable({
    analyse_shots(
      data = clean_data,
      team_filter = input$team,
      metric = input$metric
    )$summary
  })
}

shinyApp(ui, server)
