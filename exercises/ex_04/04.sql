-- Qual o total de pontos trocados no Stream Elements em Junho de 2025?

SELECT  t3.DescCategoriaProduto,
        count(*) AS qtdCategoria

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE substr(DtCriacao, 1, 7) = '2025-06' AND t3.DescCategoriaProduto = 'streamelements'

GROUP BY t3.DescCategoriaProduto