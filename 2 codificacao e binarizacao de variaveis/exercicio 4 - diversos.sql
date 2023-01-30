select count(*) from cap03.tb_dados;

select * from cap03.tb_dados;

# Binarizacao da variavel classe para 0 ou 1
select distinct classe from cap03.tb_dados;

select 
    case
       when classe = 'no-recurrence-events' then 0
       when classe ='recurrence-events' then 1
    end as classe
from cap03.tb_dados;   

# Binarizacao da variavel irradiando para 0 ou 1
select distinct irradiando from cap03.tb_dados; 

select
    case 
        when irradiando = 'no' then 0
        when irradiando ='yes' then 1
	end as irradiando
from cap03.tb_dados;    


# Devido a valores ausentes, para ajustar a variavel node_caps iremos codificar e não mais binarizar
# as possibilidades de tecnicas devem ser verificadas com a equipe de Ciencia de dados
select distinct node_caps from cap03.tb_dados; 

select 
    case
       when node_caps ='no' then 0
       when node_caps= 'yes' then 1
    else 2 
    end as node_caps 
from cap03.tb_dados;    

# Categorizacao da variavel seio E ou D
select seio from cap03.tb_dados;

select 
    case 
        when seio = 'left' then 'E'
        when seio = 'right' then 'D'
    end as seio
from cap03.tb_dados;    

# Categorizacao da variavel tamanho tumor (6 categorias), valores ausentes recebem 'Nao identificado'
select distinct tamanho_tumor from cap03.tb_dados order by tamanho_tumor;

select 
	case
       when tamanho_tumor ='0-4' or tamanho_tumor ='5-9' then 'Muito pequeno'
       when tamanho_tumor = '10-14' or tamanho_tumor ='15-19' then 'Pequeno'
       when tamanho_tumor = '20-24' or tamanho_tumor ='25-29' then 'Medio'
       when tamanho_tumor = '30-34' or tamanho_tumor ='35-39' then 'Grande'
       when tamanho_tumor = '50-54' then tamanho_tumor ='Tratamento Urgente'
       else 'Nao identificado'
     end as tamanho_tumor
from cap03.tb_dados;     

#Label encoding da variavel quadrante (1,2,3,4,5), valores ausentes recebem o valor 0
select distinct quadrante from cap03.tb_dados;

select
   case 
      when quadrante = 'left_low' then 1
      when quadrante = 'left_up' then 2
      when quadrante = 'right_low' then 3
      when quadrante = 'right_up' then 4
      when quadrante = 'center' then 5
    else '0'
    end as quadrante
from cap03.tb_dados;    




    

