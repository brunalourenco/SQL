
# criar schema para receber os dados
create schema cap02;

# Criar tabela 
create table cap02.tb_navios;

# Consultar dados
SELECT nome_navio, mes_ano 
FROM cap02.TB_NAVIOS;

# Consultando dados distintos
SELECT DISTINCT classificacao_risco 
FROM cap02.TB_NAVIOS;

# Consulta dados de navios para a classificacao de risco  D
SELECT nome_navio, temporada 
FROM cap02.TB_NAVIOS
WHERE classificacao_risco = 'D';

# Consultas de dados para a classificacao de risco D ordenadas pelo nome do navio
SELECT nome_navio, classificacao_risco, temporada 
FROM cap02.TB_NAVIOS 
WHERE classificacao_risco = 'D'
ORDER BY nome_navio;

SELECT nome_navio, classificacao_risco, pontuacao_risco, temporada 
FROM cap02.TB_NAVIOS 
WHERE classificacao_risco = 'D'
ORDER BY nome_navio;

# Consultas utilizando os operados AND e OR
SELECT nome_navio, classificacao_risco, pontuacao_risco, temporada 
FROM cap02.TB_NAVIOS 
WHERE classificacao_risco = 'D' AND pontuacao_risco > 1000
ORDER BY nome_navio;

SELECT nome_navio, classificacao_risco, pontuacao_risco, temporada 
FROM cap02.TB_NAVIOS 
WHERE classificacao_risco = 'D' OR pontuacao_risco > 3000
ORDER BY nome_navio;

SELECT nome_navio, classificacao_risco, indice_conformidade, temporada 
FROM cap02.TB_NAVIOS 
WHERE classificacao_risco IN ('A', 'B') AND indice_conformidade > 90
ORDER BY nome_navio;

SELECT nome_navio, classificacao_risco, indice_conformidade, temporada 
FROM cap02.TB_NAVIOS 
WHERE classificacao_risco IN ('A', 'B') AND indice_conformidade > 90
ORDER BY indice_conformidade 
LIMIT 10;

# Em Abril de 2018 alguma embarcação teve índice de conformidade de 100% e pontuação de risco igual a 0?

SELECT nome_navio, classificacao_risco, indice_conformidade, pontuacao_risco, temporada 
FROM cap02.TB_NAVIOS 
WHERE indice_conformidade > 90 AND pontuacao_risco = 0 AND mes_ano = '04/2018'
ORDER BY indice_conformidade;

# Em Abril de 2018 alguma embarcação teve índice de conformidade de 100% e pontuação de risco igual a 0?
# utilizando subquery
SELECT nome_navio, classificacao_risco, indice_conformidade, pontuacao_risco, temporada 
FROM cap02.TB_NAVIOS 
WHERE indice_conformidade IN (SELECT indice_conformidade 
								FROM cap02.TB_NAVIOS 
							   WHERE indice_conformidade > 90)
                                 AND pontuacao_risco = 0 
                                 AND mes_ano = '04/2018'
ORDER BY indice_conformidade;






