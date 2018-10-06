CREATE TABLE produto(
  cod_produto  INTEGER      NOT NULL,
  descricao    VARCHAR(20)  NOT NULL,
  quantidade   INTEGER      NOT NULL,
  valor_compra NUMERIC(6,2) NOT NULL,
  valor_venda  NUMERIC(6,2) NOT NULL,
  CONSTRAINT pk_produto
    PRIMARY KEY(cod_produto)
);

CREATE TABLE servico(
  cod_servico INTEGER      NOT NULL,
  descricao   VARCHAR(20)  NOT NULL,
  valor       NUMERIC(6,2) NOT NULL,
  CONSTRAINT pk_servico
    PRIMARY KEY(cod_servico)
);

CREATE TABLE servico_produto(
  servico_cod_servico INTEGER NOT NULL,
  produto_cod_produto INTEGER NOT NULL,
  CONSTRAINT pk_servico_produto
    PRIMARY KEY(servico_cod_servico,produto_cod_produto),
  CONSTRAINT fk_servico_produto_servico
    FOREIGN KEY(servico_cod_servico)
    REFERENCES servico(cod_servico),
  CONSTRAINT fk_servico_produto_produto
    FOREIGN KEY(produto_cod_produto)
    REFERENCES produto(cod_produto)
);

CREATE TABLE marca(
  cod_marca INTEGER     NOT NULL,
  nome      VARCHAR(20) NOT NULL,
  CONSTRAINT pk_marca
    PRIMARY KEY(cod_marca)
);

CREATE TABLE modelo(
  cod_modelo      INTEGER     NOT NULL,
  nome            VARCHAR(20) NOT NULL,
  marca_cod_marca INTEGER     NOT NULL,
  CONSTRAINT pk_modelo
    PRIMARY KEY(cod_modelo),
  CONSTRAINT fk_modelo_marca
    FOREIGN KEY(marca_cod_marca)
    REFERENCES marca(cod_marca)
);

CREATE TABLE cliente(
  cod_cliente INTEGER     NOT NULL,
  nome        VARCHAR(20) NOT NULL,
  cep         CHAR(8)     NOT NULL,
  bairro      VARCHAR(20) NOT NULL,
  cidade      VARCHAR(25) NOT NULL,
  uf          CHAR(2)     NOT NULL,
  rua         VARCHAR(25) NOT NULL,
  CONSTRAINT pk_cliente
    PRIMARY KEY(cod_cliente)
);

CREATE TABLE telefone(
  telefone            CHAR(10) NOT NULL,
  cliente_cod_cliente INTEGER  NOT NULL,
  CONSTRAINT pk_telefone
    PRIMARY KEY(telefone,cliente_cod_cliente),
  CONSTRAINT fk_telefone_cliente
    FOREIGN KEY(cliente_cod_cliente)
    REFERENCES cliente(cod_cliente)
);

CREATE TABLE carro(
  placa CHAR(8) NOT NULL,
  ano_fabricacao CHAR(4) NOT NULL,
  cliente_cod_cliente INTEGER NOT NULL,
  modelo_cod_modelo INTEGER NOT NULL,
  CONSTRAINT pk_carro
    PRIMARY KEY(placa),
  CONSTRAINT fk_carro_cliente
    FOREIGN KEY(cliente_cod_cliente)
    REFERENCES cliente(cod_cliente),
  CONSTRAINT fk_carro_modelo
    FOREIGN KEY(modelo_cod_modelo)
    REFERENCES modelo(cod_modelo)
);

CREATE TABLE os(
  cod_os              INTEGER NOT NULL,
  data_inicio         DATE    NOT NULL,
  data_fim            DATE    NOT NULL,
  total               INTEGER NOT NULL,
  carro_placa         CHAR(8) NOT NULL,
  cliente_cod_cliente INTEGER NOT NULL,
  CONSTRAINT pk_os
    PRIMARY KEY(cod_os),
  CONSTRAINT fk_os_carro
    FOREIGN KEY(carro_placa)
    REFERENCES carro(placa),
  CONSTRAINT fk_os_cliente
    FOREIGN KEY(cliente_cod_cliente)
    REFERENCES cliente(cod_cliente)
);

CREATE TABLE itens_os(
  os_cod_os           INTEGER      NOT NULL,
  servico_cod_servico INTEGER      NOT NULL,
  quantidade          INTEGER      NOT NULL,
  valor               NUMERIC(6,2) NOT NULL,
  CONSTRAINT pk_itens_os
    PRIMARY KEY(os_cod_os,servico_cod_servico),
  CONSTRAINT fk_itens_os_servico
    FOREIGN KEY(os_cod_os)
    REFERENCES os(cod_os),
  CONSTRAINT fk_itens_os_servicos
    FOREIGN KEY(servico_cod_servico)
    REFERENCES servico(cod_servico)
);