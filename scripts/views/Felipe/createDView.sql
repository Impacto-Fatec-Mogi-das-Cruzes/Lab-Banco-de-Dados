CREATE OR REPLACE VIEW DW_USER.ALL_PRODUTOS AS 
    SELECT 
        p.PDT_ID,
        p.PDT_NOME,
        p.PDT_PRECO,
        pp.PPD_PDD_ID,
        pp.PPD_PDT_ID,
        pp.PPD_QUANTIDADE,
        pd.PDD_ID,
        pd.PDD_DATA,
        pd.PDD_STT_ID,
        pd.PDD_FOC_ID,
        pd.PDD_VALOR_TOTAL,
        pd.PDD_VALOR_PAGO,
        pd.PDD_QAL_ID,
        f.FOC_ID,
        f.FOC_NOME
    FROM DEV.PRODUTOS p
    JOIN DEV.PEDIDOS_PRODUTOS pp ON p.PDT_ID = pp.PPD_PDT_ID
    JOIN DEV.PEDIDOS pd ON pp.PPD_PDD_ID = pd.PDD_ID
    JOIN DEV.FORNECEDORES f ON pd.PDD_FOC_ID = f.FOC_ID

    UNION ALL 

    SELECT 
        hp.PDT_ID,
        hp.PDT_NOME,
        hp.PDT_PRECO,
        hpp.HPPD_PDD_ID,
        hpp.HPPD_PDT_ID,
        hpp.HPPD_QUANTIDADE,
        hpd.HPDD_ID,
        hpd.HPDD_DATA,
        hpd.HPDD_STT_ID,
        hpd.HPDD_FOC_ID,
        hpd.HPDD_VALOR_TOTAL,
        hpd.HPDD_VALOR_PAGO,
        hpd.HPDD_QAL_ID,
        f.FOC_ID,
        f.FOC_NOME
    FROM DEV.PRODUTOS hp
    JOIN DEV.HPEDIDOS_PRODUTOS hpp ON hp.PDT_ID = hpp.HPPD_PDT_ID
    JOIN DEV.HPEDIDOS hpd ON hpp.HPPD_PDD_ID = hpd.HPDD_ID
    JOIN DEV.FORNECEDORES f ON hpd.HPDD_FOC_ID = f.FOC_ID
