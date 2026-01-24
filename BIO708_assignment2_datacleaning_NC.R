library(tidyverse)

# Importing csv file containing ABR data [Note: ensure file is in wd]
abr_data <- read.csv("BIO708_Amps_Lats_NC.csv")

# ============================  
# Examine structure of the data you imported
str(abr_data) 
sapply (abr_data,class) # explicitly checks classes for every header
# Shows that I have two types of variables - characters and numbers

# Examine the data for problems, and to make sure you understand the R classes
# Will check if my categorical variables (Age, Sex, Genotype, Age) have expected categories
categorical <- c("SubjectID", "Age", "Sex", "Genotype", "Wave")
lapply(abr_data[categorical], unique)
lapply(abr_data[categorical], table)

# Output shows expect categories for each variable

# Now lets check to make sure there's no duplicates for the same mouse and wave
abr_duplicates <- abr_data %>%
  count(SubjectID, Wave) %>%
  filter(n > 1)
print(abr_duplicates)
# The output is '0 rows' which means no duplicates
## BMB:
stopifnot(nrow(abr_duplicates) == 0)

# Time to check if there are NA values in the numerical variables
# From abr_data, count how many NAs there are in numeric columns (i.e. Amplitude, Latency, P2P)
amps_lats <- abr_data %>%
  summarise(across(where(is.numeric), ~ sum(is.na(.))))
print(amps_lats)
## BMB: (use unlist() to turn a row of a data frame into a vector)
stopifnot(all(unlist(amps_lats)  == 0))

# Time to convert character variables to factors to clean data 
abr_clean <- abr_data %>%
  mutate(
    SubjectID = factor(SubjectID),
    Sex = factor(Sex),
    Age = factor(Age, levels = c("J", "A")), # changed to factor with two levels
    Genotype = factor(Genotype, levels = c("WT", "KO")), # changed to factor with two levels
    Wave = factor(Wave, levels = c("I", "II", "III", "IV"))  # changed to factor with four levels
  )

# Re-check structure - categorical variables should now be factors, can also just do this in console 
str(abr_clean)

# ============================  
# Make one or two plots that might help you see whether your data have any errors or anomalies
ggplot(abr_clean, aes(x = Wave, y = Amplitude, color = Genotype)) +
  geom_boxplot() +
  labs(y = "Amplitude (uV)", title = "ABR Wave Amplitude")

ggplot(abr_clean, aes(x = Wave, y = Latency,  color = Genotype)) +
  geom_boxplot() +
  labs(x = "Latency (ms)", title = "ABR Wave Latency")

# Can see some outliers, particularly for wave III amplitudes but this can be cleaned in the future with separate age analysis

# ============================  
# Use the saveRDS function in R to save a clean (or clean-ish) version of your data
saveRDS(abr_clean, file = "abr_cleaned.rds")
