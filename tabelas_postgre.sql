CREATE TABLE staging_credito (
    SeriousDlqin2yrs INT,
    RevolvingUtilizationOfUnsecuredLines NUMERIC,
    age INT,
    NumberOfTime30_59DaysPastDueNotWorse INT,
    DebtRatio NUMERIC,
    MonthlyIncome NUMERIC,
    NumberOfOpenCreditLinesAndLoans INT,
    NumberOfTimes90DaysLate INT,
    NumberRealEstateLoansOrLines INT,
    NumberOfTime60_89DaysPastDueNotWorse INT,
    NumberOfDependents NUMERIC
);

SELECT COUNT(*) FROM staging_credito;

SELECT * FROM staging_credito LIMIT 5;

--

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    idade INT,
    renda_mensal NUMERIC,
    numero_dependentes NUMERIC
);

CREATE TABLE credito (
    id_credito SERIAL PRIMARY KEY,
    id_cliente INT,
    utilizacao_linhas_sem_garantia NUMERIC,
    debt_ratio NUMERIC,
    numero_linhas_credito INT,
    numero_emprestimos_imobiliarios INT
);

CREATE TABLE historico_atrasos (
    id_historico SERIAL PRIMARY KEY,
    id_cliente INT,
    atrasos_30_59 INT,
    atrasos_60_89 INT,
    atrasos_90 INT
);

CREATE TABLE inadimplencia (
    id_cliente INT,
    inadimplente INT
);

--

INSERT INTO clientes (idade, renda_mensal, numero_dependentes)
SELECT age, monthlyincome, numberofdependents
FROM staging_credito;

--

SELECT 'staging_credito' AS tabela, COUNT(*) AS total FROM staging_credito
UNION ALL
SELECT 'clientes' AS tabela, COUNT(*) AS total FROM clientes
UNION ALL
SELECT 'credito' AS tabela, COUNT(*) AS total FROM credito
UNION ALL
SELECT 'historico_atrasos' AS tabela, COUNT(*) AS total FROM historico_atrasos
UNION ALL
SELECT 'inadimplencia' AS tabela, COUNT(*) AS total FROM inadimplencia;

--

SELECT
    COUNT(*) AS total_clientes,
    SUM(inadimplente) AS total_inadimplentes,
    ROUND(100.0 * SUM(inadimplente) / COUNT(*), 2) AS taxa_inadimplencia_pct
FROM inadimplencia;

--

SELECT
    CASE
        WHEN idade < 30 THEN 'Menor que 30'
        WHEN idade BETWEEN 30 AND 39 THEN '30 a 39'
        WHEN idade BETWEEN 40 AND 49 THEN '40 a 49'
        WHEN idade BETWEEN 50 AND 59 THEN '50 a 59'
        ELSE '60 ou mais'
    END AS faixa_etaria,
    COUNT(*) AS total_clientes,
    SUM(i.inadimplente) AS total_inadimplentes,
    ROUND(100.0 * SUM(i.inadimplente) / COUNT(*), 2) AS taxa_inadimplencia_pct
FROM clientes c
JOIN inadimplencia i
    ON c.id_cliente = i.id_cliente
GROUP BY 1
ORDER BY 1;

--

SELECT
    COALESCE(numero_dependentes, 0) AS numero_dependentes,
    COUNT(*) AS total_clientes,
    SUM(i.inadimplente) AS total_inadimplentes,
    ROUND(100.0 * SUM(i.inadimplente) / COUNT(*), 2) AS taxa_inadimplencia_pct
FROM clientes c
JOIN inadimplencia i
    ON c.id_cliente = i.id_cliente
GROUP BY COALESCE(numero_dependentes, 0)
ORDER BY numero_dependentes;

--

SELECT
    i.inadimplente,
    ROUND(AVG(c.renda_mensal), 2) AS renda_media
FROM clientes c
JOIN inadimplencia i
    ON c.id_cliente = i.id_cliente
GROUP BY i.inadimplente
ORDER BY i.inadimplente;

--

SELECT
    i.inadimplente,
    ROUND(AVG(cr.debt_ratio), 4) AS debt_ratio_medio
FROM credito cr
JOIN inadimplencia i
    ON cr.id_cliente = i.id_cliente
GROUP BY i.inadimplente
ORDER BY i.inadimplente;

--

SELECT
    i.inadimplente,
    ROUND(AVG(h.atrasos_30_59), 2) AS media_atrasos_30_59,
    ROUND(AVG(h.atrasos_60_89), 2) AS media_atrasos_60_89,
    ROUND(AVG(h.atrasos_90), 2) AS media_atrasos_90
FROM historico_atrasos h
JOIN inadimplencia i
    ON h.id_cliente = i.id_cliente
GROUP BY i.inadimplente
ORDER BY i.inadimplente;

--

SELECT
    CASE
        WHEN renda_mensal IS NULL THEN 'Sem renda informada'
        WHEN renda_mensal < 2000 THEN 'Até 2 mil'
        WHEN renda_mensal >= 2000 AND renda_mensal < 5000 THEN '2 mil a 5 mil'
        WHEN renda_mensal >= 5000 AND renda_mensal < 10000 THEN '5 mil a 10 mil'
        ELSE 'Acima de 10 mil'
    END AS faixa_renda,
    COUNT(*) AS total_clientes,
    SUM(i.inadimplente) AS total_inadimplentes,
    ROUND(100.0 * SUM(i.inadimplente) / COUNT(*), 2) AS taxa_inadimplencia_pct
FROM clientes c
JOIN inadimplencia i
    ON c.id_cliente = i.id_cliente
GROUP BY 1
ORDER BY 1;

--

CREATE OR REPLACE VIEW vw_base_analitica_credito AS
SELECT
    c.id_cliente,
    c.idade,
    c.renda_mensal,
    c.numero_dependentes,
    cr.utilizacao_linhas_sem_garantia,
    cr.debt_ratio,
    cr.numero_linhas_credito,
    cr.numero_emprestimos_imobiliarios,
    h.atrasos_30_59,
    h.atrasos_60_89,
    h.atrasos_90,
    i.inadimplente
FROM clientes c
JOIN credito cr
    ON c.id_cliente = cr.id_cliente
JOIN historico_atrasos h
    ON c.id_cliente = h.id_cliente
JOIN inadimplencia i
    ON c.id_cliente = i.id_cliente;

	SELECT * 
FROM vw_base_analitica_credito
LIMIT 10;

SELECT COUNT(*) 
FROM vw_base_analitica_credito;
