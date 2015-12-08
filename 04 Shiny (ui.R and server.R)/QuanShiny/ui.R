#ui.R

require(shiny)
require(shinydashboard)
require(leaflet)

dashboardPage(
  skin = "green",
  dashboardHeader(title = "Quan's Findings", titleWidth = 300),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Quan's Barchart", tabName = "barchart", icon = icon("barchart")),
      menuItem("Quan's Scatterplot", tabName = "scatterplot", icon = icon("scatterplot"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "barchart",
              sliderInput("animation", "Year:", 1955, 2010, 1955, step = 5, 
                          animate=animationOptions(interval=1000, loop=T)),
              plotOutput("QPlot1")
      ),
      
      # Second tab content
      tabItem(tabName = "scatterplot",
              plotOutput("QPlot2")
      )
    )
  )
)
