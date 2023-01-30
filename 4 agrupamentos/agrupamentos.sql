# Listar clientes
select * from cap05.tb_clientes;

# Usando 'group by' utilizado para agrupar dados 
# Contagem de clientes por cidade ordenado pela contagem
select count(id_cliente) as contagem, cidade_cliente
from cap05.tb_clientes
group by cidade_cliente
order by contagem desc;

# Media de valor dos pedidos
select avg(valor_pedido) as media_valor_pedidos
from cap05.tb_pedidos;

# Media do valor dos pedidos por cidade
# a funcao round é utilizada para arrendondar casas decimais, nesse caso para 2
select round(avg(valor_pedido),2) as media_pedidos, C.cidade_cliente
from cap05.tb_pedidos as P
inner join cap05.tb_clientes as C
on P.id_cliente= C.id_cliente
group by C.cidade_cliente
order by media_pedidos desc;

# Inserindo novo registro de cliente
INSERT INTO cap05.TB_CLIENTES (id_cliente, nome_cliente,endereco_cliente, cidade_cliente,estado_cliente)
VALUES (11, "Michael Jordan", "Rua 21", "Palmas", "TO");

# Media de dos pedidos por cidade usando RIGHT JOIN
select round(avg(valor_pedido),2) as media_pedidos, C.cidade_cliente
from cap05.tb_pedidos as P
right join cap05.tb_clientes as C
on P.id_cliente= C.id_cliente
group by C.cidade_cliente
order by media_pedidos desc;

# Media de dos pedidos por cidade usando RIGHT JOIN e CASE
select 
case 
    when round(avg(valor_pedido),2) is null then 0
     else round(avg(valor_pedido),2)   
end as media_pedidos,
C.cidade_cliente
from cap05.tb_pedidos as P
right join cap05.tb_clientes as C
on P.id_cliente= C.id_cliente
group by C.cidade_cliente
order by media_pedidos desc;

# Soma(total) do valor dos pedidos
select sum(valor_pedido) as total
from cap05.tb_pedidos;

# Soma(total) do valor dos pedidos por cidade
select sum(valor_pedido) as total , cidade_cliente
from cap05.tb_pedidos P, cap05.tb_clientes C
where P.id_cliente = C.id_cliente
group by cidade_cliente;

# Insere mais 2 clientes
INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (12, "Bill Gates", "Rua 14", "Santos", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (13, "Jeff Bezos", "Rua 29", "Osasco", "SP");

# Insere mais 3 pedidos
INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1016, 11, 5, now(), 27, 234.09);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1017, 12, 4, now(), 22, 678.30);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1018, 13, 4, now(), 22, 978.30);

# Soma (total) do valor dos pedidos por cidade e estado
select sum(valor_pedido) as total , cidade_cliente, estado_cliente
from cap05.tb_pedidos P 
inner join cap05.tb_clientes C
on P.id_cliente = C.id_cliente
group by cidade_cliente, estado_cliente
order by estado_cliente;

# Insere mais 2 clientes
INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (14, "Melinda Gates", "Rua 14", "Barueri", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (15, "Barack Obama", "Rua 29", "Barueri", "SP");

# Soma (total) do valor dos pedidos por cidade e estado usando RIGHT JOIN e CASE
# Funcao floor arrendonda para valor inteiro
select 
   case
      when floor(sum(valor_pedido)) is null then 0
      else floor(sum(valor_pedido))
   end as total ,
   cidade_cliente,
   estado_cliente
from cap05.tb_pedidos P
right join cap05.tb_clientes C
on P.id_cliente = C.id_cliente
group by cidade_cliente, estado_cliente
order by total desc;

# Supondo que a comissao de cada vendedor seja 10%, quanto ganhou de comissao cada vendedor no stado?
select V.nome_vendedor, C.estado_cliente, round(sum(valor_pedido*0.10),2) as comissao_vendedor
from cap05.tb_pedidos P inner join cap05.tb_clientes C right join cap05.tb_vendedor V
on P.id_cliente = C.id_cliente
and P.id_vendedor = V.id_vendedor
and C.estado_cliente = 'CE'
group by V.nome_vendedor, C.estado_cliente
order by C.estado_cliente;

# Supondo que a comissao de cada vendedor seja 10%, quanto ganhou de comissao cada vendedor no estado do Ceara?
# Retorne zero se nao houve ganho de comissao
select
V.nome_vendedor,
  case
    when C.estado_cliente is null then 'Não atua no Ceará'
    else C.estado_cliente
    end as estado_cliente, 
    case
     when round(sum(valor_pedido*0.10),2) is null then 0
     else round(sum(valor_pedido*0.10),2)
     end as comissao_vendedor
 
from cap05.tb_pedidos P inner join cap05.tb_clientes C right join cap05.tb_vendedor V
on P.id_cliente = C.id_cliente
and P.id_vendedor = V.id_vendedor
and C.estado_cliente = 'CE'
group by V.nome_vendedor, C.estado_cliente
order by C.estado_cliente;

# Having -  é usado com o group by, filtro de dados agrupados
# Algum vendedor participou de vendas em que a média do valor_pedido por estado do cliente foi superior a 800?
select estado_cliente, nome_vendedor, ceiling (avg(valor_pedido)) as media
from cap05.tb_pedidos P
inner join cap05.tb_clientes C
inner join cap05.tb_vendedor V
on P.id_cliente = C.id_cliente
and P.id_vendedor = V.id_vendedor
group by estado_cliente, nome_vendedor
having media >800
order by nome_vendedor;

