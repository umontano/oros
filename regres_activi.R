## LOAD REGRESSION_PLOT FUNCTIONS FOR NESTE MAPPED LA ANALYSES AND GRAPHICING
if(!exists('regression_significant_main')) source('https://raw.githubusercontent.com/umontano/regression/refs/heads/main/sig_graph.R')
## LOAD CSV DATABASE
if(!exists('o433_df')) o433_df <- read.csv('https://raw.githubusercontent.com/umontano/oros/refs/heads/main/o433.csv')

## INSTALL LIBRARIES IF NOT INSTALLED, AND LOAD THEM
packages <- c(
'ggplot2',
'gridExtra',
'ggthemes',
'tidytext',
'dplyr',
'tibble'
)
lapply(packages, \(x) if (!require(x, character.only = TRUE)) { install.packages(x)
	library(x, character.only = TRUE) })

## COMPUTE REMAININ (THE NON-GROUPPING) NAMES VECTORS
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
lapply(joint_cats, \(each_gv) ofactored_df[[each_gv]] <<- as.factor(o433_df[[each_gv]]))

#######################################################################################
######################################################################################
######################################################################################

## TABLE FOR LOOJING GRADE  IN MEXICAN SCHOOLS
o433_df |> subset(Nacionalidad == 2, select = c('Grado_Escolar', 'Colegio')) |> table()

## TABLE FOR PIDAHI SECONDARY RATIO
o433_df |> subset(Nacionalidad == 2 & Colegio == 9, select = c('Grado_Escolar')) |> table()

## TABLE Ciudad_residencia guadalajara
## NOTE 8 IS SECONDARY GUADALAJARA
o433_df |> subset(Ciudad_Residencia == 6 & Nacionalidad == 2, select = c('Grado_Escolar', 'Sexo.', 'Colegio')) |> table()

#################################################
#################################################
rm(pidahi_t_pe_class_sum_total)
pidahi_secondary_percentage <- 0.90
pidahi_pe_workshop_percentage <- 0.30
pidahi_t_pe_class_sum_total <- 100*pidahi_secondary_percentage + 120*(1-pidahi_secondary_percentage) + 90*pidahi_pe_workshop_percentage
rm(lookup_table_info_col, index_df, findee_col, physical_activity_info)
#       #       #       #       #       #       #       #       #       #       #       #       #       #       #       #       
physical_activity_info <- read.csv(text = "
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
#       #       #       #       #       #       #       #       #       #       #       #       #       #       #       #       
, header = TRUE, stringsAsFactors = TRUE, sep = ',')
index_df <- data.frame(school_num = factor(1:10))
physical_activity_info <- cbind(index_df, physical_activity_info)
## TOTAL AGGREGATED CLASS+RECESS TIME
physical_activity_info <- physical_activity_info |> within({
	aaf_t_sum_total <- aaf_t_pe_class + aaf_t_recess
	aaf_ratio_s_pop <- aaf_s_size / aaf_population_size
	aaf_indica_rec_t_s_p <- aaf_ratio_s_pop * aaf_t_recess
	aaf_indica_sum_t_s_p <- aaf_ratio_s_pop * aaf_t_sum_total})
tail(physical_activity_info)
lookup_table_info_col <- physical_activity_info[['school_num']]
findee_col <- o433_df[['Colegio']]
matched_id_col <- match(findee_col, lookup_table_info_col)
physical_activity_info[matched_id_col, ] |> tail(33)
oactivity_df <- physical_activity_info[matched_id_col, ]
oactivity_df <- cbind(ofactored_df, oactivity_df)

oactivity_df <- oactivity_df[!is.na(oactivity_df[['aaf_indica_sum_t_s_p']]), ]

## EXTRAC ANTIVITY NAMES
nm <-names(oactivity_df)
varnames_activity <- '^aaf_' |> grep(nm, value = TRUE)

## ACTIVITY VARIABLE REGRESSION ANALYUSES
res_activity <- regression_significant_main(oactivity_df, joint_nums, varnames_activity, significance_threshold = 0.05, r_min_threshold = 0.04, make_graphics = TRUE, opacity = 0.5, save_graph_to = 'o433activiy_corr.pdf', scatter_cats = FALSE)


## force activity variables into factors
oactivity_factored_df <- oactivity_df
lapply(varnames_activity, \(each_gv) oactivity_factored_df[[each_gv]] <<- as.factor(oactivity_df[[each_gv]]))
## ACTIVITY SAME ANALYSIS AS ABOVE BUT THE ACTIVITIES ARE TAKEN AS CATEFORIES FOR  DIFFERENCE ANALYSES. THERER WE 22 SIGNIFICANTS.
res_activity <- regression_significant_main(oactivity_factored_df, joint_nums, varnames_activity, significance_threshold = 0.01, r_min_threshold = 0, make_graphics = TRUE, opacity = 0.5, save_graph_to = 'o433activiy_diff.pdf', scatter_cats = FALSE)

 
# variables de
# ambiente para actividad fisica
# aaf_

# ## OBSERVED VARIABLES
# aaf_t_pe_class| t tiempo educacion fisica en minutos por semana
# aaf_t_recess	| t tiempo de recreo en minutos por semana
# aaf_population_size | tamannho de la poblacion total de la escuela en 1 a 4 chicam median grande muy granade
# aaf_s_size	| s espacio para actividades fisicas, en 0 a 4, no hay chico mediano grande muy grande
# aaf_s_avail	| s espacio esta o no disponibel
# aaf_s_used	| s espacio es usado o no
# aaf_s_shape	| s forma del espacio
# 
# ## COMPUTED VARIABLES
# ## TOTAL AGGREGATED CLASS+RECESS TIME
# aaf_t_sum_total
#
# ## SPACE SIZE POPULATION SIZE RATIO
# aaf_ratio_s_pop
# 
# ## PRODUCT OF RECESS-TIME TIMES THE SPACE/POPULATIOIN RATIO
# aaf_indica_rec_t_s_p
# ## ADDITION OF CLASS TIME PLUS THE RECESS S/P INDICATOR
# aaf_indica_sum_t_s_p
