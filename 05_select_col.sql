SELECT  idCliente,
        -- qtdePontos, 
        -- QtdePontos + 10 AS QtdePontosPlus10, 
        -- QtdePontos * 2 AS QtdePontosDouble,
        DtCriacao,
        datetime(DtCriacao) AS DtCriacaoFormat,
        strftime('%w', datetime(DtCriacao)) AS diaSemana
FROM clientes
