library(shiny)
library(ggplot2)
library(dplyr)
library(nbashotpackage)
library(patchwork)

ui <- fluidPage(

  # ---- Custom CSS Styling ----
  tags$head(
    tags$style(HTML("
      body {
        background-color: #f6f7fb;
        font-family: 'Helvetica Neue', Arial, sans-serif;
      }

      h1, h2, h3 {
        font-weight: 700;
        color: #1a1a1a;
        letter-spacing: 0.5px;
      }

      h1 {
        font-size: 34px;
        margin-bottom: 25px;
      }

      h3 {
        margin-top: 35px;
        font-size: 22px;
      }

      .sidebar {
        background-color: lightblue;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
      }

      .content-box {
        background-color: lightblue;
        border-radius: 8px;
        padding: 25px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        margin-top: 15px;
      }

      .selectize-input {
        border-radius: 6px !important;
      }
    "))
  ),

  # ---- Title ----
  titlePanel("NBA Shot Analysis Explorer"),

  fluidRow(
    # ---------- Sidebar (Left Column) ----------
    column(
      width = 4,
      div(class = "sidebar",

          h4("Select an NBA team and metric to explore two seasons (2001–2002 and 2021–2022)."),

          selectInput(
            inputId = "team",
            label = "Choose a team:",
            choices = sort(unique(clean_data$team)),
            selected = "BOS"
          ),

          selectInput(
            inputId = "metric",
            label = "Metric to display:",
            choices = c("shots", "points"),
            selected = "points"
          ),

          br(),
          strong("Metric definitions:"),
          tags$ul(
            tags$li("'shots': total number of 2-pt and 3-pt attempts"),
            tags$li("'points': total points scored by 2-pt and 3-pt attempts")
          )
      )
    ),

    # ---------- Main Content (Right Column) ----------
    column(
      width = 8,

      div(class = "content-box",
          h3("Shot Comparison Plot"),
          plotOutput("plot")
      ),

      div(class = "content-box",
          h3("Summary Table"),
          tableOutput("table"),

          p("Interpretation: The bar charts compare seasons 2001–2002 and 2021–2022."),
          p("Look for shifts in preference between 2-point and 3-point attempts.")
      )
    )
  )
)

server <- function(input, output, session) {

  # ---- Render plot ----
  output$plot <- renderPlot({
    analyse_shots(
      data = clean_data,
      team_filter = input$team,
      metric = input$metric
    )$plot
  })

  # ---- Render table ----
  output$table <- renderTable({
    analyse_shots(
      data = clean_data,
      team_filter = input$team,
      metric = input$metric
    )$summary
  })
}

shinyApp(ui, server)
