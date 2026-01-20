-- CTE: Common Table Expression

WITH tb_cliente_primeiro_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
), 
    
    tb_cliente_ultimo_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-29'
),

    tb_clientes AS (
    SELECT  t1.idCliente AS primCliente,
            t2.idCliente AS segCliente
    FROM tb_cliente_primeiro_dia AS t1

    LEFT JOIN tb_cliente_ultimo_dia AS t2
    ON t1.idCliente = t2.idCliente
)

SELECT  count(primCliente),
        count(segCliente),
        1. * count(segCliente) / count(primCliente) AS proporc

FROM tb_clientes