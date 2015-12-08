
require(shiny)
require(shinydashboard)
require(leaflet)

dashboardPage(
  dashboardHeader(
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Crosstab", tabName = "Islam", icon = icon("dashboard")),
      menuItem("Crosstab", tabName = "Buddhism", icon = icon("dashboard")),
      menuItem("Barchart", tabName = "barchart", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "Buddhism",
              selectInput("selectCountry2", h3("Country"), choices = c("Bhutan","Cambodia","Laos","Sri Lanka","Thailand","Vietnam"), selected = "Bhutan"),
              
              
              plotOutput("buddh_plot")
      ),
      tabItem(tabName = "Islam",
              selectInput("selectCountry1", h3("Country"), choices = c("Barbados","Benin","Bulgaria","Burkina Faso","Cameroon","Central African Republic","Chad","Comoros","Cyprus","Djibouti","Eritrea","Ethiopia","Gambia","Ghana","Guinea","Guinea-Bissau","India","Indonesia","Iran","Iraq","Ivory Coast","Kenya","Kuwait","Kyrgyzstan","Liberia","Macedonia","Malawi","Malaysia","Maldives","Mali","Mauritania","Mauritius","Mozambique","Niger","Nigeria","Pakistan","Russia","Senegal","Sierra Leone","Somalia","Tanzania","Thailand","Togo","Uganda","United Arab Emirates","Yugoslavia"), selected = "Barbados"),
              
              
              plotOutput("islam_plot")
      ),
      # Second tab content
      tabItem(tabName = "barchart",
              actionButton(inputId = "clicks2",  label = "Click me"),
              plotOutput("distPlot2")
      )

    )
  )
)



