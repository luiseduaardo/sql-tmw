/* INTERVALOS
0 à 500      -> ponei
501 à 1000   -> ponei premium
1001 à 5000  -> mago aprendiz
5001 à 10000 -> mago mestre
+10001       -> mago supremo
 */

SELECT  idCliente,
        qtdePontos,
        CASE
            -- funciona como if/elif, então eu não preciso fazer as condições de novo
            WHEN qtdePontos <= 500 THEN 'Ponei'
            WHEN qtdePontos <= 1000 THEN 'Ponei Premium'
            WHEN qtdePontos <= 5000 THEN 'Mago Aprendiz'
            WHEN qtdePontos <= 10000 THEN 'Mago Mestre'
            ELSE 'Mago Supremo'
        END AS Categoria,

        CASE
            WHEN qtdePontos <= 1000 THEN 1
            ELSE 0
        END AS flPonei,

        CASE
            WHEN qtdePontos > 1000 THEN 1
            ELSE 0
        END AS flMago

FROM clientes
ORDER BY qtdePontos DESC