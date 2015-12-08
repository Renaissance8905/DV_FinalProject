require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
require(tidyr)

dfQ2 <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="""select NONRELIGPCT, YEAR, NAME from RELIGIONS_BY_NATION;"""')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cjs2599', PASS='orcl_cjs2599', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); 

dfQ2 <- dfQ2 %>% filter (as.character(NAME) %in% c("RUS", "CUB", "PRK", "CHN", "JAM", "BLR", "EST", "CZE", "HUN", "UKR", "FIN", "USA"))

#df2 <- df %>% group_by(RECORD_YEAR) %>% summarise(sum_refugees = sum(as.numeric(as.character(REFUGEES))))

p1 <- ggplot(dfQ2, aes(x=as.character(YEAR), y = as.numeric(as.character(NONRELIGPCT)), color = NAME)) + facet_grid(. ~ NAME) +
  geom_point(stat = "identity") +
  labs(title='Non-religious Percent of Population by Year and Country') + 
  labs(x="Year", y="Non-religious Percent of Population")

#p1 <- p1  +
#  geom_text(data = df2, 
#            aes(y = sum_refugees, label = sum_refugees, fill = NULL), size = 4,
#            vjust = -0.5) +
#  geom_hline(data = df2, aes(yintercept = mean(as.numeric(as.character(sum_refugees))))) + 
#  annotate("text", x = 1.5, y = 310000, label = 301027, size = 4)
#

p1
