# Shiny UI


require(shiny)
require(shinydashboard)
require(leaflet)

dashboardPage(
  dashboardHeader(title = "DV_FinalProject: Religions, War and Refugees", titleWidth = 500
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Quan's Barchart", tabName = "quan1", icon = icon("th")),
      menuItem("Quan's Scatterplot", tabName = "quan2", icon = icon("th")),
      menuItem("Chris -- Islam", tabName = "Islam", icon = icon("dashboard")),
      menuItem("Chris -- Buddhism", tabName = "Buddhism", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    tabItems(
      # CHRIS
      tabItem(tabName = "Buddhism",
              selectInput("selectCountry2", h3("Country"), choices = c("Bhutan","Cambodia","Laos","Sri Lanka","Thailand","Vietnam"), selected = "Bhutan"),
              
              
              plotOutput("buddh_plot")
      ),
      # CHRIS II: SON OF CHRIS
      tabItem(tabName = "Islam",
              selectInput("selectCountry1", h3("Country"), choices = c("Barbados","Benin","Bulgaria","Burkina Faso","Cameroon","Central African Republic","Chad","Comoros","Cyprus","Djibouti","Eritrea","Ethiopia","Gambia","Ghana","Guinea","Guinea-Bissau","India","Indonesia","Iran","Iraq","Ivory Coast","Kenya","Kuwait","Kyrgyzstan","Liberia","Macedonia","Malawi","Malaysia","Maldives","Mali","Mauritania","Mauritius","Mozambique","Niger","Nigeria","Pakistan","Russia","Senegal","Sierra Leone","Somalia","Tanzania","Thailand","Togo","Uganda","United Arab Emirates","Yugoslavia"), selected = "Barbados"),
              
              
              plotOutput("islam_plot")
      ),
      # QUAN1
      tabItem(tabName = "quan1",
              sliderInput("animation", "Year:", 1955, 2010, 1955, step = 5, 
                          animate=animationOptions(interval=1000, loop=T)),
              plotOutput("QPlot1")
      ),
      # QUAN2
      tabItem(tabName = "quan2",
              plotOutput("QPlot2")
      )
      
      
      
    )
  )
)
