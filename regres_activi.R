## LOAD REGRESSION_PLOT FUNCTIONS FOR NESTE MAPPED LA ANALYSES AND GRAPHICING
if(!exists('regression_significant_main')) source('https://raw.githubusercontent.com/umontano/regression/refs/heads/main/sig_graph.R')
## LOAD CSV DATABASE
if(!exists('o433_df')) o433_df <- read.csv('https://raw.githubusercontent.com/umontano/oros/refs/heads/main/o433.csv')
physical_activity_info_df <- read.csv('https://docs.google.com/spreadsheets/d/e/2PACX-1vT43l0HTsz_Dp2v-KDWSP74NGVrZSr-D9-_PQeS1mwzFIj99iQ9W_2cCLEMnZBP2gU3vOjB2ZEBwanA/pub?gid=301120183&single=true&output=csv', stringsAsFactors = FALSE, header = TRUE)



## INSTALL LIBRARIES IF NOT INSTALLED, AND LOAD THEM
packages <- c(
'ggplot2',
'gridExtra',
'ggthemes',
'tidytext',
'dplyr',
'tibble',
'ggbeeswarm'
)
lapply(packages, \(x) if (!require(x, character.only = TRUE)) { install.packages(x)
	library(x, character.only = TRUE) }) |> invisible()

## COMPUTE REMAINING (THE NON-GROUPPING) NAMES VECTORS
nm <- names(o433_df)
varnames_groupping <- grep('Edad|Grado|Sexo|Col|locatio|Nacional', nm, value = TRUE)
varnames_num_no_age_no_grade_predictors <- '^[^C].*otal|Grit|erfe' |> grep(nm, value = TRUE)
## THIS NAMES SET INCORPORATES AGE AND SCHOOL-GRADE
varnames_num_predictors <- 'Edad|Grado|^[^C].*otal|Grit|erfe' |> grep(nm, value = TRUE)
vn_pred_no_orostotal <- 'CI_|PE_|^[^Pt].*otal|Grit|erfe' |> grep(nm, value = TRUE)
varnames_iq <- grep('CI', nm, value = TRUE)
varnames_iqgroups <- c('iq_g_128', 'iq_g_115', 'iq_g_median')
varnames_oros_items <- grep('^P\\w+\\d+$', nm, value = TRUE, perl = TRUE)
joint_nums <- c(varnames_iq, varnames_num_no_age_no_grade_predictors)
joint_cats <- c(varnames_groupping, varnames_iqgroups)

## MAKE THE GROUPPING VARIABLES FACTOR
ofactored_df <- o433_df['Codigo|X|Promedio' |> grep(names(o433_df), value=T) |> base::setdiff(names(o433_df), y=_)]
lapply(joint_cats, \(each_gv) ofactored_df[[each_gv]] <<- as.factor(o433_df[[each_gv]])) |> invisible()


#######################################################################################
######################################################################################
## PIDAHI PARAMETERS
pidahi_secondary_percentage <- 0.90
pidahi_pe_workshop_percentage <- 0.30
pidahi_t_pe_class_sum_total <- 100*pidahi_secondary_percentage + 120*(1-pidahi_secondary_percentage) + 90*pidahi_pe_workshop_percentage

#       #       #       #       #       #       #       #       #       #       #       #       #       #       #       #       
## LOAD ACTIVITY LOOKUP TABLE INFORMATION
#physical_activity_info_df <- read.csv(text =
dommycsvtext <- "
school_name, aaf_t_pe_class, aaf_t_recess, aaf_population_size, aaf_s_size
bicentenario,
esperanza,
coltec,
andes,
chia,
villavicencio,
secaugusto,	100,		200,		2,		4
secguadala,	100,		150,		2,		3
pidahi,		129,		150,		1,		1
primcongreso,	120,		150,		3,		2
"
#, header = TRUE, stringsAsFactors = FALSE, sep = ',')
#       #       #       #       #       #       #       #       #       #       #       #       #       #       #       #       

## COMPLETE THE ACRIVITY LOOKUP TABLE
index_df <- data.frame(school_num = factor(1:10))
physical_activity_info_df <- cbind(index_df, physical_activity_info_df)
## TOTAL AGGREGATED CLASS+RECESS TIME
physical_activity_info_df <-
	physical_activity_info_df |>
	within({
	aaf_t_sum_total <- aaf_t_pe_class + aaf_t_recess
	aaf_ratio_s_pop <- signif(aaf_s_size / aaf_population_size, digits = 1)
	aaf_indica_rec_t_s_p <- floor(aaf_ratio_s_pop * aaf_t_recess)
	aaf_indica_sum_t_s_p <- floor(aaf_ratio_s_pop * aaf_t_sum_total) })

## MATCH COLEGIO COLUMN IN SCHOO_NUM COLUMN
lookup_table_info_col <- physical_activity_info_df[['school_num']]
findee_col <- o433_df[['Colegio']]
matched_id_col <- match(findee_col, lookup_table_info_col)

## JOINT TO MAKE FINAL ACTIVITY DATASET
oactivity_df <- physical_activity_info_df[matched_id_col, ]
oactivity_df <- cbind(ofactored_df, oactivity_df)
oactivity_df <- oactivity_df[!is.na(oactivity_df[['aaf_indica_sum_t_s_p']]), ]

## EXTRAC ANTIVITY NAMES
nm <-names(oactivity_df)
varnames_activity <- '^aaf_' |> grep(nm, value = TRUE)


## ACTIVITY REGRESSION ANALYSES
res_activity_corr <- regression_significant_main(oactivity_df, joint_nums, varnames_activity, significance_threshold = 0.05, r_min_threshold = 0.07, make_graphics = TRUE, opacity = 0.9, save_graph_to = 'o433activiy_corr.pdf', scatter_cats = FALSE)

## FORCE ACTIVITY VARIABLES INTO FACTORS
oactivity_factored_df <- oactivity_df
lapply(varnames_activity, \(each_gv) oactivity_factored_df[[each_gv]] <<- as.factor(oactivity_df[[each_gv]])) |> invisible()

## ACTIVITY SAME ANALYSIS AS ABOVE BUT THE ACTIVITIES ARE TAKEN AS CATEFORIES FOR  DIFFERENCE ANALYSES
res_activity_diff <- regression_significant_main(oactivity_factored_df, joint_nums, varnames_activity, significance_threshold = 0.041, r_min_threshold = 0, make_graphics = TRUE, opacity = 0.7, save_graph_to = 'o433activiy_diff.pdf', scatter_cats = FALSE)
## RENAME THE CATEGORICAL ACTIVITY GRID OF PLOT FOR EASY REFERENCE LATER
actdiffgrid <- res_activity_diff[['grid']]
actdiffsiglength <- length(res_activity_diff[['plots']])
