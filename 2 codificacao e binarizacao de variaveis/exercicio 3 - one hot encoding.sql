 
 #[Desafio] Aplique One-Hot-Encoding a coluna deg_malig
 # Com essa tecnica podemos transformar variaveis categoricas em variaveis binarias
 
select distinct deg_malig from cap03.tb_dados4;

# cria dataset com os dados alterados
create table cap03.tb_dados5
as 
select
classe,
idade,
menopausa,
tamanho_tumor,
posicao_tumor,
node_caps,
case when deg_malig = 1 then 1 else 0 end as deg_malig_cat1,
case when deg_malig = 2 then 1 else 0 end as deg_malig_cat2,
case when deg_malig = 3 then 1 else 0 end as deg_malig_cat3,
seio,
irradiando
from cap03.tb_dados4;


select * from cap03.tb_dados5;