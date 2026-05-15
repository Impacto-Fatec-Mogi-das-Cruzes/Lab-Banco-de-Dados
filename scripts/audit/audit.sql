    ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

    CREATE USER AUDITORIA IDENTIFIED BY 123
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA UNLIMITED ON USERS;
    
    GRANT CONNECT, RESOURCE TO AUDITORIA;
    GRANT CREATE ANY TRIGGER TO AUDITORIA;
/
GRANT INSERT, SELECT, DELETE, UPDATE ON DEV.HFORNECEDORES TO AUDITORIA;
GRANT INSERT, SELECT, DELETE, UPDATE ON DEV.HPEDIDOS TO AUDITORIA;
GRANT INSERT, SELECT, DELETE, UPDATE ON DEV.HPEDIDOS_PRODUTOS TO AUDITORIA;
GRANT INSERT, SELECT, DELETE, UPDATE ON DEV.HPRODUTOS TO AUDITORIA;
GRANT INSERT, SELECT, DELETE, UPDATE ON DEV.HQUALIDADES TO AUDITORIA;
GRANT INSERT, SELECT, DELETE, UPDATE ON DEV.HSTATUS TO AUDITORIA;

COMMIT;
--------------------------------------------------------
--  DDL for Sequence SEQ_AUD
--------------------------------------------------------

   CREATE SEQUENCE  AUDITORIA."SEQ_AUD"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOCYCLE;
/
--------------------------------------------------------
--  DDL for Table AUDITORIA
--------------------------------------------------------

  CREATE TABLE AUDITORIA."AUDITORIA" 
   (	
     "AUD_ID" NUMBER(6,0), 
	   "AUD_TABELA" VARCHAR2(30),
	   "AUD_OPERACAO" CHAR(1), 
     "AUD_HIST_ID" NUMBER(10),
	   "AUD_COLUNA" VARCHAR2(30), 
	   "AUD_VALOR_ANTIGO" VARCHAR2(255), 
	   "AUD_VALOR_NOVO" VARCHAR2(255), 
	   "AUD_USU_BD" VARCHAR2(30), 
	   "AUD_USU_SO" VARCHAR2(255), 
	   "AUD_DATA" DATE
   ) ;
/
--------------------------------------------------------
--  Constraints for Table AUDITORIA
--------------------------------------------------------

  ALTER TABLE AUDITORIA."AUDITORIA" ADD CONSTRAINT "PK_AUD" PRIMARY KEY ("AUD_ID");
/
--------------------------------------------------------
--  DDL for Trigger TG_SEQ_AUD
--------------------------------------------------------

CREATE OR REPLACE TRIGGER AUDITORIA."TG_SEQ_AUD" BEFORE INSERT ON AUDITORIA.AUDITORIA
FOR EACH ROW
BEGIN
    :NEW."AUD_ID" := SEQ_AUD.NEXTVAL;
END;

/
ALTER TRIGGER AUDITORIA."TG_SEQ_AUD" ENABLE;
/
--------------------------------------------------------
--  DDL for Procedure PROC_AUDITORIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE AUDITORIA."PROC_AUDITORIA" (
    P_AUD_TABELA IN VARCHAR,
    P_AUD_OPERACAO IN CHAR,
    P_AUD_HIST_ID IN NUMBER,
    P_AUD_COLUNA IN VARCHAR,
    P_AUD_VALOR_ANTIGO IN VARCHAR,
    P_AUD_VALOR_NOVO IN VARCHAR,
    P_AUD_USU_BD IN VARCHAR, 
	P_AUD_USU_SO IN VARCHAR, 
	P_AUD_DATA IN DATE
)
IS
BEGIN
    INSERT INTO AUDITORIA.AUDITORIA VALUES (null,P_AUD_TABELA,P_AUD_OPERACAO,P_AUD_HIST_ID,P_AUD_COLUNA,P_AUD_VALOR_ANTIGO,P_AUD_VALOR_NOVO,P_AUD_USU_BD,P_AUD_USU_SO,P_AUD_DATA);
END;

/

--------------------------------------------------------
--  DDL for Trigger TG_AUD_FORNECEDORES
--------------------------------------------------------
/
CREATE OR REPLACE TRIGGER AUDITORIA.TG_AUD_FORNECEDORES 
AFTER UPDATE OR DELETE ON DEV.HFORNECEDORES
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30);
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_TABELA VARCHAR(30) := 'HFORNECEDORES';
BEGIN
    SELECT USER INTO V_USU_BD FROM DUAL;
    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        PROC_AUDITORIA(V_TABELA,V_TP_OPERACAO,:OLD.HFOC_ID,'HFOC_ID',:OLD.HFOC_ID,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        PROC_AUDITORIA(V_TABELA,V_TP_OPERACAO,:OLD.HFOC_ID,'HFOC_NOME',:OLD.HFOC_NOME,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        PROC_AUDITORIA(V_TABELA,V_TP_OPERACAO,:OLD.HFOC_ID,'HFOC_DIFERENCA',:OLD.HFOC_DIFERENCA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        PROC_AUDITORIA(V_TABELA,V_TP_OPERACAO,:OLD.HFOC_ID,'HFOC_DT_ENTRADA',:OLD.HFOC_DT_ENTRADA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
    ELSE
        V_TP_OPERACAO := 'U';
        IF (:NEW.HFOC_ID <> :OLD.HFOC_ID) THEN
            PROC_AUDITORIA(V_TABELA,V_TP_OPERACAO,:OLD.HFOC_ID,'HFOC_ID',:OLD.HFOC_ID,:NEW.HFOC_ID,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF (:NEW.HFOC_NOME <> :OLD.HFOC_NOME) THEN
            PROC_AUDITORIA(V_TABELA,V_TP_OPERACAO,:OLD.HFOC_ID,'HFOC_NOME',:OLD.HFOC_NOME,:NEW.HFOC_NOME,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF (:NEW.HFOC_DIFERENCA <> :OLD.HFOC_DIFERENCA) THEN
            PROC_AUDITORIA(V_TABELA,V_TP_OPERACAO,:OLD.HFOC_ID,'HFOC_DIFERENCA',:OLD.HFOC_DIFERENCA,:NEW.HFOC_DIFERENCA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF (:NEW.HFOC_DT_ENTRADA <> :OLD.HFOC_DT_ENTRADA) THEN
            PROC_AUDITORIA(V_TABELA,V_TP_OPERACAO,:OLD.HFOC_ID,'HFOC_DT_ENTRADA',:OLD.HFOC_DT_ENTRADA,:NEW.HFOC_DT_ENTRADA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
    END IF;
END;
/
ALTER TRIGGER AUDITORIA."TG_AUD_FORNECEDORES" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TG_AUD_PEDIDOS
--------------------------------------------------------

CREATE OR REPLACE TRIGGER AUDITORIA."TG_AUD_PEDIDOS" 
AFTER UPDATE OR DELETE ON DEV.HPEDIDOS
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30);
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_TABELA VARCHAR(30) := 'HPEDIDOS';
BEGIN
    SELECT USER INTO V_USU_BD FROM DUAL;

    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDD_ID,
            'HPDD_ID',
            :OLD.HPDD_ID,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDD_ID,
            'HPDD_DATA',
            :OLD.HPDD_DATA,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDD_ID,
            'HPDD_STT_ID',
            :OLD.HPDD_STT_ID,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDD_ID,
            'HPDD_FOC_ID',
            :OLD.HPDD_FOC_ID,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDD_ID,
            'HPDD_VALOR_TOTAL',
            :OLD.HPDD_VALOR_TOTAL,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDD_ID,
            'HPDD_VALOR_PAGO',
            :OLD.HPDD_VALOR_PAGO,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDD_ID,
            'HPDD_QAL_ID',
            :OLD.HPDD_QAL_ID,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDD_ID,
            'HPDD_DT_ENTRADA',
            :OLD.HPDD_DT_ENTRADA,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        
    ELSE
        V_TP_OPERACAO := 'U';
        
        IF (:NEW.HPDD_ID <> :OLD.HPDD_ID) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_ID,
                'HPDD_ID',
                :OLD.HPDD_ID,
                :NEW.HPDD_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDD_DATA <> :OLD.HPDD_DATA) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_ID,
                'HPDD_DATA',
                :OLD.HPDD_DATA,
                :NEW.HPDD_DATA,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDD_STT_ID <> :OLD.HPDD_STT_ID) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_ID,
                'HPDD_STT_ID',
                :OLD.HPDD_STT_ID,
                :NEW.HPDD_STT_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDD_FOC_ID <> :OLD.HPDD_FOC_ID) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_ID,
                'HPDD_FOC_ID',
                :OLD.HPDD_FOC_ID,
                :NEW.HPDD_FOC_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDD_VALOR_TOTAL <> :OLD.HPDD_VALOR_TOTAL) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_ID,
                'HPDD_VALOR_TOTAL',
                :OLD.HPDD_VALOR_TOTAL,
                :NEW.HPDD_VALOR_TOTAL,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDD_VALOR_PAGO <> :OLD.HPDD_VALOR_PAGO) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_ID,
                'HPDD_VALOR_PAGO',
                :OLD.HPDD_VALOR_PAGO,
                :NEW.HPDD_VALOR_PAGO,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDD_QAL_ID <> :OLD.HPDD_QAL_ID) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_ID,
                'HPDD_QAL_ID',
                :OLD.HPDD_QAL_ID,
                :NEW.HPDD_QAL_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDD_DT_ENTRADA <> :OLD.HPDD_DT_ENTRADA) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_ID,
                'HPDD_DT_ENTRADA',
                :OLD.HPDD_DT_ENTRADA,
                :NEW.HPDD_DT_ENTRADA,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        
    END IF;
END;
/
ALTER TRIGGER AUDITORIA."TG_AUD_PEDIDOS" ENABLE;

--------------------------------------------------------
--  DDL for Trigger TG_AUD_PEDIDOS_PRODUTOS
--------------------------------------------------------

CREATE OR REPLACE TRIGGER AUDITORIA."TG_AUD_PEDIDOS_PRODUTOS" 
AFTER UPDATE OR DELETE ON DEV.HPEDIDOS_PRODUTOS
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30);
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_TABELA VARCHAR(30) := 'HPEDIDOS_PRODUTOS';
BEGIN
    SELECT USER INTO V_USU_BD FROM DUAL;

    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPPD_PDD_ID,
            'HPPD_PDD_ID',
            :OLD.HPPD_PDD_ID,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPPD_PDD_ID,
            'HPPD_PDT_ID',
            :OLD.HPPD_PDT_ID,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPPD_PDD_ID,
            'HPPD_QUANTIDADE',
            :OLD.HPPD_QUANTIDADE,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPPD_PDD_ID,
            'HPPD_DT_ENTRADA',
            :OLD.HPPD_DT_ENTRADA,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        
    ELSE
        V_TP_OPERACAO := 'U';
        
        IF (:NEW.HPPD_PDD_ID <> :OLD.HPPD_PDD_ID) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_PDD_ID,
                'HPPD_PDD_ID',
                :OLD.HPPD_PDD_ID,
                :NEW.HPPD_PDD_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPPD_PDT_ID <> :OLD.HPPD_PDT_ID) THEN
             PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPPD_PDD_ID,
                'HPPD_PDT_ID',
                :OLD.HPPD_PDT_ID,
                :NEW.HPPD_PDT_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
             );
        END IF;
        IF (:NEW.HPPD_QUANTIDADE <> :OLD.HPPD_QUANTIDADE) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPPD_PDD_ID,
                'HPPD_QUANTIDADE',
                :OLD.HPPD_QUANTIDADE,
                :NEW.HPPD_QUANTIDADE,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPPD_DT_ENTRADA <> :OLD.HPPD_DT_ENTRADA) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDD_PDD_ID,
                'HPPD_DT_ENTRADA',
                :OLD.HPPD_DT_ENTRADA,
                :NEW.HPPD_DT_ENTRADA,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;

    END IF;
END;
/
ALTER TRIGGER AUDITORIA."TG_AUD_PEDIDOS_PRODUTOS" ENABLE;

--------------------------------------------------------
--  DDL for Trigger TG_AUD_PRODUTOS
--------------------------------------------------------

CREATE OR REPLACE TRIGGER AUDITORIA."TG_AUD_PRODUTOS" 
AFTER UPDATE OR DELETE ON DEV.HPRODUTOS
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30);
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_TABELA VARCHAR(30) := 'HPRODUTOS';
BEGIN
    SELECT USER INTO V_USU_BD FROM DUAL;

    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDT_ID,
            'HPDT_ID',
            :OLD.HPDT_ID,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDT_ID,
            'HPDT_NOME',
            :OLD.HPDT_NOME,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDT_ID,
            'HPDT_PRECO',
            :OLD.HPDT_PRECO,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HPDT_ID,
            'HPDT_DT_ENTRADA',
            :OLD.HPDT_DT_ENTRADA,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        
    ELSE
        V_TP_OPERACAO := 'U';
        
        IF (:NEW.HPDT_ID <> :OLD.HPDT_ID) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDT_ID,
                'HPDT_ID',
                :OLD.HPDT_ID,
                :NEW.HPDT_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDT_NOME <> :OLD.HPDT_NOME) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDT_ID,
                'HPDT_NOME',
                :OLD.HPDT_NOME,
                :NEW.HPDT_NOME,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDT_PRECO <> :OLD.HPDT_PRECO) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDT_ID,
                'HPDT_PRECO',
                :OLD.HPDT_PRECO,
                :NEW.HPDT_PRECO,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HPDT_DT_ENTRADA <> :OLD.HPDT_DT_ENTRADA) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HPDT_ID,
                'HPDT_DT_ENTRADA',
                :OLD.HPDT_DT_ENTRADA,
                :NEW.HPDT_DT_ENTRADA,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        
    END IF;
END;
/
ALTER TRIGGER AUDITORIA."TG_AUD_PRODUTOS" ENABLE;

--------------------------------------------------------
--  DDL for Trigger TG_AUD_QUALIDADES
--------------------------------------------------------

CREATE OR REPLACE TRIGGER AUDITORIA."TG_AUD_QUALIDADES" 
AFTER UPDATE OR DELETE ON DEV.HQUALIDADES
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30);
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_TABELA VARCHAR(30) := 'HQUALIDADES';
BEGIN
    SELECT USER INTO V_USU_BD FROM DUAL;

    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HQAL_ID,
            'HQAL_ID',
            :OLD.HQAL_ID,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HQAL_ID,
            'HQAL_NOME',
            :OLD.HQAL_NOME,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HQAL_ID,
            'HQAL_DT_ENTRADA',
            :OLD.HQAL_DT_ENTRADA,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        
    ELSE
        V_TP_OPERACAO := 'U';
        
        IF (:NEW.HQAL_ID <> :OLD.HQAL_ID) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HQAL_ID,
                'HQAL_ID',
                :OLD.HQAL_ID,
                :NEW.HQAL_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HQAL_NOME <> :OLD.HQAL_NOME) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HQAL_ID,
                'HQAL_NOME',
                :OLD.HQAL_NOME,
                :NEW.HQAL_NOME,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HQAL_DT_ENTRADA <> :OLD.HQAL_DT_ENTRADA) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HQAL_ID,
                'HQAL_DT_ENTRADA',
                :OLD.HQAL_DT_ENTRADA,
                :NEW.HQAL_DT_ENTRADA,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        
    END IF;
END;
/
ALTER TRIGGER AUDITORIA."TG_AUD_QUALIDADES" ENABLE;

--------------------------------------------------------
--  DDL for Trigger TG_AUD_STATUS
--------------------------------------------------------

CREATE OR REPLACE TRIGGER AUDITORIA."TG_AUD_STATUS" 
AFTER UPDATE OR DELETE ON DEV.HSTATUS
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30);
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_TABELA VARCHAR(30) := 'HSTATUS';
BEGIN
    SELECT USER INTO V_USU_BD FROM DUAL;

    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HSTT_ID,
            'HSTT_ID',
            :OLD.HSTT_ID,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HSTT_ID,
            'HSTT_NOME',
            :OLD.HSTT_NOME,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        PROC_AUDITORIA(
            V_TABELA,
            V_TP_OPERACAO,
            :OLD.HSTT_ID,
            'HSTT_DT_ENTRADA',
            :OLD.HSTT_DT_ENTRADA,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
        
    ELSE
        V_TP_OPERACAO := 'U';
        
        IF (:NEW.HSTT_ID <> :OLD.HSTT_ID) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HSTT_ID,
                'HSTT_ID',
                :OLD.HSTT_ID,
                :NEW.HSTT_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HSTT_NOME <> :OLD.HSTT_NOME) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HSTT_ID,
                'HSTT_NOME',
                :OLD.HSTT_NOME,
                :NEW.HSTT_NOME,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.HSTT_DT_ENTRADA <> :OLD.HSTT_DT_ENTRADA) THEN
            PROC_AUDITORIA(
                V_TABELA,
                V_TP_OPERACAO,
                :OLD.HSTT_ID,
                'HSTT_DT_ENTRADA',
                :OLD.HSTT_DT_ENTRADA,
                :NEW.HSTT_DT_ENTRADA,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        
    END IF;
END;
/
ALTER TRIGGER AUDITORIA."TG_AUD_STATUS" ENABLE;

