library(ggplot2)
library(ratdat)
library(tidyverse)
library(dplyr)

## JD: Puzzled how you decided what to do, and hwy you did so much. We asked just for a “substantive calculation”.

# Importing csv file containing ABR data [Note: ensure file is in wd]
data <- read.csv("BIO708_Amps_Lats_NC.csv")

# ============================  
# Creating subsets of the data set, separated by age 

adult_data <- data %>% # %>% creates a pipeline
  # Filter rows to extract only adult data, %in% will ask if the value of the left is found on the right vector (from chapter 4)
  filter(Age == "A", Genotype %in% c("WT", "KO"), Wave %in% c("I","II","III","IV"))
  
# Descriptive statistics to better understand data (mean, sd, sem)
adult_summary <- adult_data %>%
  group_by(Genotype, Wave) %>% # will take the Genotype and Wave columns and split them into groups
  summarize(adult_mean_amp = mean(Amplitude, na.rm = T), # collapses the group into a one row summary of means
            adult_sd_amp = sd (Amplitude, na.rm = T), # calculates standard deviation
            adult_sem_amp = adult_sd_amp/sqrt(n()), # calculates standard error of mean
            adult_mean_lat = mean(Latency, na.rm = T), 
            adult_sd_lat = sd (Latency, na.rm = T),
            adult_sem_lat = adult_sd_lat/sqrt(n()),
            n = n(), # counts number of rows in each group
            .groups = "drop") # overrides the grouped output from summarize()

head(adult_summary)

## JD: View can be run in console or you can use the rstudio panel; it's not great for scripts
## View(adult_summary)

juvenile_data <- data %>% # %>% creates a pipeline
  # Filter rows to extract only adult data, %in% will ask if the value of the left is found on the right vector (from chapter 4)
  filter(Age == "J", Genotype %in% c("WT", "KO"), Wave %in% c("I","II","III","IV"))

juv_summary <- juvenile_data %>%
  group_by(Genotype, Wave) %>% # will take the Genotype and Wave columns and split them into groups
  summarize(juv_mean_amp = mean(Amplitude, na.rm = T), # collapses the group into a one row summary of means
            juv_sd_amp = sd (Amplitude, na.rm = T),
            juv_sem_amp = juv_sd_amp/sqrt(n()),
            juv_mean_lat = mean(Latency, na.rm = T), # collapses the group into a one row summary of means
            juv_sd_lat = sd (Latency, na.rm = T),
            juv_sem_lat = juv_sd_lat/sqrt(n()),
            n = n(), # counts number of rows in each group
            .groups = "drop") # overrides the grouped output from summarize()

head(juv_summary)
View(juv_summary)

# ============================
# Calculating the coeffficient of vaciation - this is an important parameter to look at because we hypothesize greater variation in KO
adult_summary <- adult_summary %>%
  mutate(adult_cv_amp = adult_sd_amp/adult_mean_amp,
         adult_cv_late = adult_sd_lat/adult_mean_lat)

head(adult_summary)
View(adult_summary)

juv_summary <- juv_summary %>%
  mutate(juv_cv_amp = juv_sd_amp/juv_mean_amp,
         juv_cv_late = juv_sd_lat/juv_mean_lat)

head(juv_summary)
View(juv_summary)

# ============================
# Plotting the data

# Boxplot for adult data
ggplot(adult_data, mapping = aes(x = Wave, y = Amplitude, fill = Genotype)) +
  geom_boxplot() +
  geom_point(alpha = 0.2) 

# Boxplot for juvenile data
ggplot(juvenile_data, mapping = aes(x = Wave, y = Amplitude, fill = Genotype)) +
  geom_boxplot() +
  geom_point(alpha = 0.2) 

## JD: Please try to make your submission responsive to the assignment; this allows us to focus and give useful feedback to the large number of students.
## Grade 2/3

