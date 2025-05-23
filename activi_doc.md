# VARIABLES DE AMBIENTE PARA ACTIVIDAD FISICA
El sufijo aaf_ en todas las variabe indica Ambiente (para) Actividad Fisica.

1. aaf_

## OBSERVED VARIABLES
| Nombre d Variable | Definicion | Valores |
| ----------------- | -----------| ------- |
| aaf_t_pe_class| t Tiempo de educacion fisica          | Minutos por semana |
| aaf_t_recess	| t Tiempo de recreo                    | Minutos por semana |
| aaf_population_size | Tamannho de la poblacion total de la escuela | 1 - 4 = chica, mediana, grande, muy_gr |
| aaf_s_size	| s Espacio para actividades fisicas.   | 0 - 4 = no_hay, chico, mediano, grande, muy_gr|
| aaf_s_avail	| s Espacio esta o no disponible        | 0, 1 |
| aaf_s_used	| s Espacio es usado o no               | 0, 1 |
| aaf_s_shape	| s Forma del espacio                   | rectang, triang, irregular, other |

## COMPUTED VARIABLES
| Computed Variable | Definition | Formula |
| ----------------- | -----------| ------- |
| aaf_t_sum_total | total aggregated class+recess time  | t_sum = t_class + t_recess    |
| aaf_ratio_s_pop | space-size population-size ratio    | ratio_sp = s_size / pop_size     |
| aaf_indica_rec_t_s_p | time_space/population Indicator: Product of recess-time times the space/population ratio   | indica_tsp = t_recesss * ratio_sp          |
| aaf_indica_sum_t_s_p | total time_space/population Indicator: Product of aggregated time (class+recess) times the space/population ratio   | indica_sum_tsp = t_sum * ratio_sp  |
