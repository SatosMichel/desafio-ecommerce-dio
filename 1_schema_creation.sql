-- Criando o banco de dados para o projeto de e-commerce
CREATE DATABASE IF NOT EXISTS ecommerce_dio;
USE ecommerce_dio;

-- Tabela Fornecedor
CREATE TABLE Fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    contato VARCHAR(20) NOT NULL
);

-- Tabela Vendedor Terceirizado
CREATE TABLE Vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    cnpj CHAR(14) UNIQUE,
    cpf CHAR(11) UNIQUE,
    localizacao VARCHAR(255),
    contato VARCHAR(20) NOT NULL
);

-- Tabela Produtos
CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(255) NOT NULL,
    categoria ENUM('Eletrônicos', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    descricao TEXT,
    valor DECIMAL(10, 2) NOT NULL
);

-- Tabela Produto_Fornecedor (Relacionamento N:M)
CREATE TABLE Produto_Fornecedor (
    id_produto INT,
    id_fornecedor INT,
    PRIMARY KEY (id_produto, id_fornecedor),
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    CONSTRAINT fk_fornecedor_produto FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);

-- Tabela Produto_Vendedor (Relacionamento N:M)
CREATE TABLE Produto_Vendedor (
    id_produto INT,
    id_vendedor INT,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (id_produto, id_vendedor),
    CONSTRAINT fk_produto_vendedor FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    CONSTRAINT fk_vendedor_produto FOREIGN KEY (id_vendedor) REFERENCES Vendedores(id_vendedor)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    localizacao VARCHAR(255) NOT NULL,
    quantidade INT DEFAULT 0
);

-- Tabela Produto_Estoque (Relacionamento N:M)
CREATE TABLE Produto_Estoque (
    id_produto INT,
    id_estoque INT,
    PRIMARY KEY (id_produto, id_estoque),
    CONSTRAINT fk_produto_estoque FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    CONSTRAINT fk_estoque_produto FOREIGN KEY (id_estoque) REFERENCES Estoque(id_estoque)
);

-- Tabela Clientes (Generalização)
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    endereco VARCHAR(255) NOT NULL,
    contato VARCHAR(20) NOT NULL,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL
);

-- Tabela Cliente PF (Especialização)
CREATE TABLE ClientePF (
    id_cliente INT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    CONSTRAINT fk_clientepf_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabela Cliente PJ (Especialização)
CREATE TABLE ClientePJ (
    id_cliente INT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    CONSTRAINT fk_clientepj_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabela Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    status_pedido ENUM('Em processamento', 'Aprovado', 'Cancelado', 'Enviado') NOT NULL DEFAULT 'Em processamento',
    descricao VARCHAR(255),
    frete DECIMAL(10, 2) DEFAULT 0,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabela Pagamentos
CREATE TABLE Pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_pedido INT NOT NULL,
    tipo_pagamento ENUM('Boleto', 'Cartão de Crédito', 'PIX') NOT NULL,
    status ENUM('Pendente', 'Confirmado', 'Falhou') DEFAULT 'Pendente',
    valor DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_pagamento_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Tabela Entrega
CREATE TABLE Entregas (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL UNIQUE,
    status_entrega ENUM('Preparando', 'Enviado', 'Entregue', 'Problema na entrega') NOT NULL DEFAULT 'Preparando',
    codigo_rastreio VARCHAR(50),
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Tabela Itens do Pedido (Relacionamento N:M)
CREATE TABLE Pedido_Itens (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);