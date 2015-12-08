# server.R
require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(leaflet)
require(DT)

shinyServer(function(input, output) {
  
  dfQ1 <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="""select BUDGEN, YEAR, NAME from RELIGIONS_BY_NATION;"""')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cjs2599', PASS='orcl_cjs2599', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))) 
  
  output$QPlot1 <- renderPlot(width=600, height=500, {
  
    year_selection <- input$animation
    
    dfQ1 <- dfQ1 %>% filter (as.character(NAME) %in% c("CHN", "JPN", "DRV", "MYA", "THI"), as.character(YEAR) == year_selection )
    
    p1 <- ggplot(dfQ1, aes(x=as.character(NAME), y = as.numeric(as.character(BUDGEN)), fill = NAME))  + ylim(0,170000000) +
      geom_bar(stat = "identity") +
      labs(title='Buddhist Population by Country') + 
      labs(x="Year", y="Buddhist Population")
    
    p1
  })

  output$QPlot2 <- renderPlot(width=1100, height=500, {
    
    dfQ2 <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="""select NONRELIGPCT, YEAR, NAME from RELIGIONS_BY_NATION;"""')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cjs2599', PASS='orcl_cjs2599', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); 
    
    dfQ2 <- dfQ2 %>% filter (as.character(NAME) %in% c("RUS", "CUB", "PRK", "CHN", "JAM", "CZE", "FIN", "USA"))
    
    p2 <- ggplot(dfQ2, aes(x=as.character(YEAR), y = as.numeric(as.character(NONRELIGPCT)), color = NAME)) + facet_grid(. ~ NAME) +
      geom_point(stat = "identity") +
      labs(title='Non-religious Fraction of Population by Year and Country') + 
      labs(x="Year", y="Non-religious Fraction of Population")
    
    p2
  })
  
})
