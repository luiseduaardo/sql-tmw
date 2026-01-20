-- SELECT
--         count(*),
--         count(1)
-- FROM clientes;

-- nesse caso fazer count(*) e esse count é a mesma coisa já que idCliente é uma chave primária
SELECT COUNT(DISTINCT idCliente)

FROM clientes