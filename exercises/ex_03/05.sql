-- Qual o valor médio de pontos positivos por dia?

-- SELECT  substr(DtCriacao, 1, 10) AS diaAtual,
--         round(avg(qtdePontos), 2) AS avgPontosDia

-- FROM transacoes

-- WHERE qtdePontos > 0

-- GROUP BY diaAtual

-- ORDER BY diaAtual DESC

SELECT  sum(qtdePontos) AS totPontos,
        count(DISTINCT substr(DtCriacao, 1, 10)) AS diasDistintos,

        sum(qtdePontos) / count(DISTINCT substr(DtCriacao, 1, 10)) AS mediaDias

FROM transacoes

WHERE qtdePontos > 0