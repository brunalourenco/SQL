# Número de vendas por ano, por funcionario e número total de vendas em todos os anos
# utilzando funcao window over
# funcao window é usada para cálculos com série temporais(valores que variam de acordo com o tempo)
select
   ano_fiscal,
   nome_funcionario,
   count(*) num_vendas_ano,
   count(*) over () num_vendas_geral
from cap06.tb_vendas
group by ano_fiscal, nome_funcionario;

# Reescrevendo a query anterior com subquery
# Número de vendas por ano, por funcionário e número total de vendas em todos os anos
# Pode substituir o uso da funcao window, porém perde em performace
select
   ano_fiscal, 
   nome_funcionario,
   count(*) num_vendas_ano,
   (select count(*) from cap06.tb_vendas) as num_vendas_geral
from cap06.tb_vendas
group by ano_fiscal, nome_funcionario
order by ano_fiscal;



 
 
 
 
 