-- Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

WITH    tb_clientes AS (
    SELECT  substr(DtCriacao, 1, 10) AS dtDia,
            count(*) AS qtdClientes

    FROM clientes

    GROUP BY dtDia

    ORDER BY dtDia
)

-- quantidade acumulada
SELECT  *,
        sum(qtdClientes) OVER (ORDER BY dtDia) AS clientesAcum

FROM tb_clientes;

-- quantidade absoluta
SELECT sum(qtdClientes) AS totalClientes

FROM tb_clientes
