
# Ranquear dados -  com as window functions - row_number, dense_rank e rank
# cast (função sql) - converte uma coluna para o tipo que for solicitado

# Listar estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo
# para a estação de id 31000, com a coluna de data_inicio para o formato date
select estacao_inicio,
	   cast(data_inicio as date) as data_inicio,
       duracao_segundos,
       row_number() over (partition by estacao_inicio order by cast(data_inicio as date)) as numero_alugueis
from cap06.tb_bikes
where data_inicio < '2012-01-08'
and numero_estacao_inicio = 31000;

# Classificação de dados ao longo do tempo
# utilizando row_number, dense_rank e rank - para classificar/ranquear os alugueis de bike
# os alugueis foram ranqueados por estacao e data

# comparando funções
select estacao_inicio,
	    cast(data_inicio as date) as data_inicio,
        duracao_segundos,
        row_number() over (partition by estacao_inicio order by cast(data_inicio as date)) as numero_alugueis,
        dense_rank() over (partition by estacao_inicio order by cast(data_inicio as date)) as ranking_aluguel_dense_rank,
        rank () over (partition by estacao_inicio order by cast(data_inicio as date)) as ranking_aluguel_rank
from cap06.tb_bikes
where data_inicio < '2012-01-08'
and numero_estacao_inicio = 31000;