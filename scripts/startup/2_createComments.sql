COMMENT ON TABLE DEV.QUALIDADES IS 'Tabela com as qualidades dos produtos';
COMMENT ON COLUMN DEV.QUALIDADES.qal_id IS 'Chave primária, identificador único da qualidade';
COMMENT ON COLUMN DEV.QUALIDADES.qal_nome IS 'Termo para indicar a qualidade do produto';

COMMENT ON TABLE DEV.FORNECEDORES IS 'Tabela com os fornecedores dos produtos';
COMMENT ON COLUMN DEV.FORNECEDORES.foc_id IS 'Chave primária, identificador único do fornecedor';
COMMENT ON COLUMN DEV.FORNECEDORES.foc_nome IS 'Nome do fornecedor';
COMMENT ON COLUMN DEV.FORNECEDORES.foc_diferenca IS 'Indica o saldo financeiro com o fornecedor: valores positivos representam débitos a pagar, enquanto valores negativos indicam pagamentos excedentes, que devem ser abatidos em pedidos futuros';

COMMENT ON TABLE DEV.STATUS IS 'Tabela com os status de entrega dos pedidos';
COMMENT ON COLUMN DEV.STATUS.stt_id IS 'Chave primária, identificador único do status';
COMMENT ON COLUMN DEV.STATUS.stt_nome IS 'Termo para indicar o status de entrega de um pedido';

COMMENT ON TABLE DEV.PRODUTOS IS 'Tabela com os produtos';
COMMENT ON COLUMN DEV.PRODUTOS.pdt_id IS 'Chave primária, identificador único do produto';
COMMENT ON COLUMN DEV.PRODUTOS.pdt_nome IS 'Nome do produto';
COMMENT ON COLUMN DEV.PRODUTOS.pdt_preco IS 'Preço unitário do produto';

COMMENT ON TABLE DEV.PEDIDOS IS 'Tabela com os pedidos';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_id IS 'Chave primária, identificador único do pedido';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_data IS 'Data em que o pedido foi realizado';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_stt_id IS 'Chave estrangeira referente a STATUS, status de entrega do pedido';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_foc_id IS 'Chave estrangeira referente a FORNECEDORES, fornecedor dos produtos pedidos';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_valor_total IS 'Valor total do pedido, soma dos preços unitários multiplicados pelas quantidades de cada produto pedido';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_valor_pago IS 'Valor pago do valor total do pedido';
COMMENT ON COLUMN DEV.PEDIDOS.pdd_qal_id IS 'Chave estrangeira referente a QUALIDADES, qualidade do produto';

COMMENT ON TABLE DEV.PEDIDOS_PRODUTOS IS 'Tabela de junção entre pedidos e produtos';
COMMENT ON COLUMN DEV.PEDIDOS_PRODUTOS.ppd_pdd_id IS 'Chave primária composta, chave estrangeira referente a PEDIDOS';
COMMENT ON COLUMN DEV.PEDIDOS_PRODUTOS.ppd_pdt_id IS 'Chave primária composta, chave estrangeira referente a PRODUTOS';
COMMENT ON COLUMN DEV.PEDIDOS_PRODUTOS.ppd_quantidade IS 'Quantidade de produtos pedidos';