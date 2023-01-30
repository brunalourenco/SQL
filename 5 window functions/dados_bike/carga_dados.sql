 # link da base de dados https://capitalbikeshare.com/system-data
 # dados reais sobre aluguel de bikes em uma empresa Norte Americana em 2012
 
create table cap06.tb_bikes (
duracao_segundos int default null,
data_inicio text,
data_fim text,
numero_estacao_inicio int default null,
estacao_inicio text,
numero_estacao_fim int default null,
estacao_fim text,
numero_bike text,
tipo_membro text);

# Carga de dados via comandos

# Conectar MySQL via linha de comandos
mysql --local-infile=1 -u root -p

# Execute
SET GLOBAL local infile = true;
exit;

# De novo
mysql --local-infile=1 -u root -p

# Carga de dados via comandos
LOAD DATA LOCAL INFILE '/Users/Usuario/Documents/CURSOS/SQL/cap06/dados_bike/2012Q1-capitalbikeshare-tripdata.csv'
 INTO TABLE `cap06`.`tb_bikes` CHARACTER SET UTF8 
 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;