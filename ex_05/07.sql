-- Qual o dia da semana mais ativo de cada usuário?

WITH    tb_clientes AS (
    SELECT  idCliente,
            strftime('%w', DtCriacao) AS dtdiaSemana,
            count(DISTINCT IdTransacao) AS qtdTransacao

    FROM transacoes

    GROUP BY idCliente, dtdiaSemana

    ORDER BY idCliente, dtdiaSemana
),

        tb_rows AS (
    SELECT  *,
            CASE
                WHEN dtdiaSemana = '0' THEN 'Domingo'
                WHEN dtdiaSemana = '1' THEN 'Segunda'
                WHEN dtdiaSemana = '2' THEN 'Terça'
                WHEN dtdiaSemana = '3' THEN 'Quarta'
                WHEN dtdiaSemana = '4' THEN 'Quinta'
                WHEN dtdiaSemana = '5' THEN 'Sexta'
                WHEN dtdiaSemana = '6' THEN 'Sábado'
            END AS diaSemana,
            row_number() OVER (PARTITION BY idCliente ORDER BY qtdTransacao DESC) AS rn

    FROM tb_clientes
)

SELECT idCliente, diaSemana, qtdTransacao
FROM tb_rows
WHERE rn = 1