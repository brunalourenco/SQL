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


