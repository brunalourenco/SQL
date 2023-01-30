# Cria tabela
CREATE TABLE `cap05`.`TB_VENDAS` (
  `ano` INT NULL,
  `pais` VARCHAR(45) NULL,
  `produto` VARCHAR(45) NULL,
  `faturamento` INT NULL);


# Insere registros
INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Brasil', 'Geladeira', 1130);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Brasil', 'TV', 980);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Argentina', 'Geladeira', 2180);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Argentina', 'TV', 2240);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Portugal', 'Smartphone', 2310);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Portugal', 'TV', 1900);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Inglaterra', 'Notebook', 1800);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Brasil', 'Geladeira', 1400);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Brasil', 'TV', 1345);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Argentina', 'Geladeira', 2180);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Argentina', 'TV', 1390);

# Listar vendas
select * 
from cap05.tb_vendas;



INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Portugal', 'Smartphone', 2480);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Portugal', 'TV', 1980);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Inglaterra', 'Notebook', 2300);


# Lista os dados
SELECT * FROM cap05.TB_VENDAS;

# Faturamento total por ano
select ano, sum(faturamento) as faturamento
from cap05.tb_vendas
group by ano;

# Rollup - expande a hierarquia do group by, é usado para calcular subtotais
# Faturamento total por ano e faturamento total
select ano, sum(faturamento) as faturamento
from cap05.tb_vendas
group by ano with rollup
order by ano;

# Faturamento por ano e país  total geral
select ano,pais, sum(faturamento) as faturamento
from cap05.tb_vendas
group by ano, pais with rollup;

# Faturamento total por ano e produto a total geral, ordenado pelo agrupamento de produto
select ano, produto, sum(faturamento) as faturamento
from cap05.tb_vendas
group by ano, produto with rollup
order by grouping (produto) desc;

# Por que não podemos usar o case na query acima, para tirar os valores nulos?
# Porque esses valores não existem no banco de dados, eles vem do resultado de outras queries.

# Grouping sets - conjuntos de agrupamentos - através de hierarquia de dados
# Faturamento total por ano  país e total geral com agrupamento do resultado
select 
   if(grouping(ano), 'Total de Todos os Anos', ano) as ano, 
   if(grouping(pais), 'Total de Todos os Países', pais) as pais,
   if(grouping(produto), 'Total de Todos os Produtos', produto) as produto,
	 sum(faturamento) as faturamento
from cap05.tb_vendas
group by ano, pais, produto with rollup;     

