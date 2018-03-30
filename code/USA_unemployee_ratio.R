# 数据来源 http://datasets.flowingdata.com/unemployment09.csv
unemp <- read.csv("data/unemployment09.csv", header = F, stringsAsFactors = F)
names(unemp) <- c("id", "state_fips", "county_fips", "name", "year", 
                  "?", "?", "?", "rate")
unemp$county <- tolower(gsub(" County, [A-Z]{2}", "", unemp$name))
unemp$state <- gsub("^.*([A-Z]{2}).*$", "\\1", unemp$name)

county_df <- map_data("county")
names(county_df) <- c("long", "lat", "group", "order", "state_name", "county")
county_df$state <- state.abb[match(county_df$state_name, tolower(state.name))]
county_df$state_name <- NULL

state_df <- map_data("state")
# Combine together 
choropleth <- merge(county_df, unemp, by = c("state", "county"))
choropleth <- choropleth[order(choropleth$order), ]
choropleth$rate_d <- cut(choropleth$rate, breaks = c(seq(0, 10, by = 2), 35))

library(ggthemes)
ggplot(choropleth, aes(long, lat, group = group)) +
  geom_polygon(aes(fill = rate_d), colour = alpha("white", 1/4), size = 0.2) +
  geom_polygon(data = state_df, colour = "white",fill = NA) +
  scale_fill_brewer(palette = "PuRd") +
  labs(fill = "失业率",title = "unemployment by county, 2009",
       caption = "数据源：http://datasets.flowingdata.com/unemployment09.csv") +
  coord_map("polyconic")  +
  theme_map()

data(quake6,package = "MSG")
ggplot(quake6,aes(x = year,y = as.factor(month))) +
  stat_sum(aes(size = ..n..), colour = "lightblue4") +
  scale_size(range = c(1, 10),breaks = c(10,15,20,25,30,35)) +
  labs(size = "地震次数",x = "年份",y = "月份") +
  theme_bw()