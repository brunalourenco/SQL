
#[Desafio] Crie uma nova columa chamada posicao_tumor concatenando as colunas inv_nodes e quadrante
select distinct inv_nodes, quadrante  from cap03.tb_dados3;

# cria novo dataset com os dados transformados
create table cap03.tb_dados4
as
select
classe,
idade,
menopausa,
tamanho_tumor,
concat(inv_nodes, '-', quadrante) as posicao_tumor,
node_caps,
deg_malig,
seio,
irradiando
from cap03.tb_dados3;

select * from cap03.tb_dados4;