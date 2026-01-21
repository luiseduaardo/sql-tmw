DELETE FROM relatorio_diario;

WITH    transacoes_dia AS (
    SELECT  substr(DtCriacao, 1, 10) AS dtDia,
            count(*) AS qtdTransacoes

    FROM transacoes

    GROUP BY dtDia

    ORDER BY dtDia
),

        tb_acum AS (
    SELECT  *,
            sum(qtdTransacoes) OVER (ORDER BY dtDia) AS transacoesAcum
    FROM transacoes_dia
)

INSERT INTO relatorio_diario
SELECT *
FROM tb_acum;

SELECT * FROM relatorio_diario;