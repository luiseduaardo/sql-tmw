WITH cliente_dia AS (
    SELECT  DISTINCT IdCliente,
            substr(DtCriacao, 1, 10) AS dtDia
    FROM transacoes
    WHERE substr(DtCriacao, 1, 4) = '2025'
    ORDER BY idCliente, dtDia
),

        tb_lag AS (
    SELECT  *,
            lag(dtDia) OVER (PARTITION BY idCliente) AS lagDia
    FROM cliente_dia
),

        tb_diff_dt AS (
    SELECT  *,
            CAST (julianday(dtDia) - julianday(lagDia) AS INTEGER) AS diffDia

    FROM tb_lag
),

        tb_avg_dia_cliente AS (
    SELECT IdCliente, CAST(avg(diffDia) AS INT) AS avgDia
    -- de quanto em quanto tempo cada usuário volta
    -- os null representam os que não voltaram
    FROM tb_diff_dt
    GROUP BY idCliente
)

-- de quanto em quanto tempo os usuários voltam num geral
SELECT avg(avgDia) FROM tb_avg_dia_cliente