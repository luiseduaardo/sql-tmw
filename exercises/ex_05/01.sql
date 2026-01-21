-- Quais clientes mais perderam pontos por Lover?

SELECT  t1.IdCliente,
        sum(t1.QtdePontos) AS pontosPerdidos

FROM transacoes as t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE t3.DescCategoriaProduto = 'lovers' AND t2.vlProduto < 0

GROUP BY t1.IdCliente

ORDER BY pontosPerdidos ASC

LIMIT 5