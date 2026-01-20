-- Quantos produtos são de rpg?

SELECT  DescCategoriaProduto,
        count(DescCategoriaProduto) AS qtdProdutosCategoria

FROM produtos

WHERE DescCategoriaProduto = 'rpg'

GROUP BY DescCategoriaProduto
