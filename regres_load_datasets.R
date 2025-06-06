## LOAD THE ORIGINAL WHOLE GRIT EMPF 1292 OBSERVATIONS DATASET
tenaci_whole1292_df <- read.csv('~/p/hub/Altas-Capacidades/tenacidad_mexicocolombia.csv', header = TRUE, stringsAsFactors = FALSE)

## LOAD REGRESSION_PLOT FUNCTIONS FOR NESTE MAPPED LA ANALYSES AND GRAPHICING
if(!exists('regression_significant_main')) source('https://raw.githubusercontent.com/umontano/regression/refs/heads/main/sig_graph.R')
## LOAD CSV DATABASE
if(!exists('o433_df')) o433_df <- read.csv('https://raw.githubusercontent.com/umontano/oros/refs/heads/main/o433.csv')

## LOAD ACTIVITY LOOKUP TABLE INFORMATION
## LOAD PUBLISHED FROM GOOGLESHEETS ACTIVI
physical_activity_info_df <- read.csv('https://docs.google.com/spreadsheets/d/e/2PACX-1vT43l0HTsz_Dp2v-KDWSP74NGVrZSr-D9-_PQeS1mwzFIj99iQ9W_2cCLEMnZBP2gU3vOjB2ZEBwanA/pub?gid=301120183&single=true&output=csv', stringsAsFactors = FALSE, header = TRUE)
## COMPLETE THE ACRIVITY LOOKUP TABLE
physical_activity_info_df <- cbind(school_num = 1:10 , physical_activity_info_df)
## COMPUTE AGGREGATED VARIABLES
physical_activity_info_df <-
	physical_activity_info_df |>
	within({
	aaf_t_sum_total <- aaf_t_pe_class + aaf_t_recess
	aaf_ratio_s_pop <- signif(aaf_s_size / aaf_population_size, digits = 1)
	aaf_indica_rec_t_s_p <- floor(aaf_ratio_s_pop * aaf_t_recess)
	aaf_indica_sum_t_s_p <- floor(aaf_ratio_s_pop * aaf_t_sum_total) })
