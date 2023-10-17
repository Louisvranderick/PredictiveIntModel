library(nflfastR) 
library(tidyverse) 


#Loading the play-by-play data into pbp
pbp <- load_pbp(2016:2022) 

#loading all the pass plays into pbpPass by filtering out all the plays that
#dont have a passer
pbpPass <- 
  pbp |> 
  filter(!is.na(passer_id)) 

#New data frame where we replace the plays that have no interceptions with
#the number 0. We only keep the columns we need using the summarize function 
#Where N is the number of passes. PassInt is the sum of all interceptions that 
#game and total_line is the line for the over under of the total score. 
pbpPassInt <- 
  pbpPass |> 
  mutate(interception = ifelse(is.na(interception),0,interception)) |> 
  group_by(season, week, passer_id, passer) |> 
  summarize(n_passes = n(), 
            passInt = sum(interception), 
            total_line  = mean(total_line)) |> 
  filter(n_passes >= 10) 

pbpPassInt |>
  group_by(passInt) |> 
  summarize(n = n())
  
pbpPassInt |> 
  ungroup() |> 
  select(-passer, -passer_id) |> 
  summary()

pbpPassIntMean <- 
  pbpPassInt |> 
  pull(passInt) |> 
  mean()

#pbpPassInt with greater or equal to 10 passes
pbpPassIntG10 <- 
  pbpPassInt |> 
  filter(n_passes >= 10)

x_r <- tibble() 

for (season_idx in seq(2017,2022)) { 
  for (week_idx in seq(1,22)) {
    week_cal <- 
      pbpPassIntG10 |> 
      filter((season == (season_idx - 1)) | 
      (season == season_idx && week < week_idx)) |> 
      group_by(passer_id, passer) |> 
      summarize(
        n_games = n(), 
        passIntRate = mean(passInt), 
        .groups = "keep"
      ) |> 
      mutate(season = season_idx, week = week_idx) 
    
    x_r <- bind_rows(x_r, week_cal)
    }
}


pbpPassIntG10 <- 
  pbpPassIntG10 |> 
  inner_join(x_r, by = c("season", "week", "passer_id", "passer"))

passFit <- 
  glm(passInt ~ passIntRate + total_line, data = pbpPassIntG10, family = "poisson") 

pbpPassIntG10 <- 
  pbpPassIntG10 |> 
  ungroup() |> 
  mutate(exp_pass_int = predict(passFit, type = "response")) 

pbpPassIntG10 <- 
  pbpPassIntG10 |> 
  mutate(int0 = dpois(x = 0 , lambda = exp_pass_int), 
         int1 = dpois(x = 1 , lambda = exp_pass_int), 
         int2 = dpois(x = 2 , lambda = exp_pass_int), 
         int3more = ppois(q = 2 , lambda = exp_pass_int, lower.tail = FALSE))

pbpPassIntG10 |> 
  filter(passer == "J.Fields", season == "2022") |> 
  select(-passInt, -n_passes, -passer_id, -season, -n_games) |> 
  arrange(-week) |> 
  print(n = Inf)