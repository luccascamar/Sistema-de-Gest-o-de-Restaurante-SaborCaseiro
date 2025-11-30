-- Criação e seleção do banco
CREATE DATABASE IF NOT EXISTS saborcaseiro;
USE saborcaseiro;

-- CLIENTE
CREATE TABLE IF NOT EXISTS cliente (
  cliente_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  telefone VARCHAR(20),
  email VARCHAR(100)
);

-- FUNCIONARIO
CREATE TABLE IF NOT EXISTS funcionario (
  funcionario_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cargo VARCHAR(50) NOT NULL
);

-- MESA
CREATE TABLE IF NOT EXISTS mesa (
  mesa_id INT AUTO_INCREMENT PRIMARY KEY,
  identificacao VARCHAR(10) UNIQUE NOT NULL,
  capacidade INT NOT NULL,
  status VARCHAR(20) DEFAULT 'livre'
);

-- PRATO
CREATE TABLE IF NOT EXISTS prato (
  prato_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  categoria VARCHAR(50),
  preco DECIMAL(10,2) NOT NULL
);

-- INGREDIENTE
CREATE TABLE IF NOT EXISTS ingrediente (
  ingrediente_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  unidade_medida VARCHAR(20),
  qtd_estoque DECIMAL(10,2) DEFAULT 0
);

-- PRATO_INGREDIENTE (N:N)
CREATE TABLE IF NOT EXISTS prato_ingrediente (
  prato_id INT NOT NULL,
  ingrediente_id INT NOT NULL,
  qtd_por_prato DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (prato_id, ingrediente_id),
  FOREIGN KEY (prato_id) REFERENCES prato(prato_id),
  FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(ingrediente_id)
);

-- PEDIDO
CREATE TABLE IF NOT EXISTS pedido (
  pedido_id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  funcionario_id INT NOT NULL,
  mesa_id INT,
  tipo VARCHAR(20) NOT NULL,        -- exemplo: 'salão' ou 'delivery'
  status VARCHAR(20) DEFAULT 'aberto',
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  entregue_em DATETIME,
  FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
  FOREIGN KEY (funcionario_id) REFERENCES funcionario(funcionario_id),
  FOREIGN KEY (mesa_id) REFERENCES mesa(mesa_id)
);

-- PEDIDO_ITEM (N:N entre pedido e prato resolvido)
CREATE TABLE IF NOT EXISTS pedido_item (
  pedido_item_id INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id INT NOT NULL,
  prato_id INT NOT NULL,
  quantidade INT NOT NULL,
  preco_unitario DECIMAL(10,2) NOT NULL,
  observacao VARCHAR(255),
  FOREIGN KEY (pedido_id) REFERENCES pedido(pedido_id),
  FOREIGN KEY (prato_id) REFERENCES prato(prato_id)
);

-- RESERVA
CREATE TABLE IF NOT EXISTS reserva (
  reserva_id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  mesa_id INT NOT NULL,
  data_reserva DATE NOT NULL,
  hora_reserva TIME NOT NULL,
  qtd_pessoas INT NOT NULL,
  status VARCHAR(20) DEFAULT 'confirmada',
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
  FOREIGN KEY (mesa_id) REFERENCES mesa(mesa_id)
);
