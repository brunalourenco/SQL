# Extraindo itens específicos da data
select data_inicio,
       date(data_inicio),
       timestamp(data_inicio),
       year(data_inicio),
       month(data_inicio),
       day(data_inicio)
from cap06.tb_bikes
where numero_estacao_inicio = 31000;

# Extraindo o mês da data
select 
      extract(month from data_inicio) as mes,
      month(data_inicio),
      duracao_segundos
from cap06.tb_bikes
where numero_estacao_inicio = 31000;

# Adicionando 10 dias à data início
select data_inicio,
       date_add(data_inicio, interval 10 day) as data_inicio,
       duracao_segundos
from cap06.tb_bikes
where numero_estacao_inicio = 31000;

# Retornando dados de 10 dias anteriores à data de início do aluguel da bike
select data_inicio, duracao_segundos
from cap06.tb_bikes
where date_sub("2012-03-31", interval 10 day)  <= data_inicio
and numero_estacao_inicio = 31000;

# Diferença entre data_inicio e data_fim
select date_format(data_inicio, "%H") as hora_inicio,
		date_format(data_fim,"%H") as hora_fim,
		(date_format(data_fim, "%H")- date_format(data_inicio, "%H")) as diff
from cap06.tb_bikes
where numero_estacao_inicio = 31000;