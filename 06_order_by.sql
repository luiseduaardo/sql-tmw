-- top 10 clientes com mais pontos

-- SELECT * FROM clientes
-- ORDER BY qtdePontos DESC
-- LIMIT 10;

SELECT * FROM clientes
WHERE flTwitch = 1
ORDER BY DtCriacao ASC, qtdePontos DESC