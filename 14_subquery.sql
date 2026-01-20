-- -- Lista de transações com o produto “Resgatar Ponei”;

SELECT *

FROM transacao_produto AS t1

WHERE t1.IdProduto IS (
    SELECT IdProduto
    FROM produtos
    WHERE DescNomeProduto = 'Resgatar Ponei'
)