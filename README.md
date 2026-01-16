# myrepo

Jan 8th Assignment 1:
The dataset I have provided comes from auditory brainstem recordings (ABR) done in mice. As part of my project, I am examining the brain circuitry link between sensory processing and social behaviour within a genetic model of autism spectrum disorder (ASD) known as the Cntnap2-knockout mouse model. To better understand how sensory processing may be altered within this model, I collected ABR data to examine whether auditory processing is intact within these animals. ABRs are a type of elecctrophysiologycal hearing test that measures how the brain responds to sound and is represented my distinct peaks that occur during recording. Each of these peaks represents a structure along the auditory processing pathway, for instance wave I represents the auditory nerve, and we can extract amplitudes and latencies from these recordings.
From my data, I am trying to determine whether or not auditory processing is altered within the Cntnap2-knockout mouse model and to examine if there is a developmental phenotype.

Jan 16th Assignment 2:

My first script titled "BIO708_assignment2_datacleaning.R" imports my csv file containing my ABR values, and checks its strcuture to see what class each variable belongs to.
Next, it double checks that there are only the expected categories for each of my catgorical variables (i.e Subject ID, Age, Sex, Genotype), and checks that there are no duplicates for the same mouse and wave. To clean the data, all my categorical variables are converted into factors with the amount of levels equal to the expected categories within each header (i.e. Age has two levels since we expect "J" or "A"). Lastly, the amplitudes and latencies were plotted by wave and genotype to identify any outliers or unexpected trends within the values. The clean data is saved as a .RDS file named "abr_cleaned.rds".

My second script titled "BIO708_assignment2_analysis.R" reads the cleaned RDS file genarated from the first script and calculates the mean and standard deviation bt age, genotype and wave.

Both scripts should be run from the QMEE directory in this GitHub:
QMEE/BIO708_assignment2_datacleaning_NC.R
QMEE/BIO708_assignment2_analysis.R

For my data, I want to investigate the amplitude and latency values between the two age groups. This would mean I would filter through the values depending on if they are juvenile or adult, and replicate the components to run the same analysis on both. For age, I would like to investigate how the amplitude and latency values change throughout development (i.e. if there is a significant difference in mean, etc.). Additionally, I plan on separating my analysis between the WT and KO genotypes to see if the two groups are different. For this investigation, I would like to see if amplitude and latency values are significantly different between the genotypes, and whether KO have a higher variability constant than WT.


