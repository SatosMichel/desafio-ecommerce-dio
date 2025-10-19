# Desafio de Projeto: Projeto Lógico de Banco de Dados para E-commerce

Este repositório contém a implementação completa do Desafio de Projeto Lógico de Banco de Dados da DIO, focado em um cenário de e-commerce. O projeto abrange desde a criação do esquema SQL até a inserção de dados e a elaboração de consultas complexas para análise.

## Sobre o Projeto e sua Evolução

Este projeto tem uma história interessante. Ele nasceu como uma resposta ao desafio de **refinar um modelo conceitual** de um e-commerce. A primeira versão do esquema, que pode ser vista como a base deste trabalho, foi criada para resolver três regras de negócio específicas:

1.  **Cliente PF e PJ:** Criar uma estrutura que permitisse o cadastro de Pessoas Físicas e Jurídicas, sem que um cliente pudesse ser ambos.
2.  **Múltiplas Formas de Pagamento:** Permitir que um cliente associasse várias formas de pagamento à sua conta.
3.  **Rastreio de Entrega:** Implementar um sistema para acompanhar o status e o código de rastreio de cada entrega.

Após essa etapa inicial, o escopo foi expandido para o **Desafio de Projeto Lógico**. O objetivo agora não era apenas modelar, mas construir, popular e consultar o banco de dados para responder a perguntas de negócio mais profundas, típicas de um cenário de marketplace.

Para isso, o esquema inicial foi **ampliado**, adicionando novas entidades como `Vendedores`, `Fornecedores` e `Estoque`. Por isso, o script `1_schema_creation.sql` contém tanto a solução do primeiro desafio quanto os acréscimos necessários para esta versão final e mais completa. O resultado é um projeto que demonstra não apenas a modelagem, mas toda a jornada de implementação e análise de dados.

## Estrutura do Projeto

O projeto está dividido em três scripts SQL principais:

1.  **`1_schema_creation.sql`**: Contém todo o código DDL (`CREATE TABLE`) para construir a estrutura do banco de dados, incluindo tabelas, chaves primárias, chaves estrangeiras e constraints.
2.  **`2_data_insertion.sql`**: Contém o código DML (`INSERT INTO`) para popular o banco de dados com dados de exemplo, permitindo que as consultas sejam testadas e retornem resultados significativos.
3.  **`3_queries.sql`**: Apresenta uma série de consultas SQL elaboradas para responder a perguntas de negócio. As queries utilizam cláusulas como `JOIN`, `WHERE`, `GROUP BY`, `HAVING` e `ORDER BY` para extrair informações valiosas dos dados.

## Consultas de Negócio Desenvolvidas

As seguintes perguntas foram formuladas e respondidas com SQL no arquivo `3_queries.sql`:

* Quantos pedidos foram feitos por cada cliente?
* Qual a relação de produtos, seus fornecedores e seus respectivos estoques?
* Existe algum vendedor que também atua como fornecedor?
* Qual o valor total gasto por cliente, exibindo apenas os que gastaram mais de R$ 1000?
* Quais clientes compraram produtos da categoria 'Eletrônicos' e qual o status da entrega desses pedidos?

Este projeto serve como um portfólio prático de habilidades em modelagem de dados, SQL e análise de negócio.
