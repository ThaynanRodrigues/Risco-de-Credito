# 📊 Painel de Risco de Crédito e Inadimplência

## 🔎 Visão Geral

Este projeto tem como objetivo analisar o comportamento de crédito de clientes e identificar padrões associados à inadimplência, utilizando técnicas de análise de dados, engenharia de features e modelagem preditiva.

O resultado final é um dashboard interativo no Power BI que permite visualizar indicadores-chave e apoiar a tomada de decisão.

🔗 [Acessar o Dashboard no Power BI](https://app.powerbi.com/groups/me/reports/98f251a1-7e92-4cd0-b3e4-482c58a5cc59/cb0bff026137ce5c4933?experience=power-bi)

---

## 🎯 Objetivo

* Identificar fatores que influenciam a inadimplência
* Segmentar clientes por nível de risco
* Apoiar estratégias de concessão de crédito

---

## 🧱 Base de Dados

A base utilizada contém informações sobre:

* Idade
* Renda mensal
* Número de dependentes
* Histórico de atrasos
* Utilização de crédito
* Debt ratio

---

## ⚙️ Tratamento de Dados (ETL)

Etapas realizadas:

* Limpeza de valores inconsistentes
* Tratamento de valores nulos
* Criação de variáveis derivadas (features)
* Padronização de tipos de dados

---

## 🧠 Engenharia de Features

Foram criadas variáveis estratégicas como:

* Total de atrasos
* Indicador de atraso (já_atrasou)
* Faixa de renda
* Faixa etária
* Intensidade de crédito

---

## 🤖 Modelagem Preditiva

Modelos utilizados:

* Regressão Logística
* Random Forest

### Métricas avaliadas:

* Accuracy
* Recall
* ROC-AUC

O modelo foi capaz de identificar padrões relevantes de inadimplência.

---

## 📊 Dashboard (Power BI)

O dashboard foi desenvolvido para facilitar a análise visual e contém:

### 🔹 KPIs principais

* Total de clientes
* Total de inadimplentes
* Taxa de inadimplência
* Renda média
* Endividamento médio

### 🔹 Análises

* Inadimplência por faixa de renda
* Inadimplência por faixa etária
* Inadimplência por número de dependentes
* Inadimplência por histórico de atrasos

### 🔹 Segmentação de risco

* Classificação de clientes em baixo, médio e alto risco

---

## 💡 Insights Estratégicos

* O histórico de atrasos é o principal fator associado à inadimplência
* Clientes de menor renda apresentam maior concentração de risco
* O aumento no número de dependentes eleva a probabilidade de inadimplência
* O modelo permite identificar clientes com maior probabilidade de inadimplência

---

## 🖼️ Mockup do Dashboard

<img width="1438" height="809" alt="1" src="https://github.com/user-attachments/assets/00311d07-e6fb-4462-8a16-8283a97ddaf2" />

<img width="1438" height="809" alt="2" src="https://github.com/user-attachments/assets/2b115cb8-946c-4bba-9103-dd9f0ee2afc2" />

<img width="1437" height="805" alt="3" src="https://github.com/user-attachments/assets/716a3ea0-d39d-4f1d-aaa6-923b3fbd6046" />


---

## 🚀 Como Executar

### 1. Clone o repositório

```bash
git clone (https://github.com/ThaynanRodrigues/Risco-de-Credito.git)
```

### 2. Instale as dependências

```bash
pip install pandas numpy scikit-learn matplotlib seaborn
```

### 3. Execute os scripts

* ETL
* Modelagem

---

## 🛠️ Tecnologias Utilizadas

* Python
* Pandas
* Scikit-learn
* Power BI
* SQL

---

## 📌 Conclusão

O projeto demonstra como dados podem ser utilizados para prever inadimplência e apoiar decisões estratégicas em concessão de crédito.

---

## 👤 Autor  

**Thaynan Rodrigues**  
Analista e Cientista de Dados

## 🌐 Contato

🔗 [LinkedIn](https://www.linkedin.com/in/thaynanrodrigues/)
