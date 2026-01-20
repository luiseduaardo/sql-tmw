-- 11. Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?

-- quem participou da primeira aula
WITH    tb_primeiro AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

-- quem participou do curso inteiro
        tb_dias_curso AS (
    
    SELECT  DISTINCT IdCliente,
            substr(DtCriacao,1,10) AS presenteDia
    FROM transacoes
    WHERE presenteDia >= '2025-08-25' AND presenteDia < '2025-08-30'

    ORDER BY IdCliente, presenteDia
),

-- quantas vezes quem participou do primeiro dia voltou
        tb_cliente_dias AS (
    SELECT  t1.idCliente,
            count(DISTINCT t2.presenteDia) AS qtdDias

    FROM tb_primeiro AS t1

    LEFT JOIN tb_dias_curso AS t2
    ON t1.IdCliente = t2.idCliente

    GROUP BY t1.idCliente
)

-- média de participações das pessoas que estiveram no primeiro dia
SELECT round(avg(qtdDias), 0)

FROM tb_cliente_dias