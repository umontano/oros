# VARIABLES DE AMBIENTE PARA ACTIVIDAD FISICA
El sufijo aaf_ en todas las variabe indica Ambiente (para) Actividad Fisica.

1. aaf_

## OBSERVED VARIABLES
| Nombre d Variable | Definicion |
| ----------------- | -----------|
| aaf_t_pe_class| t Tiempo educacion fisica en minutos por semana |
| aaf_t_recess	| t Tiempo de recreo en minutos por semana |
| aaf_population_size | Tamannho de la poblacion total de la escuela. Valores: 1 a 4 = chica, mediana, grande, muy granade |
| aaf_s_size	| s Espacio para actividades fisicas. Valores: 0 a 4 = no_hay, chico, mediano, grande, muy grande |
| aaf_s_avail	| s Espacio esta o no disponible |
| aaf_s_used	| s Espacio es usado o no |
| aaf_s_shape	| s Forma del espacio |

## COMPUTED VARIABLES

### TOTAL AGGREGATED CLASS+RECESS TIME
aaf_t_sum_total

### SPACE SIZE POPULATION SIZE RATIO
aaf_ratio_s_pop

### PRODUCT OF RECESS-TIME TIMES THE SPACE/POPULATIOIN RATIO
aaf_indica_rec_t_s_p

### ADDITION OF CLASS TIME PLUS THE RECESS S/P INDICATOR
aaf_indica_sum_t_s_p
