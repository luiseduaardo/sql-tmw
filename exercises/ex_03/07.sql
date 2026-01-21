-- Qual o produto mais transacionado?

SELECT  idProduto,
        count(*) AS qtdProduto

FROM transacao_produto

GROUP BY idProduto
ORDER BY qtdProduto DESC
LIMIT 1