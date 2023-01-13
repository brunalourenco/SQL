# Aplique label enconding a variavel menopausa
# Tecnica utilizada para transformar uma variavel categorica(string) em variavel numerica sem perder a essencia da informacao
# Eh imporantante porque auxilia na performace da carga de dados para relatorios, por exemplo. E deve ser documentada para evitar
# problemas no futuro.

# Consultar dados dististos antes das transformacoes
select distinct menopausa from cap03.tb_dados2;

# Cria o novo dataset e inclui os dados a serem alterados
create table cap03.tb_dados3
as
select 
classe,
idade,
   case
      when menopausa = 'premeno' then 0
      when menopausa = 'ge40'then 1
      when menopausa = 'lt40' then 2
   end as menopausa,
tamanho_tumor,
inv_nodes,
node_caps,
deg_malig,
seio,
quadrante,
irradiando
from cap03.tb_dados2;

# Verificar se deu tudo certo
select * from cap03.tb_dados3;