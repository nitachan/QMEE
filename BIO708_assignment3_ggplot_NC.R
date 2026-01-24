library(tidyverse)

## Import cleaned data from last assignment ("BIO708_assignment2_datacleaning_NC.R")
abr_cleaned <- readRDS("abr_cleaned.rds")

## Summarize amplitudes
amp_summary <- abr_cleaned %>%
  summarize(
    mean_amp = mean(Amplitude, na.rm = TRUE),
    sd_amp   = sd(Amplitude, na.rm = TRUE),
    n        = n(),
    sem_amp  = sd_amp / sqrt(n),
    .by = c(Age, Sex, Genotype, Wave)
  )

## Construct some (i.e., more than one) ggplots using your data. 

# My first plot will display my ABR amplitude data as mean +/- SEM, with a line between mean points
ggplot(amp_summary, aes(x = Wave, y = mean_amp, color = Genotype, group = Genotype)) +
  geom_point(size = 2) +
  geom_line(linewidth = 1) + 
  
  # Plotting the individual raw data point as jitter to visualize the spread/variation
  geom_jitter(data = abr_cleaned, aes(x = Wave, y = Amplitude, color = Genotype),
    width = 0.2, alpha = 0.2, size = 1) +
  
  # Adding error bars as SEM and faceting to display juvenile and adults as subsets
  geom_errorbar(aes(ymin = mean_amp - sem_amp, ymax = mean_amp + sem_amp),
    width = 0.2, linewidth = 0.5) +
  facet_grid(Sex ~ Age) +
  
  labs(x = "ABR Wave", y = "Mean Amplitude (µV)", color = "Genotype", title = "Mean of ABR Amplitudes Across Waves I-IV") 

# My second plot will look at ABR latencies but first will need to calculate mean and SEM again
lat_summary <- abr_cleaned %>%
  summarize(
    mean_lat = mean(Latency, na.rm = TRUE),
    sd_lat   = sd(Latency, na.rm = TRUE),
    n        = n(),
    sem_lat  = sd_lat / sqrt(n),
    .by = c(Age, Genotype, Wave)
  )

# Reordering level hierarchy because I wanted to display waves I-IV from bottom to top in my graph
lat_summary <- lat_summary %>%
  mutate(
    Wave = factor(Wave, levels = c("IV", "III", "II", "I"))
  )

ggplot(lat_summary, aes(x = Age, y = mean_lat, color = Genotype, group = Genotype)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_errorbar(aes(ymin = mean_lat - sem_lat, ymax = mean_lat + sem_lat),
    width = 0.2,linewidth = 0.5) +
  
  # Splitting the latency graph in multiple plots by wave, stacked vertically with each getting its own y axis
  facet_wrap(~ Wave, ncol = 1, scales = "free_y") +
  labs(x = "Age", y = "Latency (ms)", color = "Genotype", title = "ABR Peak Latency")

