-- Saldo de pontos acumulado de cada usuário

WITH tb_clientes_pontos AS (
    SELECT  IdCliente,
            substr(DtCriacao, 1, 10) AS dtDia,
            sum(QtdePontos) AS totalPontos

    FROM transacoes

    GROUP BY idCliente, dtDia
)

SELECT  *,
        sum(totalPontos) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS pontosAcum

FROM tb_clientes_pontos