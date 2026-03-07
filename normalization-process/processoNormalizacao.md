# Processo de Normalização

## Planilha Inicial
| Data do Pedido | Status do Pedido | Nome Fornecedor | Produtos | Quantidade | Valor Total | Diferença | Valor Pago | Qualidade do Produto |
|  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |
| 04/01/2024 | Entregue | Rafael Almeida | Cebolinha | 5 | 15.0 | 0.0 | 15.0 | Ruim |
| 12/01/2024 | Entregue | João Pereira | Alface Roxa, Rúcula, Agrião | 19,9,7 | 149.0 |  -16.14 | 165.14 | Bom |
| 07/01/2024 | Parcial | João Pereira | Couve Tronchuda, Rúcula | 12, 17 | 139.0 | 2.58 | 136.42 | Ruim |

## 1FN
### Tabela Pedidos
| Id Pedido | Data do Pedido | Status do Pedido | Nome Fornecedor | Produtos | Quantidade | Valor Total | Diferença | Valor Pago | Qualidade do Produto |
| :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |
| 1 | 04/01/2024 | Entregue | Rafael Almeida | Cebolinha | 5 | 15.0 | 0.0 | 15.0 | Ruim |
| 2 | 12/01/2024 | Entregue | João Pereira | Alface Roxa | 19 | 149.0 |  -16.14 | 165.14 | Bom |
| 2 | 12/01/2024 | Entregue | João Pereira | Rúcula | 9 | 149.0 |  -16.14 | 165.14 | Bom |
| 2 | 12/01/2024 | Entregue | João Pereira | Agrião | 7 | 149.0 |  -16.14 | 165.14 | Bom |
| 3 | 07/01/2024 | Parcial | João Pereira | Couve Tronchuda | 12 | 139.0 | 2.58 | 136.42 | Ruim |
| 3 | 07/01/2024 | Parcial | João Pereira | Rúcula | 17 | 139.0 | 2.58 | 136.42 | Ruim |

## 2FN
### Tabela Pedidos
| Id Pedido | Data do Pedido | Status do Pedido | Nome Fornecedor  | Valor Total | Diferença | Valor Pago | Qualidade do Produto |
| :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |
| 1 | 04/01/2024 | Entregue | Rafael Almeida | 15.0 | 0.0 | 15.0 | Ruim |
| 2 | 12/01/2024 | Entregue | João Pereira | 149.0 | -16.14 | 165.14 | Bom |
| 3 | 07/01/2024 | Parcial | João Pereira | 139.0 | 2.58 | 136.42 | Ruim |

### Tabela Pedidos_Produtos
| Id Pedido | Produtos | Quantidade |
|  :-: |  :-: |  :-: |
| 1 | Cebolinha | 5 |
| 2 | Alface Roxa | 19 |
| 2 | Rúcula | 9 |
| 2 | Agrião | 7 |
| 3 | Couve Tronchuda | 12 |
| 3 | Rúcula | 17 |

## 3FN
### Tabela Pedidos
| Id Pedido | Data do Pedido | Id Status | Id Fornecedor | Valor Total  | Valor Pago | Id Qualidade |
| :-: |  :-: |  :-: |  :-: |  :-: |  :-: |  :-: |
| 1 | 04/01/2024 | 1 | 1 | 15.0 | 15.0 | 2 |
| 2 | 12/01/2024 | 1 | 2 | 149.0 | 165.14 | 1 |
| 3 | 07/01/2024 | 2 | 2 | 139.0 | 136.42 | 2 |

### Tabela Status
| Id Status | Nome Status |
| :-: | :-: |
| 1 | Entregue |
| 2 | Parcial |

### Tabela Fornecedores
| Id Fornecedor | Nome Fornecedor |
| :-: | :-: |
| 1 | Rafael Almeida |
| 2 | João Pereira |

### Tabela Qualidades
| Id Qualidade | Nome Qualidade |
| :-: | :-: |
| 1 | Bom |
| 2 | Ruim |

### Tabela Pedidos_Produtos
| Id Pedido | Produtos | Quantidade |
|  :-: |  :-: |  :-: |
| 1 | 1 | 5 |
| 2 | 2 | 19 |
| 2 | 3 | 9 |
| 2 | 4 | 7 |
| 3 | 5 | 12 |
| 3 | 3 | 17 |

### Tabela Produtos
| Id Produto | Nome Produto |
| :-: | :-: |
| 1 | Cebolinha |
| 2 | Alface Roxa |
| 3 | Rúcula |
| 4 | Agrião |
| 5 | Couve Tronchuda |

## Tabela Normalizada
<img style="background-color: white" src="diagrama.svg">