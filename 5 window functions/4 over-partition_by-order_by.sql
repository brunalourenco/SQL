# Duração total do aluguel das bikes(em horas)
select round(sum(duracao_segundos/60/60),2) as duracao_total_horas
from cap06.tb_bikes;  # resultado 94690.72

# Duração total do aluguel das bikes (em horas) ao longo do tempo (soma acumulada)
# Certifique de ordenar a coluna com tempo é muito importante, para não dar resultados equivocados
select duracao_segundos,
sum(duracao_segundos/60/60) over (order by data_inicio) as duracao_total_horas
from cap06.tb_bikes; # resultado 94690.71639198
       
# Duração total do aluguel da bikes (em horas), ao longo  do tempo, por estação de início do aluguel da bike
# quando a data de início for inferior a "2012-01-08'

select  estacao_inicio, 
		duracao_segundos,
        sum(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as data_inicio     
from cap06.tb_bikes
where data_inicio < '2012-01-08';

