#read.csv('https://raw.githubusercontent.com/umontano/oros/refs/heads/main/o433.csv')[-c(1:3)] |> names() |> head()

## LOAD REGRESSION_PLOT FUNCTIONS FOR NESTE MAPPED LA ANALYSES AND GRAPHICING
if(!exists('regression_significant_main')) source('https://raw.githubusercontent.com/umontano/regression/refs/heads/main/sig_graph.R')
## LOAD CSV DATABASE
if(!exists('o433_df')) o433_df <- read.csv('https://raw.githubusercontent.com/umontano/oros/refs/heads/main/o433.csv')

## COMPUTE REMAININ (THE NON-GROUPPING) NAMES VECTORS
nm <- names(o433_df)
varnames_groupping <- grep('Edad|Grado|Sexo|Col|locatio|Nacional', nm, value = TRUE)
varnames_num_no_age_no_grade_predictors <- '^[^C].*otal|Grit|erfe' |> grep(nm, value = TRUE)
## THIS NAMES SET INCORPORATES AGE AND SCHOOL-GRADE
varnames_num_predictors <- 'Edad|Grado|^[^C].*otal|Grit|erfe' |> grep(nm, value = TRUE)
vn_pred_no_orostotal <- 'CI_|PE_|^[^Pt].*otal|Grit|erfe' |> grep(nm, value = TRUE)
varnames_iq <- grep('CI', nm, value = TRUE)
varnames_oros_items <- grep('^P\\w+\\d+$', nm, value = TRUE, perl = TRUE)
joint_nums <- c(varnames_iq, varnames_num_no_age_no_grade_predictors)

## MAKE THE GROUPPING VARIABLES FACTOR
ofactored_df <- o433_df['Codigo|X|Promedio' |> grep(names(o433_df), value=T) |> base::setdiff(names(o433_df), y=_)]
lapply(varnames_groupping, \(each_gv) ofactored_df[[each_gv]] <<- as.factor(o433_df[[each_gv]]))



######################################################################################
######################################################################################
######################################################################################
# IQ ANALYSES
## CORRELATION NUMERIC VARIABLES VS IQ 
res_iq_corr <- regression_significant_main(o433_df, varnames_iq, varnames_num_predictors, significance_threshold = 0.05, r_min_threshold = 0.05, make_graphics = TRUE, opacity = 0.4, save_graph_to = 'o433iq_corrs.pdf', scatter_cats = FALSE)

## DIFFERENCES BY IQ 128 GROUP.
#NOTE: 14 DIFFERENCES FOUND.
res_iq_diff <- regression_significant_main(o433_df, joint_nums, c('iq_g_128', 'iq_g_115', 'iq_g_median'), significance_threshold = 0.05, r_min_threshold = 0, make_graphics = TRUE, opacity = 0.4, save_graph_to = 'o433iq_diff.pdf', scatter_cats = FALSE)

## ANALYSIS by SEX AND NATIONALITY ONLY
main_results <- regression_significant_main(ofactored_df, joint_nums, c('Sexo.', 'Nacionalidad'), significance_threshold = 0.05, r_min_threshold = 0, make_graphics = TRUE, opacity = 0.5, save_graph_to = 'o433sex_nac_diff.pdf', scatter_cats = FALSE)

## DIFFERENCES IN NUMERIC VARIABLES BY ALL GROUPPING VARIABLES WITH R GREATER THAT 0.025
#NOTE: 35 DIFFERENCES FOUND.
main_results <- regression_significant_main(ofactored_df, joint_nums, varnames_groupping, significance_threshold = 0.05, r_min_threshold = 0, make_graphics = TRUE, opacity = 0.5, save_graph_to = 'o433group0_diff.pdf', scatter_cats = FALSE)

# CORRELATIONS OF NUMERICAL VARIABLE INCLUDING AGE, GRADE AND PARTIAL-TOTALS
res_corr <- regression_significant_main(o433_df, varnames_num_predictors, varnames_num_predictors, significance_threshold = 0.05, r_min_threshold = 0.5, make_graphics = TRUE, opacity = 0.4, save_graph_to = 'o433corr_totals.pdf', scatter_cats = FALSE)

#################################################################
#################################################################
# ITEM ANALYSES.
## ITEM GROUP DIFFERENCES.
## ITEM CORRELATION TO NUMERIC VARIABLES, WITH R SQUARED GREATER THAN POINT FIFTEEN. 
#(note: 16 significant analysis, however at lower r there are up to 50)
res_items_num <- regression_significant_main(ofactored_df, vn_pred_no_orostotal, varnames_oros_items, significance_threshold = 0.05, r_min_threshold = 0.15, make_graphics = TRUE, opacity = 0.3, save_graph_to = 'o433items_corr.pdf', scatter_cats = FALSE)

### TESTING SCATTER PLOTS OF CATEGORICAL GROUPPING VARIABLES VERSUS ONLY ITEMS
#NOTE: 36 DIFFERENCES FOUND
res_items_cat <- regression_significant_main(ofactored_df, varnames_oros_items, varnames_groupping, significance_threshold = 0.05, r_min_threshold = 0, make_graphics = TRUE, opacity = 0.1, save_graph_to = 'o433items_diff.pdf', scatter_cats = TRUE)

########################################################################################
########################################################################################
########################################################################################
#INSTRUCTIONS: TO EXTRAC ANANLYSES NAMES AND NUMBER:
main_results$significants |> names()
main_results$significants |> length()

##INSTRUCTIONS TO GET THE REGRESSION LINE PARAMETERS:
significant_analyses_list[[1]]['(Intercept)']
significant_analyses_list[[1]]['slope']

# TRUE# COMPUTE MULTIPLE LINEAR MODELS
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, c('CI_._Factor.g.R', 'CI_Total'), varnames_pall, significance_threshold = 0.05, r_min_threshold = 0.058)
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, varnames_totals, varnames_pall, significance_threshold = 0.01, r_min_threshold = 0.558)
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, varnames_iq, varnames_totals, significance_threshold = 0.05, r_min_threshold = 0.058)
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, varnames_iq, varnames_totals, significance_threshold = 0.05, r_min_threshold = 0.058)
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, names(o433_df), names(o433_df), significance_threshold = 0.05, r_min_threshold = 0.358)
