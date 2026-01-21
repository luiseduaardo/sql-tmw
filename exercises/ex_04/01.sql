-- Qual categoria tem mais produtos vendidos?

SELECT  t2.DescCategoriaProduto,
        count(*) AS qtdCategoria

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2

ON t1.IdProduto = t2.IdProduto

GROUP BY DescCategoriaProduto
ORDER BY qtdCategoria DESC
LIMIT 1