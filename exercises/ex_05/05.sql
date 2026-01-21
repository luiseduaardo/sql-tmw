-- Quantidade de transações Acumuladas ao longo do tempo?

WITH transacoes_dia AS (
    SELECT  substr(DtCriacao, 1, 10) AS dtDia,
            count(*) AS qtdTransacoes

    FROM transacoes

    GROUP BY dtDia

    ORDER BY dtDia
)

SELECT  *,
        sum(qtdTransacoes) OVER (ORDER BY dtDia) AS transacoesAcum

FROM transacoes_dia