library(tidyverse)

# Reads .rds file created from data cleaning script
abr_cleaned <- readRDS("abr_cleaned.rds")

# Calculates the mean amplitude by Age, Genotype, Wave
amp_summary <- abr_cleaned %>%
  group_by(Age, Genotype, Wave) %>% # split data into groups by age, genotype, and wave
  summarize(
    mean_amp = mean(Amplitude, na.rm = TRUE),
    sd_amp   = sd(Amplitude, na.rm = TRUE),
    n        = n(),  # number of entries each group
    .groups = "drop"
  )

print(amp_summary)