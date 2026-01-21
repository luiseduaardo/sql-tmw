-- Quantos clientes tem email cadastrado?

SELECT sum(flEmail) AS qtdEmail
FROM clientes;

SELECT count(*)
FROM clientes
WHERE flEmail = 1;