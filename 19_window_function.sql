WITH tb_cliente_dia AS (
    SELECT  IdCliente,
            substr(DtCriacao, 1, 10) AS dtDia,
            count(DISTINCT IdTransacao) AS qtdTransacao

    FROM transacoes

    WHERE dtCriacao >= '2025-08-25' AND dtCriacao < '2025-08-30'

    GROUP BY idCliente, dtDia
),

    tb_lag AS (
    SELECT  *,
            sum(qtdTransacao) OVER (PARTITION BY idCliente ORDER BY dtDia) AS qtdAcumulada,
            -- qtd acumulada por cliente
            lag(qtdTransacao) OVER (PARTITION BY idCliente ORDER BY dtDia) AS lagTransacao
    FROM tb_cliente_dia
)

SELECT  *,
        1. * qtdTransacao / lagTransacao

FROM tb_lag