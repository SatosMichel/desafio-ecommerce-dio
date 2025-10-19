USE ecommerce_dio;

-- Inserindo Fornecedores
INSERT INTO Fornecedores (razao_social, cnpj, contato) VALUES
('TechDistribuidora Ltda', '11223344000155', '11987654321'),
('Moda & Cia', '55667788000199', '21912345678');

-- Inserindo Vendedores (um deles tem o mesmo CNPJ de um fornecedor)
INSERT INTO Vendedores (razao_social, nome_fantasia, cnpj, localizacao, contato) VALUES
('Eletrônicos do Zé', 'Zé Eletrônicos', '99887766000111', 'São Paulo', '11999998888'),
('TechDistribuidora Ltda', 'Tech Distribuidora', '11223344000155', 'Rio de Janeiro', '21988887777'); -- Vendedor que também é fornecedor

-- Inserindo Produtos
INSERT INTO Produtos (nome_produto, categoria, descricao, valor) VALUES
('Fone de Ouvido Bluetooth', 'Eletrônicos', 'Fone sem fio com cancelamento de ruído', 399.90),
('Camiseta Estampada', 'Vestuário', 'Camiseta de algodão com estampa geek', 89.90),
('Notebook Gamer', 'Eletrônicos', 'Notebook com placa de vídeo dedicada', 5499.00),
('Tênis de Corrida', 'Vestuário', 'Tênis leve para atividades físicas', 299.50);

-- Ligando Produtos a Fornecedores
INSERT INTO Produto_Fornecedor (id_produto, id_fornecedor) VALUES
(1, 1), (3, 1), (2, 2), (4, 2);

-- Ligando Produtos a Vendedores
INSERT INTO Produto_Vendedor (id_produto, id_vendedor, quantidade) VALUES
(1, 1, 50), (3, 2, 10);

-- Inserindo Estoques
INSERT INTO Estoque (localizacao, quantidade) VALUES
('Galpão SP', 100), ('Galpão RJ', 50);

-- Ligando Produtos a Estoques
INSERT INTO Produto_Estoque (id_produto, id_estoque) VALUES
(1, 1), (2, 1), (3, 2), (4, 2);

-- Inserindo Clientes
INSERT INTO Clientes (endereco, contato, tipo_cliente) VALUES
('Rua das Flores, 123', '11911112222', 'PF'),
('Avenida Principal, 456', '21933334444', 'PF'),
('Rua da Empresa, 789', '31955556666', 'PJ');

-- Inserindo dados específicos de PF e PJ
INSERT INTO ClientePF (id_cliente, nome_completo, cpf) VALUES
(1, 'Maria Silva', '12345678901'),
(2, 'João Santos', '09876543210');
INSERT INTO ClientePJ (id_cliente, razao_social, cnpj) VALUES
(3, 'Construções & Cia', '12345678000190');

-- Inserindo Pedidos
INSERT INTO Pedidos (id_cliente, status_pedido, frete) VALUES
(1, 'Aprovado', 25.50),
(2, 'Em processamento', 15.00),
(1, 'Enviado', 30.00),
(3, 'Aprovado', 55.00);

-- Inserindo Itens nos Pedidos
INSERT INTO Pedido_Itens (id_pedido, id_produto, quantidade, valor_unitario) VALUES
(1, 1, 1, 399.90), -- Pedido 1 (Maria) tem 1 Fone
(1, 2, 2, 89.90),  -- e 2 Camisetas
(2, 4, 1, 299.50), -- Pedido 2 (João) tem 1 Tênis
(3, 3, 1, 5499.00),-- Pedido 3 (Maria) tem 1 Notebook
(4, 3, 2, 5300.00); -- Pedido 4 (Construções) tem 2 Notebooks com desconto

-- Inserindo Pagamentos
INSERT INTO Pagamentos (id_cliente, id_pedido, tipo_pagamento, status, valor) VALUES
(1, 1, 'PIX', 'Confirmado', 579.70), -- 399.90 + 2*89.90 + 25.50 de frete
(2, 2, 'Boleto', 'Pendente', 314.50),
(1, 3, 'Cartão de Crédito', 'Confirmado', 5529.00),
(3, 4, 'Boleto', 'Confirmado', 10655.00);

-- Inserindo Entregas
INSERT INTO Entregas (id_pedido, status_entrega, codigo_rastreio) VALUES
(1, 'Entregue', 'BR123456789PT'),
(3, 'Enviado', 'BR987654321PT'),
(4, 'Preparando', NULL);