USE ecommerce_dio;

-- PERGUNTA 1: Quantos pedidos foram feitos por cada cliente?
-- Utiliza: SELECT, COUNT, JOIN, GROUP BY
SELECT 
    c.id_cliente,
    COALESCE(pf.nome_completo, pj.razao_social) AS nome_cliente,
    COUNT(p.id_pedido) AS total_pedidos
FROM Clientes c
LEFT JOIN ClientePF pf ON c.id_cliente = pf.id_cliente
LEFT JOIN ClientePJ pj ON c.id_cliente = pj.id_cliente
JOIN Pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;


-- PERGUNTA 2: Relação de produtos, fornecedores e estoques.
-- Utiliza: SELECT, múltiplos JOINs
SELECT 
    p.nome_produto,
    p.categoria,
    f.razao_social AS fornecedor,
    e.localizacao AS local_estoque,
    pe.quantidade
FROM Produtos p
JOIN Produto_Fornecedor pf ON p.id_produto = pf.id_produto
JOIN Fornecedores f ON pf.id_fornecedor = f.id_fornecedor
JOIN Produto_Estoque pe ON p.id_produto = pe.id_produto
JOIN Estoque e ON pe.id_estoque = e.id_estoque
ORDER BY p.nome_produto;


-- PERGUNTA 3: Algum vendedor também é fornecedor?
-- Utiliza: SELECT, INNER JOIN para encontrar a intersecção
SELECT 
    v.razao_social AS nome_vendedor_fornecedor,
    v.cnpj,
    v.contato
FROM Vendedores v
INNER JOIN Fornecedores f ON v.cnpj = f.cnpj;


-- PERGUNTA 4: Qual o valor total gasto por cliente, mostrando apenas clientes que gastaram mais de R$ 1000,00?
-- Utiliza: SELECT com atributo derivado (SUM), JOIN, GROUP BY, HAVING, ORDER BY
SELECT 
    c.id_cliente,
    COALESCE(pf.nome_completo, pj.razao_social) AS nome_cliente,
    SUM(pg.valor) AS total_gasto
FROM Clientes c
JOIN Pagamentos pg ON c.id_cliente = pg.id_cliente
WHERE pg.status = 'Confirmado'
GROUP BY c.id_cliente
HAVING total_gasto > 1000
ORDER BY total_gasto DESC;


-- PERGUNTA 5: Listar todos os clientes que compraram produtos da categoria 'Eletrônicos', com o status da entrega.
-- Utiliza: SELECT, WHERE, múltiplos JOINs
SELECT DISTINCT
    c.id_cliente,
    COALESCE(pf.nome_completo, pj.razao_social) AS nome_cliente,
    p.nome_produto,
    ped.id_pedido,
    e.status_entrega
FROM Clientes c
LEFT JOIN ClientePF pf ON c.id_cliente = pf.id_cliente
LEFT JOIN ClientePJ pj ON c.id_cliente = pj.id_cliente
JOIN Pedidos ped ON c.id_cliente = ped.id_cliente
JOIN Pedido_Itens pi ON ped.id_pedido = pi.id_pedido
JOIN Produtos p ON pi.id_produto = p.id_produto
LEFT JOIN Entregas e ON ped.id_pedido = e.id_pedido
WHERE p.categoria = 'Eletrônicos'
ORDER BY nome_cliente;