-- Listar todas as transações adicionando uma coluna nova sinalizando “alto”, “médio” e “baixo” para o valor dos pontos [<10 ; <500; >=500]

SELECT  *,
        CASE
            WHEN QtdePontos >= 500 THEN 'Alto'
            WHEN QtdePontos >= 10 THEN 'Médio'
            ELSE 'Baixo'
        END AS Categoria
FROM transacoes
ORDER BY QtdePontos DESC
