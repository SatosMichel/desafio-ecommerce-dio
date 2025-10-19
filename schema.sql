-- Criando o banco de dados para o projeto
CREATE DATABASE ecommerce;
USE ecommerce;

-- Tabela principal de Clientes (dados comuns)
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    endereco VARCHAR(255) NOT NULL,
    contato VARCHAR(20) NOT NULL,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL,
    CONSTRAINT chk_tipo_cliente CHECK (tipo_cliente IN ('PF', 'PJ'))
);

-- Tabela especializada para Pessoa Física (PF)
CREATE TABLE ClientePF (
    id_cliente INT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE,
    CONSTRAINT fk_clientepf_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabela especializada para Pessoa Jurídica (PJ)
CREATE TABLE ClientePJ (
    id_cliente INT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    cnpj CHAR(14) NOT NULL UNIQUE,
    CONSTRAINT fk_clientepj_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabela de Produtos
CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    valor DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(100)
);

-- Tabela de Formas de Pagamento (associada ao cliente)
CREATE TABLE FormasPagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo ENUM('Boleto', 'Cartão de Crédito', 'PIX') NOT NULL,
    detalhes_pagamento VARCHAR(255), -- Ex: '**** **** **** 1234' para cartão
    CONSTRAINT fk_formapagamento_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE
);

-- Tabela de Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_pagamento_utilizado INT NOT NULL, -- Forma de pagamento escolhida para este pedido
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_pedido ENUM('Em processamento', 'Aprovado', 'Cancelado') NOT NULL DEFAULT 'Em processamento',
    valor_total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    CONSTRAINT fk_pedido_pagamento FOREIGN KEY (id_pagamento_utilizado) REFERENCES FormasPagamento(id_pagamento)
);

-- Tabela de Entrega (associada ao pedido)
CREATE TABLE Entregas (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL UNIQUE, -- Garante que cada pedido tenha apenas uma entrega
    status_entrega ENUM('Preparando', 'Enviado', 'Entregue', 'Falha na entrega') NOT NULL DEFAULT 'Preparando',
    codigo_rastreio VARCHAR(50),
    data_envio DATETIME,
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido) ON DELETE CASCADE
);

-- Tabela de Itens do Pedido (relação N:M entre Pedidos e Produtos)
CREATE TABLE PedidoItens (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- ON DELETE CASCADE: Se um cliente for removido, suas formas de pagamento e entregas associadas também serão.
