-- Quantidade de Fornecedores que Devem e que não Devem e em Dia
SELECT
    COALESCE(SUM(CASE WHEN f.FOC_DIFERENCA > 0 THEN 1 END), 0) AS "A Receber", 
    COALESCE(SUM(CASE WHEN f.FOC_DIFERENCA = 0 THEN 1 END), 0) AS "Em Dia",
    COALESCE(SUM(CASE WHEN f.FOC_DIFERENCA < 0 THEN 1 END), 0) AS "A Pagar"
FROM FORNECEDORES f;