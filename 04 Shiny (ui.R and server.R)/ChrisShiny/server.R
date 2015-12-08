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

shinyServer(function(input, output) {
  religion_table <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="""SELECT STATE_NAME, YEAR YR, ISLMGENPCT * 100 islam_total, ISLMSUNPCT * 100 sunni, ISLMSHIPCT * 100 shiite, ISLMOTHRPCT * 100 islam_other, ISLMNATPCT * 100 Nation_Of_Islam, ISLMIBDPCT * 100 Ibadhi, ISLMAHMPCT * 100 Ahmadiyya, ISLMALWPCT * 100 Alawite FROM RELIGIONS_BY_NATION LEFT JOIN COW_STATE_CODES ON COW_STATE_CODES.STATE_NUM = RELIGIONS_BY_NATION.STATE"""')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cjs2599', PASS='orcl_cjs2599', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
  
  output$distPlot1 <- renderPlot(height = 500, width = 1000, {   
  
  
  country_selection <- input$selectCountry
  
    religion_table %>% filter(STATE_NAME == country_selection) %>% select(YR, ISLAM_OTHER, SUNNI, SHIITE, ALAWITE, AHMADIYYA, IBADHI, NATION_OF_ISLAM) -> religion_table_filtered
    
    melt(religion_table_filtered, id.vars = "YR", variable.name = "SECT", value.name = "PCT") -> religion_table_melted
    
  
          
    religion_plot <- ggplot() +
      layer(data=religion_table_melted, 
            mapping=aes(x=as.numeric(as.character(YR)),y=PCT, fill=SECT),
            stat="identity", 
            stat_params=list(),
            geom="area",
            geom_params=list()
      ) + labs(title=country_selection) +
      labs(x="Year", y="% of Population") +
      guides(fill=guide_legend(title=NULL)) +
      expand_limits(y=c(0,100)) +
      expand_limits(x=c(1945,2015)) +
      scale_x_continuous(breaks=c(1945, 1950, 1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015))

    
    
    
    return(religion_plot)
  })
  
  
  
})
  
  




#  religion_table <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="""SELECT STATE_NAME, YEAR YR, ISLMGENPCT * 100 islam_total, ISLMSUNPCT * 100 sunni, ISLMSHIPCT * 100 shiite, ISLMOTHRPCT * 100 islam_other, ISLMNATPCT * 100 Nation_Of_Islam, ISLMIBDPCT * 100 Ibadhi, ISLMAHMPCT * 100 Ahmadiyya, ISLMALWPCT * 100 Alawite, BUDGENPCT * 100 buddhist_total, BUDTHRPCT * 100 theravadan, BUDMAHPCT * 100 mahayan, BUDOTHRPCT * 100 buddhist_other FROM RELIGIONS_BY_NATION LEFT JOIN COW_STATE_CODES ON COW_STATE_CODES.STATE_NUM = RELIGIONS_BY_NATION.STATE WHERE ISLMGENPCT > 0.1 OR BUDGENPCT > 0.1"""')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cjs2599', PASS='orcl_cjs2599', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
  
  
  
#  religion_table %>% filter(STATE_NAME == "Bulgaria") %>% select(YR, ISLAM_OTHER, SUNNI, SHIITE, ALAWITE, AHMADIYYA, IBADHI, NATION_OF_ISLAM) -> religion_table_filtered
  
#  melt(religion_table_filtered, id.vars = "YR", variable.name = "SECT", value.name = "PCT") -> religion_table_melted
  
#  ggplot() +
#  layer(data=religion_table_melted, 
#        mapping=aes(x=as.numeric(as.character(YR)),y=PCT, fill=SECT),
#        stat="identity", 
#        stat_params=list(),
#        geom="area",
#        geom_params=list()
#  )



