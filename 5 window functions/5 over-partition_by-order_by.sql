# Qual a média de tempo (em horas) de aluguel de bike da estação de início 31017?
# usa agrupamento por coluna por isso pode-se usar o group by
select estacao_inicio,
	avg(duracao_segundos/60/60) as media_tempo_aluguel
from cap06.tb_bikes
where numero_estacao_inicio = 31017
group by estacao_inicio;

# Qual a média de tempo(em horas) de aluguel da estação de início 31017, ao longo do tempo (média móvel)?
# nesse caso o agrupamento é por linha - usa-se o over
select estacao_inicio,
avg(duracao_segundos/60/60) 
over (partition by estacao_inicio order by data_inicio) as media_tempo_aluguel
from cap06.tb_bikes
where numero_estacao_inicio = 31017;

# Exercicio - retornar
# 1- Estação de início, data de inicio e duração de cada aluguel de bike em segundos.
# 2- Duração total de aluguel das bikes ao longo do tempo por estação de início
# 3- Duração média do aluguel de bikes ao longo do tempo por estacao de início
# 4- Número de alugueis de bikes por estação ao longo do tempo
# 5- Somente os registros quando a data de início for inferior a '2012-01-08'

# Resposta 
select estacao_inicio,
	   data_inicio,
       duracao_segundos,
       sum(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as duracao_total_aluguel,
       avg(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as media_tempo_aluguel,
       count(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as numero_alugueis
from cap06.tb_bikes
where data_inicio < '2012-01-08';

# Retornar - exercício 2
# 1- Estação de início, data de início de cada aluguel de bike e duração de cada aluguel em segundos
# 2- Número de aluguéis de bikes (independente da estação) ao longo do tempo
# 3 - Somente os registros quando a data de início for inferior a '2022-01-08'

# Resposta 1
select
    estacao_inicio,
    data_inicio,
    duracao_segundos,
    count(duracao_segundos/60/60) over (order by data_inicio) as numero_alugueis
from cap06.tb_bikes
where data_inicio < '2022-01-08';

# Resposta 2
# row_number - window function que lista o número de linhas
select 
	  estacao_inicio,
      data_inicio,
      duracao_segundos,
      row_number() over (order by data_inicio) as numero_alugueis
from cap06.tb_bikes
where data_inicio < '2022-01-08';
   
# O mesmo resultado anterior, mas a contagem por estação
select 
	  estacao_inicio,
      data_inicio,
      duracao_segundos,
      row_number() over (partition by estacao_inicio order by data_inicio) as numero_alugueis
from cap06.tb_bikes
where data_inicio < '2022-01-08';

        