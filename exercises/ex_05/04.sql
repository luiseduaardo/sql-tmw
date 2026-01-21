-- Clientes mais antigos, tem mais frequência de transação?

SELECT  t1.IdCliente,
        CAST(julianday('now') - julianday(t1.DtCriacao) AS INTEGER) AS diasAtivo,
        count(*) AS qtdTransacoes


FROM clientes AS t1

LEFT JOIN transacoes AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t1.idCliente, diasAtivo