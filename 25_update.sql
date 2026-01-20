SELECT *
FROM relatorio_diario;

UPDATE relatorio_diario
SET qtdTransacoes = 100
WHERE qtdTransacoes = 15;

SELECT * FROM relatorio_diario;