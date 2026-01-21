
WITH    tb_transacoes AS (
    SELECT  IdTransacao,
            idCliente,
            qtdePontos,
            datetime(substr(DtCriacao, 1, 19)) AS dtCriacao,
            julianday('now') - julianday(DtCriacao) AS dtDiff,
            CAST (strftime('%H', DtCriacao) AS INTEGER) AS dtHora

    FROM transacoes
),

        tb_cliente AS (
    SELECT  idCliente,
            datetime(DtCriacao) AS DtCriacao,
            CAST (julianday('now') - julianday(DtCriacao) AS INT) AS idadeBase
    FROM clientes
),

        tb_sumario_transacoes AS (
    SELECT  IdCliente,

            -- Quantidade de transações históricas (vida, D7, D14, D28, D56);
            count( DISTINCT IdTransacao ) AS qtdTransacoesVida,
            count( CASE WHEN dtDiff <= 7 THEN IdTransacao END ) AS qtdeTransacoes7,
            count( CASE WHEN dtDiff <= 14 THEN IdTransacao END ) AS qtdeTransacoes14,
            count( CASE WHEN dtDiff <= 28 THEN IdTransacao END ) AS qtdeTransacoes28,
            count( CASE WHEN dtDiff <= 56 THEN IdTransacao END ) AS qtdeTransacoes56,

            -- Dias desde a última transação
            CAST ( min(dtDiff) AS INT ) AS diaUltimaInteracao,
            
            -- Saldo de pontos atual;
            sum(qtdePontos) AS saldoPontos,

            -- Pontos acumulados positivos (vida, D7, D14, D28, D56);
            sum( CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END ) AS qtdPontosPosVida,
            sum( CASE WHEN qtdePontos > 0 AND dtDiff <=  7 THEN qtdePontos ELSE 0 END ) AS qtdePontosPos7,
            sum( CASE WHEN qtdePontos > 0 AND dtDiff <= 14 THEN qtdePontos ELSE 0 END ) AS qtdePontosPos14,
            sum( CASE WHEN qtdePontos > 0 AND dtDiff <= 28 THEN qtdePontos ELSE 0 END ) AS qtdePontosPos28,
            sum( CASE WHEN qtdePontos > 0 AND dtDiff <= 56 THEN qtdePontos ELSE 0 END ) AS qtdePontosPos56,

            -- Pontos acumulados negativos (vida, D7, D14, D28, D56);
            sum( CASE WHEN qtdePontos < 0 THEN qtdePontos ELSE 0 END ) AS qtdPontosNegVida,
            sum( CASE WHEN qtdePontos < 0 AND dtDiff <=  7 THEN qtdePontos ELSE 0 END ) AS qtdePontosNeg7,
            sum( CASE WHEN qtdePontos < 0 AND dtDiff <= 14 THEN qtdePontos ELSE 0 END ) AS qtdePontosNeg14,
            sum( CASE WHEN qtdePontos < 0 AND dtDiff <= 28 THEN qtdePontos ELSE 0 END ) AS qtdePontosNeg28,
            sum( CASE WHEN qtdePontos < 0 AND dtDiff <= 56 THEN qtdePontos ELSE 0 END ) AS qtdePontosNeg56

    FROM tb_transacoes

    GROUP BY idCliente
),

        tb_transacao_produto AS (
    SELECT  t1.*,
            t3.DescNomeProduto,
            t3.DescCategoriaProduto

    FROM tb_transacoes AS t1

    LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto
),

        tb_cliente_produto AS (
        SELECT  idCliente,
                DescNomeProduto,
                count(*) AS qtdeVida,
                count( CASE WHEN dtDiff <= 56 THEN IdTransacao END ) as qtde56,
                count( CASE WHEN dtDiff <= 28 THEN IdTransacao END ) as qtde28,
                count( CASE WHEN dtDiff <= 14 THEN IdTransacao END ) as qtde14,
                count( CASE WHEN dtDiff <= 7 THEN IdTransacao END ) as qtde7      

        FROM tb_transacao_produto

        GROUP BY idCliente, DescNomeProduto
),

        tb_cliente_produto_rn AS (
        SELECT  *,

                -- Produto mais usado (vida, D7, D14, D28, D56);
                row_number() OVER ( PARTITION BY idCliente ORDER BY qtdeVida DESC ) AS rnVida,
                row_number() OVER ( PARTITION BY idCliente ORDER BY qtde56 DESC ) AS rn56,
                row_number() OVER ( PARTITION BY idCliente ORDER BY qtde28 DESC ) AS rn28,
                row_number() OVER ( PARTITION BY idCliente ORDER BY qtde14 DESC ) AS rn14,
                row_number() OVER ( PARTITION BY idCliente ORDER BY qtde7 DESC ) AS  rn7

        FROM tb_cliente_produto
),

        tb_dia_qtd_transacao AS (
        SELECT  IdCliente,
                strftime('%w', DtCriacao) AS dtDia,
                count(*) AS qtdTransacaoDia

        FROM tb_transacoes

        WHERE dtDiff <= 28

        GROUP BY idCliente, dtDia
),
        
        tb_dia_qtd_transacao_rn AS (
        SELECT  *,
                row_number() OVER ( PARTITION BY idCliente ORDER BY qtdTransacaoDia DESC, dtDia ) AS rn

        FROM tb_dia_qtd_transacao
),

tb_cliente_periodo AS (
        SELECT  idCliente,
                CASE 
                        WHEN dtHora BETWEEN 7 AND 12 THEN 'MANHÃ'
                        WHEN dtHora BETWEEN 13 AND 18 THEN 'TARDE'
                        WHEN dtHora BETWEEN 19 AND 23 THEN 'NOITE'
                        WHEN dtHora > 23 OR dtHora < 7 THEN 'MADRUGADA'
                        ELSE 'SEM INFORMAÇÃO'
                END AS periodoDia,
                count(*) AS qtdTransacao
                        
        FROM tb_transacoes

        WHERE dtDiff <= 28

        GROUP BY idCliente, periodoDia
),

tb_cliente_periodo_rn AS (
        SELECT  *,
                row_number() OVER ( PARTITION BY idCliente ORDER BY qtdTransacao DESC ) AS rn

        FROM tb_cliente_periodo
),

tb_join AS (

    SELECT  t1.*,
            t2.idadeBase,
            t3.DescNomeProduto AS produtoVida,
            t4.DescNomeProduto AS produto56,
            t5.DescNomeProduto AS produto28,
            t6.DescNomeProduto AS produto14,
            t7.DescNomeProduto AS produto7,
            t8.dtDia,
            t9.periodoDia

    FROM tb_sumario_transacoes AS t1

    LEFT JOIN tb_cliente AS t2
    ON t1.idCliente = t2.idCliente

    LEFT JOIN tb_cliente_produto_rn AS t3
    ON t1.idCliente = t3.idCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn AS t4
    ON t1.idCliente = t4.idCliente
    AND t4.rn56 = 1

    LEFT JOIN tb_cliente_produto_rn AS t5
    ON t1.idCliente = t5.idCliente
    AND t5.rn28 = 1

    LEFT JOIN tb_cliente_produto_rn AS t6
    ON t1.idCliente = t6.idCliente
    AND t6.rn14 = 1

    LEFT JOIN tb_cliente_produto_rn AS t7
    ON t1.idCliente = t7.idCliente
    AND t7.rn7 = 1

    LEFT JOIN tb_dia_qtd_transacao_rn AS t8
    ON t1.idCliente = t8.idCliente
    AND t8.rn = 1

    LEFT JOIN tb_cliente_periodo_rn AS t9
    ON t1.idCliente = t9.idCliente
    AND t9.rn = 1
)

SELECT
        round(1. * 100 * qtdeTransacoes28 / qtdTransacoesVida, 2) AS engajamento2
FROM tb_join