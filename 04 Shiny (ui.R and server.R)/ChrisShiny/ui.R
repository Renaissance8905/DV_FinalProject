
require(shiny)
require(shinydashboard)
require(leaflet)

dashboardPage(
  dashboardHeader(
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Crosstab", tabName = "crosstab", icon = icon("dashboard")),
      menuItem("Barchart", tabName = "barchart", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "crosstab",
              selectInput("selectCountry", h3("Country"), choices = c("Barbados","Benin","Bulgaria","Burkina Faso","Cameroon","Central African Republic","Chad","Comoros","Cyprus","Djibouti","Eritrea","Ethiopia","Gambia","Ghana","Guinea","Guinea-Bissau","India","Indonesia","Iran","Iraq","Ivory Coast","Kenya","Kuwait","Kyrgyzstan","Liberia","Macedonia","Malawi","Malaysia","Maldives","Mali","Mauritania","Mauritius","Mozambique","Niger","Nigeria","Pakistan","Russia","Senegal","Sierra Leone","Somalia","Tanzania","Thailand","Togo","Uganda","United Arab Emirates","Yugoslavia"), selected = "Barbados"),
              
              plotOutput("distPlot1")
      ),
      
      # Second tab content
      tabItem(tabName = "barchart",
              actionButton(inputId = "clicks2",  label = "Click me"),
              plotOutput("distPlot2")
      )

    )
  )
)



