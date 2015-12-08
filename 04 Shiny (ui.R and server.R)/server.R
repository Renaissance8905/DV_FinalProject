# Shiny Server


# server.R
require("jsonlite")
require(ggplot2)
require(reshape2)
require("RCurl")
require(dplyr)
require(shiny)
require(shinydashboard)
require(leaflet)
require(DT)


## Chris -- ISLAM
shinyServer(function(input, output) {
  religion_table <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="""SELECT STATE_NAME, YEAR YR, ISLMGENPCT * 100 islam_total, ISLMSUNPCT * 100 sunni, ISLMSHIPCT * 100 shiite, ISLMOTHRPCT * 100 islam_other, ISLMNATPCT * 100 Nation_Of_Islam, ISLMIBDPCT * 100 Ibadhi, ISLMAHMPCT * 100 Ahmadiyya, ISLMALWPCT * 100 Alawite FROM RELIGIONS_BY_NATION LEFT JOIN COW_STATE_CODES ON COW_STATE_CODES.STATE_NUM = RELIGIONS_BY_NATION.STATE"""')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cjs2599', PASS='orcl_cjs2599', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
  
  output$islam_plot <- renderPlot(height = 500, width = 1000, {   
    country_selection1 <- input$selectCountry1
    religion_table %>% filter(STATE_NAME == country_selection1) %>% select(YR, ISLAM_OTHER, SUNNI, SHIITE, ALAWITE, AHMADIYYA, IBADHI, NATION_OF_ISLAM) -> religion_table_filtered
    melt(religion_table_filtered, id.vars = "YR", variable.name = "SECT", value.name = "PCT") -> religion_table_melted
    islam_plot <- ggplot() +
      layer(data=religion_table_melted, 
            mapping=aes(x=as.numeric(as.character(YR)),y=PCT, fill=SECT),
            stat="identity", 
            stat_params=list(),
            geom="area",
            geom_params=list()
      ) + labs(title=country_selection1) +
      labs(x="Year", y="% of Population") +
      guides(fill=guide_legend(title=NULL)) +
      expand_limits(y=c(0,100)) +
      expand_limits(x=c(1945,2015)) +
      scale_x_continuous(breaks=c(1945, 1950, 1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015))
    return(islam_plot)
  })
  
  
  
  ## Chris -- BUDDHISM
  buddh_table <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="""SELECT STATE_NAME, YEAR YR, BUDGENPCT * 100 buddhist_total, BUDTHRPCT * 100 theravadan, BUDMAHPCT * 100 mahayan, BUDOTHRPCT * 100 buddhist_other FROM RELIGIONS_BY_NATION LEFT JOIN COW_STATE_CODES ON COW_STATE_CODES.STATE_NUM = RELIGIONS_BY_NATION.STATE"""')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cjs2599', PASS='orcl_cjs2599', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
  
  output$buddh_plot <- renderPlot(height = 500, width = 1000, {   
    country_selection2 <- input$selectCountry2
    buddh_table %>% filter(STATE_NAME == country_selection2) %>% select(YR, BUDDHIST_OTHER, THERAVADAN, MAHAYAN) -> buddh_table_filtered
    melt(buddh_table_filtered, id.vars = "YR", variable.name = "SECT", value.name = "PCT") -> buddh_table_melted
    buddh_plot <- ggplot() +
      layer(data=buddh_table_melted, 
            mapping=aes(x=as.numeric(as.character(YR)),y=PCT, fill=SECT),
            stat="identity", 
            stat_params=list(),
            geom="area",
            geom_params=list()
      ) + labs(title=country_selection2) +
      labs(x="Year", y="% of Population") +
      guides(fill=guide_legend(title=NULL)) +
      expand_limits(y=c(0,100)) +
      expand_limits(x=c(1945,2015)) +
      scale_x_continuous(breaks=c(1945, 1950, 1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015))
    
    return(buddh_plot)
  })
  
  ## Quan
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