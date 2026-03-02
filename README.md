# Lab-Banco-Dados
Arquivos para as entregas das atividades da matéria Laboratório de Banco de Dados.

## Requisitos das Entregas:
> ### Entrega 1
> - Normalização do DataSet
> - Confecção do dicionário de dados
> - Criação de Sequences e triggers
> - Povoamento da base de dados
> - Consultas estratégicas
> - ***Data: 17/04/2026***
> ### Entrega 2
> - Tabelas de histórico
> - Triggers de historiamento
> - Historiamento da carga 1 e cargas 2 e 3
> - Consultas estratégicas
> - ***Data: 17/04/2026***
> ### Entrega 3
> - Criação do usuário para auditoria
> - Criação da tabela de auditoria
> - Criação de Sequence e trigger para auditoria
> - Criação da procedure de auditoria
> - Criação dos triggers para auditoria
> - ***Data: 12/06/2026***
> ### Entrega 4
> - Criação do usuário para dw
> - Criação de views dinâmicas
> - Criação de Views materializadas
> - Consultas estratégicas
> - ***Data: 12/06/2026***
> ### Entrega 5
> - Certificado do curso de Power BI
> - Dashboard de análise no Power BI
> - ***Data 15/05/2026***
---

## Inicializando o Banco
### 1. Clone o repositório
```bash
git clone https://github.com/LucianoAk/Lab-Banco-Dados.git
```

### 2. Navegue até o repositório
```bash
cd Lab-Banco-Dados
```

### 3. Execute a imagem do Docker
```bash
docker run -d --name OraDB_Curricularizacao -p 1521:1521 -e ORACLE_PWD=s3nha -v ./scripts:/opt/oracle/scripts container-registry.oracle.com/database/express:21.3.0-xe
```
*Obs:* Para mais informações em relação à imagem utilizada, visite a [documentação](https://container-registry.oracle.com/ords/ocr/ba/database/express) da imagem.

### 4. Pós-inicialização
Após a inicialização mova os scripts da pasta `startup` para evitar erros na próxima inicialização do container.

---

## Informações de acesso ao Banco
| Field            | Data      |
|:----------------:|:---------:|
| Username         | DEV       |
| Password         | d3v       |
| Hostname         | localhost |
| Port             | 1521      |
| SID/Service Name | xe        |