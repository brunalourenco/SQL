# Carga de dados via prompt de comandos
# Porque o desempenho é melhor e a base de dados é grande

# Conecte no MySQL via linha de comando
# Linux ou mac  /usr/local/mysql/bin/mysql --local-infile=1 -u root -p
# Windows # mysql --local-infile=1 -u root -p

# Execute:
SET GLOBAL local_infile = true;

# Criar o schema
create schema exec4;
use exec4;

# Criar as tabelas para receber os dados
create table exec4.tb_channels(
channel_id int null,
channel_name varchar(200),
channel_type varchar(200)
);

# carregar os dados - no prompt de comando
LOAD DATA LOCAL INFILE '/Users/Usuario/Documents/CURSOS/SQL/cap06/delively-pedidos/channels.csv' INTO TABLE `exec4`.`tb_channels`
CHARACTER SET UTF8 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

create table exec4.tb_deliveries(
delivery_id int null,
delivery_order_id int null,
driver_id int null,
delivery_distance_meters double,
delivery_status varchar(100)
);

# carregar os dados - no prompt de comando
LOAD DATA LOCAL INFILE '/Users/Usuario/Documents/CURSOS/SQL/cap06/delively-pedidos/deliveries.csv' INTO TABLE `exec4`.`tb_deliveries`
CHARACTER SET UTF8 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

create table exec4.tb_drivers(
driver_id int null,
driver_modal varchar(100) null,
driver_type varchar(200) null
);

# carregar os dados - no prompt de comando
LOAD DATA LOCAL INFILE '/Users/Usuario/Documents/CURSOS/SQL/cap06/delively-pedidos/drivers.csv' INTO TABLE `exec4`.`tb_drivers`
CHARACTER SET UTF8 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

create table exec4.tb_hubs (
hub_id int null,
hub_name varchar(200) null,
hub_city varchar(200) null,
hub_state varchar(10) null,
hub_latitude varchar(100) null,
hub_longitude varchar(100) null
);
# carregar os dados - no prompt de comando 
LOAD DATA LOCAL INFILE '/Users/Usuario/Documents/CURSOS/SQL/cap06/delively-pedidos/hubs.csv' INTO TABLE `exec4`.`tb_hubs`
CHARACTER SET UTF8 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


create table exec4.tb_payments (
payment_id int null,
payment_order_id int null,
payment_amount double null,
payment_fee int null,
payment_method varchar(200) null,
payment_status varchar(200) null
);
# carregar os dados - no prompt de comando
LOAD DATA LOCAL INFILE '/Users/Usuario/Documents/CURSOS/SQL/cap06/delively-pedidos/payments.csv' INTO TABLE `exec4`.`tb_payments`
CHARACTER SET UTF8 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

create table exec4.tb_stores(
store_id int null,
hub_id int null,
store_name varchar(200) null,
store_segment varchar(200) null,
store_plan_price varchar(200) null,
store_latitude varchar(200) null,
store_longitude varchar(200) null
);
# carregar os dados - no prompt de comando
LOAD DATA LOCAL INFILE '/Users/Usuario/Documents/CURSOS/SQL/cap06/delively-pedidos/stores.csv' INTO TABLE `exec4`.`tb_stores`
CHARACTER SET UTF8 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

create table exec4.tb_orders (
order_id int null,
store_id int null,
channel_id int null,
payment_order_id int null,
delivery_order_id int null,
order_status varchar(200) null,
order_amount double null,
order_delivery_fee int null,
order_delivery_cost double null,
order_created_hour int null,
order_created_minute int null,
order_created_day int null,
order_created_month int null,
order_created_year int null,
order_moment_created int null,
order_moment_accepted int null,
order_moment_ready int null,
order_moment_collected int null,
order_moment_in_expedition int null,
order_moment_delivering int null,
order_moment_delivered int null,
order_moment_finished int null,
order_metric_collected_time int null,
order_metric_paused_time int null,
order_metric_production_time  int null,
order_metric_walking_time int null,
order_metric_expediton_speed_time int null,
order_metric_transit_time int null,
order_metric_cycle_time int null
);
# carregar os dados - no prompt de comando
LOAD DATA LOCAL INFILE '/Users/Usuario/Documents/CURSOS/SQL/cap06/delively-pedidos/orders.csv' INTO TABLE `exec4`.`tb_orders`
CHARACTER SET UTF8 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;



