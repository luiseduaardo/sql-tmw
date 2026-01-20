-- SELECT  IdProduto,
--         count(*)

-- FROM transacao_produto

-- GROUP BY IdProduto

SELECT  IdCliente,
        sum(QtdePontos) AS PontosCliente,
        count(IdTransacao) AS QtdTransacoes

FROM transacoes

WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-08-01'

GROUP BY IdCliente
HAVING PontosCliente >= 4000 -- where do group by (filtrando depois da agregação)

ORDER BY PontosCliente DESC