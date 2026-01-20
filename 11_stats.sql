SELECT
        sum(qtdePontos) AS SomaTotalPontos,
        count(idCliente) AS QtdClientes,
        round((1. * sum(qtdePontos) / count(idCliente)), 2) AS MediaPontos,

        round(avg(qtdePontos), 2) AS MediaPontosFunct,

        min(QtdePontos) AS minCarteira,
        max(QtdePontos) AS maxPontos,
        
        sum(flTwitch) AS qtdTwitch,
        sum(flYouTube) AS qtdYoutube,
        sum(flBlueSky) AS qtdBlueSky
        

FROM clientes