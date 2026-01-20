-- Qual o produto com mais pontos transacionados?

SELECT  idProduto,
        sum(vlProduto) as ptsTransacionados

FROM transacao_produto

GROUP BY IdProduto

ORDER BY ptsTransacionados DESC

LIMIT 1