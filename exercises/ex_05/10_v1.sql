-- 10. Como foi a curva de Churn do curso de SQL?
-- forma menos confiável de fazer curva de churn porque ele não mapeia a retenção do usuário em si
-- reflete melhor uma curva de público/dia ou de engajamento

SELECT  substr(DtCriacao, 1, 10) AS dia,
        count(DISTINCT IdCliente) AS clienteDia

FROM transacoes

WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-30'

GROUP BY dia