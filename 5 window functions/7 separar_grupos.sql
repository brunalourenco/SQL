# NTILE - função window que distribui linhas de uma partição ordenada em um número predefinido 
# de grupos aproximadamente iguais. Atribui a cada grupo um número a partir de 1
# agrupada dados de partições

# Grupos ordenados pelo tempo
select estacao_inicio,
       duracao_segundos,
       row_number() over (partition by estacao_inicio order by duracao_segundos) as numero_alugueis,
       ntile(2) over (partition by estacao_inicio order by duracao_segundos) as numero_grupo_dois,
       ntile(4) over(partition by estacao_inicio order by duracao_segundos) as numero_grupo_quatro,
       ntile(5) over (partition by estacao_inicio order by duracao_segundos) as numero_grupo_cinco
from cap06.tb_bikes
where data_inicio < '2012-01-08'
and numero_estacao_inicio = '31000'; 

# Grupos ordenados pela data
select estacao_inicio,
	   cast(data_inicio as date) data_inicio,
       duracao_segundos,
       row_number() over (partition by estacao_inicio order by cast(data_inicio as date)) as numero_alugueis,
       ntile(1) over (partition by estacao_inicio order by cast(data_inicio as date)) as numero_grupo_um,
       ntile(7) over(partition by estacao_inicio order by cast(data_inicio as date)) as numero_grupo_sete,
       ntile(16) over (partition by estacao_inicio order by cast(data_inicio as date)) as numero_grupo_dezesseis
from cap06.tb_bikes
where data_inicio < '2012-01-08'
and numero_estacao_inicio = '31000'; 

# LAG e LEAD - funções window para mover dados lag para frente e lead para trás, de acordo com a qtde solicitada dentro da tag
# são interessantes para cálculos com séries temporais
select estacao_inicio,
       cast(data_inicio as date) as data_inicio,
       duracao_segundos,
       lag(duracao_segundos,1) over (partition by estacao_inicio order by cast(data_inicio as date)) as registro_lag,
       lead(duracao_segundos,1) over (partition by estacao_inicio order by cast(data_inicio as date)) as registro_lead
from cap06.tb_bikes
where data_inicio <'2012-01-08'
and numero_estacao_inicio ='31000';

# Qual a diferença da duração do aluguel de bikes ao longo do tempo, de um registro para o outro?
select estacao_inicio,
       cast(data_inicio as date) as data_inicio,
       duracao_segundos,
       duracao_segundos - lag (duracao_segundos,1) over (partition by estacao_inicio order by cast(data_inicio as date)) as diferenca
from cap06.tb_bikes
where data_inicio <'2012-01-08'
and numero_estacao_inicio ='31000'
and diferenca is not null;  # não funciona por diferenca é apenas resultado de query e não é uma coluna

# Qual a diferença da duração do aluguel de bikes ao longo do tempo, de um registro para o outro?
# lag com subquery
select *
from (
      select estacao_inicio,
             cast(data_inicio as date) as data_inicio,
             duracao_segundos,
             duracao_segundos - lag (duracao_segundos,1) over (partition by estacao_inicio order by cast(data_inicio as date)) as diferenca
      from cap06.tb_bikes
      where data_inicio <'2012-01-08'
	and numero_estacao_inicio ='31000') resultado
where resultado.diferenca is not null;

# Alias função windows 
# partição dentro de partição
select estacao_inicio,
       duracao_segundos,
       row_number() over (partition by estacao_inicio order by duracao_segundos) as numero_alugueis,
       ntile(2) over (partition by estacao_inicio order by duracao_segundos) as numero_grupo_dois,
       ntile(4) over(partition by estacao_inicio order by duracao_segundos) as numero_grupo_quatro,
       ntile(5) over (partition by estacao_inicio order by duracao_segundos) as numero_grupo_cinco
from cap06.tb_bikes
where data_inicio < '2012-01-08'
window ntile_window as (partition by estacao_inicio order by cast(data_inicio as date))
order by estacao_inicio;
       



      


