# Respostas - Exercício 4

# Verificando o total de registros
select * from exec4.tb_channels ;
select * from exec4.tb_deliveries ;
select * from exec4.tb_drivers;
select * from exec4.tb_hubs ;
select * from exec4.tb_orders ;
select * from exec4.tb_payments ;
select * from exec4.tb_stores ;

# 1- Qual o número de hubs por cidade?
select count(hub_id), hub_city as hub_cidade
from exec4.tb_hubs
group by hub_city
order by count(hub_id);

# 2- Qual o número de pedidos (orders) por status?
select count(order_id) as num_pedidos, order_status as status_pedido
from exec4.tb_orders
group by order_status;

# 3- Qual o número de lojas (stores) por cidade dos hubs?
select count(s.store_id) as num_lojas ,h.hub_city as cidade
from exec4.tb_stores s 
inner join exec4.tb_hubs h
on s.hub_id = h.hub_id
group by h.hub_city
order by num_store;

# 4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?
select min(payment_amount) as min_pagamento, max(payment_amount) as max_pagamento
from exec4.tb_payments;

# 5- Qual tipo de driver (driver_type) fez o maior número de entregas?

select distinct delivery_status 
from exec4.tb_deliveries;

select dr.driver_type as tipo_driver, count(dl.delivery_status) as num_delivery
from exec4.tb_drivers dr
inner join exec4.tb_deliveries dl
on dr.driver_id = dl.driver_id
and delivery_status ='DELIVERED'
group by dr.driver_type;

# 6- Qual a distância média das entregas por modo de driver (driver_modal)?

select distinct driver_modal
from exec4.tb_drivers dr;

select dr.driver_modal as modal, round(avg(dl.delivery_distance_meters),2)as distancia_media
from exec4.tb_drivers dr
inner join exec4.tb_deliveries dl
on dr.driver_id = dl.driver_id
group by dr.driver_modal
order by dr.driver_modal;

# 7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente? 
select store_name, round(avg(os.order_amount),2) as media_pedido
from exec4.tb_stores sr
inner join exec4.tb_orders os
on sr.store_id = os.store_id
group by sr.store_name 
order by media_pedido desc;


# 8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?
# coalesce  pode ser usado para substituir valores nulos, pelo valor passado na função (pode ser usado para string e números)
select  coalesce(store_name, "Sem loja") as loja, count(order_id) as qtde_pedidos
from exec4.tb_orders os
left join exec4.tb_stores sr
on os.store_id = sr.store_id
where sr.store_id is null
group by sr.store_name
order by qtde_pedidos desc;


# 9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
select round(sum(order_amount),2) as total_pedidos, channel_name as canal
from exec4.tb_orders os
inner join exec4.tb_channels  c
on os.channel_id = c.channel_id
and c.channel_name = 'FOOD PLACE';

# 10- Quantos pagamentos foram cancelados (chargeback)?
select count(payment_status)
from exec4.tb_payments;

select payment_status as pagamentos_cancelados, count(payment_id) as qtde
from exec4.tb_payments
where payment_status ='CHARGEBACK'
group by payment_status;


# 11- Qual foi o valor médio dos pagamentos cancelados (chargeback)? 
select payment_status as pagamentos_cancelados, round(avg(payment_amount), 2) as valor_medio
from exec4.tb_payments
where payment_status ='CHARGEBACK';

# 12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?
select * 
from exec4.tb_payments;

select round(avg(payment_amount),2) as valor_medio, payment_method as forma_pagamento
from exec4.tb_payments
group by payment_method
order by payment_method desc; 

# 13- Quais métodos de pagamento tiveram valor médio superior a 100?
select payment_method as forma_pagamento, round(avg(payment_amount),2) as media_pagamento
from exec4.tb_payments
group by payment_method
having   round(avg(payment_amount),2)> 100
order by payment_method desc; 

# 14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), 
# segmento da loja (store_segment) e tipo de canal (channel_type)?

select hub_state as estado, store_segment as loja, channel_type as canal, round(avg(order_amount), 2) as media_pedido
from exec4.tb_hubs h, exec4.tb_stores sr, exec4.tb_channels c , exec4.tb_orders os
where h.hub_id= sr.hub_id and sr.store_id = os.store_id and c.channel_id = os.channel_id
group by hub_state, store_segment, channel_type
order by hub_state ;


# 15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) 
#teve média de valor de pedido (order_amount) maior que 450?

select hub_state , store_segment, channel_type, round(avg(order_amount), 2) as media_pedido
from exec4.tb_hubs h, exec4.tb_stores sr, exec4.tb_channels c , exec4.tb_orders os
where h.hub_id= sr.hub_id
and sr.store_id = os.store_id 
and c.channel_id = os.channel_id
group by hub_state, store_segment, channel_type
having media_pedido > 450
order by hub_state ;

# 16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state),
# segmento da loja (store_segment) e tipo de canal (channel_type)?
# Demonstre os totais intermediários e formate o resultado.

select
     if(grouping (hub_state), 'Total Hub State', hub_state) as hub_state,
     if (grouping(store_segment), 'Total Segmento', store_segment) as store_segment,
     if(grouping (channel_type), 'Total Tipo de Canal', channel_type) as channel_type,
     round(sum(order_amount), 2) as valor_total_pedidos 
from exec4.tb_orders orders, exec4.tb_hubs hubs, exec4.tb_stores stores, exec4.tb_channels channels
where orders.store_id= stores.store_id
and orders.channel_id= channels.channel_id
and hubs.hub_id= stores.hub_id
group by hub_state , store_segment, channel_type with rollup
order by valor_total_pedidos ;


# 17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', 
# tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?
select hub_state, channel_type,order_status, round(avg(order_amount), 2) as media_pedido
from exec4.tb_hubs hubs,exec4.tb_stores stores,  exec4.tb_orders orders, exec4.tb_channels channels
where hubs.hub_id= stores.hub_id
and orders.store_id= stores.store_id
and orders.channel_id = channels.channel_id
and store_segment ='FOOD'
and order_status ='CANCELED'
and channel_type  = 'MARKETPLACE'
and hub_state = 'RJ'
group by hub_state, channel_type,order_status;

# 18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, 
# algum hub_state teve total de valor do pedido superior a 100.000?
select hub_state, store_segment, channel_type, round(sum(order_amount),2) as total_pedido
from exec4.tb_stores stores, exec4.tb_channels channels, exec4.tb_hubs hubs, exec4.tb_orders as orders
where stores.store_id = orders.order_id
and orders.channel_id = channels.channel_id
and stores.hub_id = hubs.hub_id
and store_segment = 'GOOD' 
and channel_type = 'MARKETPLACE'
group by hub_state, store_segment, channel_type
having total_pedido > 100000
order by hub_state;


# 19- Em que data houve a maior média de valor do pedido (order_amount)?
# função SUBSTRING() - quebra um string em parte, usa-se nº do carater inicial e final

select substring(order_moment_created, 1, 9) as data_pedido, round(avg(order_amount), 2) as media_pedido
from exec4.tb_orders orders
group by data_pedido
order by media_pedido desc;

# 20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)?
select substring(order_moment_created, 1,9) as data_pedido, min(order_amount) as min_pedido
from exec4.tb_orders orders
group by data_pedido
having min_pedido =  0
order by data_pedido ASC;




