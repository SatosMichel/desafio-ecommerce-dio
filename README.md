# Desafio de Projeto: Refinando um Esquema de Banco de Dados para E-commerce

Este repositório contém a solução para o desafio de projeto de banco de dados, focado em refinar um modelo conceitual para um sistema de e-commerce.

## Descrição do Contexto

O objetivo foi aprimorar um modelo de dados de e-commerce existente, implementando novas regras de negócio para gerenciar clientes, pagamentos e entregas de forma mais robusta e escalável.

## Requisitos do Desafio

O esquema foi desenvolvido para atender aos seguintes pontos:

1.  **Cliente PF e PJ:** O sistema deve ser capaz de cadastrar tanto clientes Pessoa Física (PF) quanto Pessoa Jurídica (PJ). Um mesmo cliente não pode ser ambos, e cada tipo possui informações específicas (CPF para PF, CNPJ para PJ).
    * **Solução:** Foi utilizada uma abordagem de **generalização/especialização**, com uma tabela `Clientes` genérica e duas tabelas especialistas, `ClientePF` e `ClientePJ`.

2.  **Múltiplas Formas de Pagamento:** Um cliente pode ter mais de uma forma de pagamento cadastrada em sua conta.
    * **Solução:** Foi criada a tabela `FormasPagamento` com um relacionamento **1:N (um-para-muitos)** com a tabela `Clientes`.

3.  **Status e Código de Rastreio da Entrega:** Cada pedido deve possuir um status de entrega atualizado e um código de rastreio para acompanhamento.
    * **Solução:** Foi criada a tabela `Entregas` com um relacionamento **1:1 (um-para-um)** com a tabela `Pedidos`, contendo os campos `status_entrega` e `codigo_rastreio`.

## Esquema SQL

O código para a criação de todas as tabelas e seus relacionamentos está disponível no arquivo [schema.sql](./schema.sql). O dialeto utilizado é o MySQL.
