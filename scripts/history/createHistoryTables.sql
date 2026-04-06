CREATE TABLE DEV.HQUALIDADES (
    hqal_id NUMBER(6,0) NOT NULL,
    hqal_nome VARCHAR(255) CONSTRAINT CK_HQAL_NN_01 NOT NULL,
    hqal_dt_entrada DATE CONSTRAINT CK_HQAL_NN_02 NOT NULL
);
/
ALTER TABLE DEV.HQUALIDADES ADD CONSTRAINT PK_HQAL PRIMARY KEY (hqal_id, hqal_dt_entrada);
/
CREATE TABLE DEV.HFORNECEDORES (
    hfoc_id NUMBER(6,0) NOT NULL,
    hfoc_nome VARCHAR(255) CONSTRAINT CK_HFOC_NN_01 NOT NULL,
    hfoc_diferenca NUMBER(5,2) DEFAULT 0 CONSTRAINT CK_HFOC_NN_02 NOT NULL,
    hfoc_dt_entrada DATE CONSTRAINT CK_HFOC_NN_03 NOT NULL
);
/
ALTER TABLE DEV.HFORNECEDORES ADD CONSTRAINT PK_HFOC PRIMARY KEY (hfoc_id, hfoc_dt_entrada);
/
CREATE TABLE DEV.HSTATUS (
    hstt_id NUMBER(6,0) NOT NULL,
    hstt_nome VARCHAR(255) CONSTRAINT CK_HSTT_NN_01 NOT NULL,
    hstt_dt_entrada DATE CONSTRAINT CK_HSTT_NN_02 NOT NULL
);
/
ALTER TABLE DEV.HSTATUS ADD CONSTRAINT PK_HSTT PRIMARY KEY (hstt_id, hstt_dt_entrada);
/
CREATE TABLE DEV.HPRODUTOS (
    hpdt_id NUMBER(6,0) NOT NULL,
    hpdt_nome VARCHAR(255) CONSTRAINT CK_HPDT_NN_01 NOT NULL,
    hpdt_preco NUMBER(4,2) CONSTRAINT CK_HPDT_NN_02 NOT NULL,
    hpdt_dt_entrada DATE CONSTRAINT CK_HPDT_NN_03 NOT NULL
);
/
ALTER TABLE DEV.HPRODUTOS ADD CONSTRAINT PK_HPDT PRIMARY KEY (hpdt_id, hpdt_dt_entrada);
/
CREATE TABLE DEV.HPEDIDOS (
    hpdd_id NUMBER(6,0) NOT NULL,
    hpdd_data DATE CONSTRAINT CK_HPDD_NN_01 NOT NULL,
    hpdd_stt_id NUMBER(6,0) CONSTRAINT CK_HPDD_NN_02 NOT NULL,
    hpdd_foc_id NUMBER(6,0) CONSTRAINT CK_HPDD_NN_03 NOT NULL,
    hpdd_valor_total NUMBER(5,2) CONSTRAINT CK_HPDD_NN_04 NOT NULL,
    hpdd_valor_pago NUMBER(5,2) CONSTRAINT CK_HPDD_NN_05 NOT NULL,
    hpdd_qal_id NUMBER(6,0),
    hpdd_dt_entrada DATE CONSTRAINT CK_HPDD_NN_06 NOT NULL
);
/
ALTER TABLE DEV.HPEDIDOS ADD CONSTRAINT PK_HPDD PRIMARY KEY (hpdd_id, hpdd_dt_entrada);
/
CREATE TABLE DEV.HPEDIDOS_PRODUTOS (
    hppd_pdd_id NUMBER(6,0) NOT NULL,
    hppd_pdt_id NUMBER(6,0) NOT NULL,
    hppd_quantidade NUMBER(6,0) CONSTRAINT CK_HPPD_NN_01 NOT NULL,
    hppd_dt_entrada DATE CONSTRAINT CK_HPPD_NN_02 NOT NULL
);
/
ALTER TABLE DEV.HPEDIDOS_PRODUTOS ADD CONSTRAINT PK_HPPD PRIMARY KEY (hppd_pdd_id, hppd_pdt_id, hppd_dt_entrada);
/
COMMENT ON TABLE DEV.HQUALIDADES IS 'Tabela com as qualidades dos produtos';
COMMENT ON COLUMN DEV.HQUALIDADES.hqal_id IS 'Chave primária, identificador único da qualidade';
COMMENT ON COLUMN DEV.HQUALIDADES.hqal_nome IS 'Termo para indicar a qualidade do produto';
COMMENT ON COLUMN DEV.HQUALIDADES.hqal_dt_entrada IS 'Data de entrada do registro na tabela';

COMMENT ON TABLE DEV.HFORNECEDORES IS 'Tabela com os fornecedores dos produtos';
COMMENT ON COLUMN DEV.HFORNECEDORES.hfoc_id IS 'Chave primária, identificador único do fornecedor';
COMMENT ON COLUMN DEV.HFORNECEDORES.hfoc_nome IS 'Nome do fornecedor';
COMMENT ON COLUMN DEV.HFORNECEDORES.hfoc_diferenca IS 'Indica o saldo financeiro com o fornecedor: valores positivos representam débitos a pagar, enquanto valores negativos indicam pagamentos excedentes, que deveHm hser abatidos em pedidos futuros';
COMMENT ON COLUMN DEV.HFORNECEDORES.hfoc_dt_entrada IS 'Data de entrada do registro na tabela';

COMMENT ON TABLE DEV.HSTATUS IS 'Tabela com os status de entrega dos pedidos';
COMMENT ON COLUMN DEV.HSTATUS.hstt_id IS 'Chave primária, identificador único do status';
COMMENT ON COLUMN DEV.HSTATUS.hstt_nome IS 'Termo para indicar o status de entrega de um pedido';
COMMENT ON COLUMN DEV.HSTATUS.hstt_dt_entrada IS 'Data de entrada do registro na tabela';

COMMENT ON TABLE DEV.HPRODUTOS IS 'Tabela com os produtos';
COMMENT ON COLUMN DEV.HPRODUTOS.hpdt_id IS 'Chave primária, identificador único do produto';
COMMENT ON COLUMN DEV.HPRODUTOS.hpdt_nome IS 'Nome do produto';
COMMENT ON COLUMN DEV.HPRODUTOS.hpdt_preco IS 'Preço unitário do produto';
COMMENT ON COLUMN DEV.HPRODUTOS.hpdt_dt_entrada IS 'Data de entrada do registro na tabela';

COMMENT ON TABLE DEV.HPEDIDOS IS 'Tabela com os pedidos';
COMMENT ON COLUMN DEV.HPEDIDOS.hpdd_id IS 'Chave primária, identificador único do pedido';
COMMENT ON COLUMN DEV.HPEDIDOS.hpdd_data IS 'Data em que o pedido foi realizado';
COMMENT ON COLUMN DEV.HPEDIDOS.hpdd_stt_id IS 'Chave estrangeira referente a STATUS, status de entrega do pedido';
COMMENT ON COLUMN DEV.HPEDIDOS.hpdd_foc_id IS 'Chave estrangeira referente a FORNECEDORES, fornecedor dos produtos pedidos';
COMMENT ON COLUMN DEV.HPEDIDOS.hpdd_valor_total IS 'Valor total do pedido, soma dos preços unitários multiplicados pelas quantidades de cada produto pedido';
COMMENT ON COLUMN DEV.HPEDIDOS.hpdd_valor_pago IS 'Valor pago do valor total do pedido';
COMMENT ON COLUMN DEV.HPEDIDOS.hpdd_qal_id IS 'Chave estrangeira referente a QUALIDADES, qualidade do produto';
COMMENT ON COLUMN DEV.HPEDIDOS.hpdd_dt_entrada IS 'Data de entrada do registro na tabela';

COMMENT ON TABLE DEV.HPEDIDOS_PRODUTOS IS 'Tabela de junção entre pedidos e produtos';
COMMENT ON COLUMN DEV.HPEDIDOS_PRODUTOS.hppd_pdd_id IS 'Chave primária composta, chave estrangeira referente a PEDIDOS';
COMMENT ON COLUMN DEV.HPEDIDOS_PRODUTOS.hppd_pdt_id IS 'Chave primária composta, chave estrangeira referente a PRODUTOS';
COMMENT ON COLUMN DEV.HPEDIDOS_PRODUTOS.hppd_quantidade IS 'Quantidade de produtos pedidos';
COMMENT ON COLUMN DEV.HPEDIDOS_PRODUTOS.hppd_dt_entrada IS 'Data de entrada do registro na tabela';