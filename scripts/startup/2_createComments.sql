COMMENT ON COLUMN DEV.QUALIDADES IS 'Tabela com as qualidades dos produtos';
COMMENT ON COLUMN DEV.QUALIDADES.qal_id IS 'Chave Primária, identificador único de qualidade';
COMMENT ON COLUMN DEV.QUALIDADES.qal_nome IS 'Termo para indicar a qualidade do produto';

COMMENT ON COLUMN DEV.FORNECEDORES IS 'Tabela com os fornecedores dos produtos';
COMMENT ON COLUMN DEV.FORNECEDORES.foc_id IS 'Chave Primária, identificador único de qualidade';
COMMENT ON COLUMN DEV.FORNECEDORES.foc_nome IS 'Nome do Fornecedor';
COMMENT ON COLUMN DEV.FORNECEDORES.foc_diferenca IS 'Valor que foi pago a mais(negativo) ou a menos(positivo) na hora hora de pagamento de um pedido';

COMMENT ON COLUMN DEV.STATUS IS 'Tabela com os status dos pedidos';
COMMENT ON COLUMN DEV.STATUS.stt_id IS 'Chave Primária, identificador único de qualidade';
COMMENT ON COLUMN DEV.STATUS.stt_nome IS 'Termo para indicar o status de um pedido';

COMMENT ON COLUMN DEV.PRODUTOS IS 'Tabela com os produtos';
COMMENT ON COLUMN DEV.PRODUTOS.pdt_id IS 'Chave Primária, identificador único de poduto';
COMMENT ON COLUMN DEV.PRODUTOS.pdt_nome IS 'Nome do produto';
COMMENT ON COLUMN DEV.PRODUTOS.pdt_preco IS 'Preço unitário do produto';

COMMENT ON COLUMN DEV.PEDIDOS IS 'Tabela com os pedidos';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_id IS 'Chave Primária, identificador único de pedidos';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_data IS 'Data em o pedido foi realizado';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_stt_id IS 'Chave estrangeira para STATUS, status do pedido';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_foc_id IS 'Chave estrangeira para FORNECEDORES, fornecedor do produto do pedido';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_valor_total IS 'Valor total do pedido';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_valor_pago IS 'Valor pago do total do pedido';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_qal_id IS 'Chave estrangeira para QUALIDADES, qualiade do produto';

COMMENT ON COLUMN DEV.PEDIDOS_PRODUTOS IS 'Tabela de junção entre pedidos e produtos';
COMMENT ON COLUMN DEV.PEDIDOS_PRODUTOS.ppd_pdd_id IS 'Chave Primária Composta, chave estrangeira referente a pedidos';
COMMENT ON COLUMN DEV.PEDIDOS_PRODUTOS.ppd_pdt_id IS 'Chave Primária Composta, chave estrangeira referente a produtos';
COMMENT ON COLUMN DEV.PEDIDOS_PRODUTOS.ppd_quantidade IS 'Quantidade de produtos pedidos';