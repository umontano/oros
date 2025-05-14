## REQUIRE REGRESSION_PLOT FUNCTIONS FOR NESTE MAPPED LA ANALYSES AND GRAPHICING
#source('regression_plot.R')
if(!exists('regression_significant_main')) source('https://raw.githubusercontent.com/umontano/regression/refs/heads/main/sig_graph.R')

## LOAD CSV DATABASE
if(!exists('o433_df')) o433_df <- read.csv('https://raw.githubusercontent.com/umontano/oros/refs/heads/main/o433.csv')[-1]

## COMPUTE NAMES VECTOR
varnames_pred          <- grep('^[^C].*otal|Grit|erfe|^(PA\\d|PSP\\d|POO\\d)' , names(o433_df), value = TRUE)
varnames_pred_no_items <- grep('^[^C].*otal|Grit|erfe', names(o433_df), value = TRUE)
varnames_iq <- grep('CI', names(o433_df), value = TRUE)
varnames_orositems <- grep('^P\\w+\\d+$', names(o433_df), value = TRUE, perl = TRUE)

varnames_groupping <- grep('Sexo|iq_|Col|locatio|Nacional', names(o433_df), value = TRUE)

rm(orecoded_df, joint_nums)
## MAKE THE GROUPPING VARIABLES FACTOR
joint_nums <- c(varnames_iq, varnames_pred)
orecoded_df <- o433_df
lapply(varnames_groupping, \(each_gv) orecoded_df[[each_gv]] <<- as.factor(o433_df[[each_gv]]))


# TRUE# COMPUTE MULTIPLE LINEAR MODELS
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, c('CI_._Factor.g.R', 'CI_Total'), varnames_pall, significance_threshold = 0.05, r_min_threshold = 0.058)
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, varnames_totals, varnames_pall, significance_threshold = 0.01, r_min_threshold = 0.558)
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, varnames_iq, varnames_totals, significance_threshold = 0.05, r_min_threshold = 0.058)
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, varnames_iq, varnames_totals, significance_threshold = 0.05, r_min_threshold = 0.058)
#pvalues_matrix <- mapped_analyze_multiple_nested_significat_lm(o433_df, names(o433_df), names(o433_df), significance_threshold = 0.05, r_min_threshold = 0.358)


## TESTING SCATTER PLOTS OF CATEGORICAL GROUPPING VARIABLES VERSUS ONLY ITEMS
res_cats_items <- regression_significant_main(orecoded_df, varnames_orositems, varnames_groupping, significance_threshold = 0.05, r_min_threshold = 0.02, make_graphics = TRUE, transparency = 0.3, save_graph_to = 'zgroup_items_scatter_o433.pdf', scatter_cats = TRUE)

## NUMERIC VARIABLES VS IQ 
res_numericals <- regression_significant_main(o433_df, varnames_iq, varnames_pred, significance_threshold = 0.05, r_min_threshold = 0.05, make_graphics = TRUE, transparency = 0.4, save_graph_to = 'z2corrs_o433.pdf', scatter_cats = FALSE)

## DIFFERENCES BY IQ 128 GROUP
main_results <- regression_significant_main(orecoded_df, joint_nums, c('iq_g_128'), significance_threshold = 0.05, r_min_threshold = 0.001, make_graphics = T, transparency = 0.5, save_graph_to = 'ziq128_o433.pdf', scatter_cats = FALSE)
main_results$significants |> length() |> print()

## ANALYSIS by SEX AND NATIONALITY ONLY
main_results <- regression_significant_main(orecoded_df, joint_nums, c('Sexo.', 'Nacionalidad'), significance_threshold = 0.05, r_min_threshold = 0.005, make_graphics = T, transparency = 0.5, save_graph_to = 'zsex_nac_o433.pdf', scatter_cats = FALSE)

## DIFFERENCES IN NUMERIC VARIABLES BY ALL GROUPPING VARIABLES WITH R GREATER THAT 0.025
main_results <- regression_significant_main(orecoded_df, joint_nums, varnames_groupping, significance_threshold = 0.05, r_min_threshold = 0.025, make_graphics = TRUE, transparency = 0.5, save_graph_to = 'z025_diffs_o433.pdf', scatter_cats = FALSE)

main_results$significants |> length() |> print()

#main_results$sig$pvalues |> print()
main_results$pvalues |> print()
#main_results$sig$significants |> names() |> print()
main_results$significants |> names() |> print()
#ressigs <- main_results[['sig']][['significants']]
ressigs <- main_results[['significants']]
ressigs |> names() |> print()

#significant_analyses_list |> names() |> print()

significant_analyses_list[[1]]['(Intercept)']
significant_analyses_list[[1]]['slope']
#pvalues_matrix <- main_results[['sig']][['pvalues']]
pvalues_matrix <- main_results[['pvalues']]
pvalues_matrix[!sapply(pvalues_matrix, is.null)]
