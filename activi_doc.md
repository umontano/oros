# VARIABLES DE AMBIENTE PARA ACTIVIDAD FISICA
El sufijo aaf_ en todas las variabe indica Ambiente (para) Actividad Fisica.

1. aaf_

## OBSERVED VARIABLES
| Nombre d Variable | Definicion | Valores |
| ----------------- | -----------| ------- |
| aaf_t_pe_class| t Tiempo de educacion fisica          | Minutos por semana |
| aaf_t_recess	| t Tiempo de recreo                    | Minutos por semana |
| aaf_population_size | Tamannho de la poblacion total de la escuela | 1 - 4 = chica, mediana, grande, muy granade |
| aaf_s_size	| s Espacio para actividades fisicas.   | 0 - 4 = no_hay, chico, mediano, grande, muy grande |
| aaf_s_avail	| s Espacio esta o no disponible        | 0, 1 |
| aaf_s_used	| s Espacio es usado o no               | 0, 1 |
| aaf_s_shape	| s Forma del espacio                   | rectang, triang, irregular, other |

## computed variables

### total aggregated class+recess time
aaf_t_sum_total

### space size population size ratio
aaf_ratio_s_pop

### product of recess-time times the space/populatioin ratio
aaf_indica_rec_t_s_p

### addition of class time plus the recess s/p indicator
aaf_indica_sum_t_s_p
