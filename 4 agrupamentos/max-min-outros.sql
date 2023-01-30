# Maior valor de pedidos
select max(valor_pedido) as maior_valor_pedido
from cap05.tb_pedidos;

# Menor valor
select min(valor_pedido) as minino_valor_pedido
from cap05.tb_pedidos;

# Número de pedidos
select count(*) as quantidade_pedidos
from cap05.tb_pedidos;

# Número de clientes que fizeram pedidos, sem repetição de cliente
select count(distinct id_cliente) as quantidade_pedidos
from cap05.tb_pedidos;

# sempre validade se as informacoes estam corretos !!!

# Listagem de pedidos
select *
from cap05.tb_pedidos
order by id_cliente;

# Número de pedidos de clientes do CE
select count(C.id_cliente) as total_pedidos
from cap05.tb_pedidos P, cap05.tb_clientes C
where P.id_cliente = C.id_cliente
and estado_cliente = 'CE';

# Número de clientes únicos do CE que fizeram pedidos com o nome de cada de cliente
select C.nome_cliente, C.cidade_cliente, C.estado_cliente, count(distinct C.id_cliente) as clientes_unicos
from cap05.tb_pedidos P, cap05.tb_clientes C
where P.id_cliente = C.id_cliente
and P.id_cliente = C.id_cliente
and C.estado_cliente = 'CE'
group by C.nome_cliente, C.cidade_cliente, C.estado_cliente;

# Nome e cidade do cliente e número de pedidos
select C.nome_cliente, C.cidade_cliente, count(P.id_pedido) as num_pedidos
from cap05.tb_clientes C, cap05.tb_pedidos P
where C.id_cliente = P.id_cliente
group by C.nome_cliente, C.cidade_cliente;

# Algum vendedor participou de vendas cujo pedido tenha sido super a 600 no Estado de SP?
# Dica do prof - fatiar e fazer a query por partes
select nome_cliente, cidade_cliente, estado_cliente, valor_pedido, nome_vendedor
from cap05.tb_pedidos P inner join cap05.tb_clientes C inner join cap05.tb_vendedor V
on P.id_cliente = C.id_cliente
and P.id_vendedor = V.id_vendedor
and C.estado_cliente = 'SP'
and valor_pedido > 600;







