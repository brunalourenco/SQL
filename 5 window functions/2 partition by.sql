create schema cap06;

use cap06;

create table cap06.tb_vendas (
nome_funcionario varchar(50) not null,
ano_fiscal int not null,
valor_venda decimal(14,2) not null,
primary key(nome_funcionario, ano_fiscal)
);

INSERT INTO cap06.TB_VENDAS(nome_funcionario, ano_fiscal, valor_venda)
VALUES('Romario',2020,2000),
      ('Romario',2021,2500),
      ('Romario',2022,3000),
      ('Zico',2020,1500),
      ('Zico',2021,1000),
      ('Zico',2022,2000),
	  ('Pele',2020,2000),
      ('Pele',2021,1500),
      ('Pele',2022,2500);
      
# Total de vendas
select sum(valor_venda) as total_vendas
from cap06.tb_vendas;

# Total de vendas por ano fiscal
select ano_fiscal, sum(valor_venda) as total_vendas
from cap06.tb_vendas
group by ano_fiscal
order by ano_fiscal;

# Total de vendas por funcionário
select nome_funcionario, sum(valor_venda) as total_vendas
from cap06.tb_vendas
group by nome_funcionario
order by nome_funcionario;

# Total de vendas por funcionário e por ano
select  ano_fiscal,nome_funcionario, sum(valor_venda)
from cap06.tb_vendas
group by ano_fiscal, nome_funcionario
order by ano_fiscal;

# Total de vendas por funcionário e por ano com subtotais
select 
   ano_fiscal,
   nome_funcionario,
   sum(valor_venda) over (partition by ano_fiscal) total_vendas_ano
from cap06.tb_vendas
group by ano_fiscal, nome_funcionario 
order by ano_fiscal;

# Total de vendas por ano, por funcionario e total de vendas do funcionario
# Com o over (partition by) foi feito o somatório de todas as vendas feitas nos anos fiscais por cada funcionario
# nessa query eh possivel comparar o valor de venda por ano e o valor de venda total de todos os anos fiscais para cada funcionário
select
   ano_fiscal,
   nome_funcionario,
   valor_venda,
   sum(valor_venda) over (partition by nome_funcionario) total_vendas_func
   
from cap06.tb_vendas
order by ano_fiscal;