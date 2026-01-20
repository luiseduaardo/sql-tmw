-- 10. Como foi a curva de Churn do curso de SQL?

WITH tb_clientes_d1 AS (
    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-26'
)

SELECT  substr(t2.DtCriacao, 1, 10) AS dtDia,
        count(DISTINCT t1.IdCliente) AS qtdCliente,
        round(1. * count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_clientes_d1), 4) * 100 AS curvaRetencao,
        (1 - round(1. * count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_clientes_d1), 4)) * 100 AS curvaChurn
        

FROM tb_clientes_d1 AS t1

LEFT JOIN transacoes AS t2
ON t1.idCliente = t2.idCliente

WHERE t2.DtCriacao >= '2025-08-25' AND t2.DtCriacao < '2025-08-30'

GROUP BY dtDia