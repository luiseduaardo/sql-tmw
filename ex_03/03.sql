-- Qual cliente fez mais transações no ano de 2024?

SELECT  idCliente,
        -- count(idCliente) AS qtdTransacoes,
        count(DISTINCT IdTransacao)

FROM transacoes
-- WHERE DtCriacao >= '2024-01-01' AND DtCriacao < '2025-01-01'
WHERE substr(DtCriacao, 1, 4) = '2024'

GROUP BY IdCliente
ORDER BY qtdTransacoes DESC
LIMIT 1