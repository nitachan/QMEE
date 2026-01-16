library(palmerpenguins)
library(skimr)
library(tidyverse)
skim(penguins)
head(penguins)


(penguins_sum <- penguins   #its nice to break up pipes to separate lines, also its nice to have a new variable to see intermediate variables
  |> group_by(species, island)
  |> summarise(mass = mean(body_mass_g))    
  )
print(penguins_sum)

penguins_sum <- (penguins
                 |> summarise(mass = mean(body_mass_g), .by = c(species,island))) #do not create variable names starting with .

#across will take a mean of body mass and assign it to body_mass_g - less repeating is better

penguins_sum_means <- (penguins
                       |> summarise(across(c(body_mass_g, flipper_length_mm), # ~ means thing coming up next should not be interpreted directly, a new formula will be added
                        .fns = list(mean = ~mean (., na.rm= TRUE), sd = sd)),
                                    .by = c(species, island)))

print(penguins_sum_means)

se_nona = function(x) {
  sd(x, na.rm=TRUE)/sqrt(length(na.omit(x)))
}


penguins_sum_vars <- penguins
                      |> summarise (across(where(is.numeric))) # goes through and selects only numeric values


penguins |> mutate(across(bill_length_mm, ~. /10)) # rescaling units

mm_to_cm_name <- function(x) {
  stringr::str_replace (x, "mm", "cm")
}
