-- Lista de pedidos realizados no fim de semana;

SELECT  *,
        strftime('%w', DtCriacao) AS diaSemana
FROM transacoes
WHERE diaSemana IN ('0', '6')