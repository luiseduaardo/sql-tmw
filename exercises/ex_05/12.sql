-- Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?

WITH    clientes_janeiro AS (
    SELECT DISTINCT idCliente AS clientes_janeiro
    FROM transacoes
    WHERE DtCriacao LIKE '2025-01-%'
),

        curso_sql AS (
    SELECT DISTINCT idCliente AS clientes_sql
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-30'
),

        jan_sql_mix AS (
    SELECT  count(t1.clientes_janeiro) AS qtdJaneiro,
            count(t2.clientes_sql) AS qtdJaneiroSql

    FROM clientes_janeiro AS t1

    LEFT JOIN curso_sql AS t2
    ON t1.clientes_janeiro = t2.clientes_sql
)

SELECT * FROM jan_sql_mix