# VARIABLES DE AMBIENTE PARA ACTIVIDAD FISICA
1. aaf_

## OBSERVED VARIABLES
| Nombre d Variable | Definicion |
| ----------------- | -----------|
| aaf_t_pe_class| t tiempo educacion fisica en minutos por semana |
| aaf_t_recess	| t tiempo de recreo en minutos por semana |
| aaf_population_size | tamannho de la poblacion total de la escuela en 1 a 4 chicam median grande muy granade |
| aaf_s_size	| s espacio para actividades fisicas, en 0 a 4, no hay chico mediano grande muy grande |
| aaf_s_avail	| s espacio esta o no disponibel |
| aaf_s_used	| s espacio es usado o no |
| aaf_s_shape	| s forma del espacio |

## COMPUTED VARIABLES

### TOTAL AGGREGATED CLASS+RECESS TIME
aaf_t_sum_total

### SPACE SIZE POPULATION SIZE RATIO
aaf_ratio_s_pop

### PRODUCT OF RECESS-TIME TIMES THE SPACE/POPULATIOIN RATIO
aaf_indica_rec_t_s_p

### ADDITION OF CLASS TIME PLUS THE RECESS S/P INDICATOR
aaf_indica_sum_t_s_p
