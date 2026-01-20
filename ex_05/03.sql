-- Do início ao fim do nosso curso (2025/08/25 a 2025/08/29), quantos clientes assinaram a lista de presença?

SELECT
        t3.DescNomeProduto,
        count(DISTINCT t1.idCliente) AS qtdCliente

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE t3.DescNomeProduto = 'Lista de presença' AND substr(t1.DtCriacao, 1, 10) >= '2025-08-25' AND substr(t1.DtCriacao, 1, 10) <= '2025-08-29'