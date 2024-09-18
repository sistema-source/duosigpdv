unit tabela_cabecalho;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, tabela_pai;

type

  { TTabelaCabecalho }

  TTabelaCabecalho = class(TTabela)

  protected
    function ObterSQL: string; override;
    constructor Create;
  end;


implementation

{ TTabelaCabecalho }
function TTabelaCabecalho.ObterSQL: string;
begin
  inherited;
  Result := '';
  Result := Result + ' CREATE TABLE CABECALHO ( ';
  Result := Result + ' ID CHAR(44) PRIMARY KEY,';
  Result := Result + ' BAIRRO_CLIENTE          VarChar(60),';
  Result := Result + ' BAIRRO_EMITENTE          VarChar(60),';
  Result := Result + ' CEP_CLIENTE             VarChar(10),';
  Result := Result + ' CEP_EMITENTE             VarChar(10),';
  Result := Result + ' CNAE_CLIENTE            VarChar(10),';
  Result := Result + ' CNAE_EMITENTE            VarChar(10),';
  Result := Result + ' CNPJ_CPF_CLIENTE  VarChar(18),';
  Result := Result + ' CNPJ_CPF_EMITENTE  VarChar(18),';
  Result := Result + ' COD_CONDICAO_PAGTO Integer CHAR(2),';
  Result := Result + ' COD_CLIENTE Integer CHAR(2),';
  Result := Result + ' COD_TABELA_PRECO Integer CHAR(2),';
  Result := Result + ' COD_HISTORICO CHAR(2),';
  Result := Result + ' COD_LOJA CHAR(2),';
  Result := Result + ' COD_MUNICIPIO_CLIENTE Integer, ';
  Result := Result + ' COD_MUNICIPIO_EMITENTE   Integer, ';
  Result := Result + ' COD_NUMERICO            INTEGER,     ';
  Result := Result + ' COD_PAIS_CLIENTE        Integer,';
  Result := Result + ' COD_PAIS_EMITENTE        Integer,';
  Result := Result + ' COD_TP_COBRANCA          VarChar(2),';
  Result := Result + ' COD_TP_OPERACAO          VarChar(2),';
  Result := Result + ' COD_TP_ESTOQUE Integer,';
  Result := Result + ' COD_TRANSPORTADORA        Integer,';
  Result := Result + ' COD_VENDEDOR        VarChar(3),';
  Result := Result + ' COD_ZONA_VENDA VarChar(2),';
  Result := Result + ' COMPLEMENTO_CLIENTE     VarChar(60),';
  Result := Result + ' COMPLEMENTO_EMITENTE     VarChar(60),';
  Result := Result + ' DT_EMISSAO DATETIME,   ';
  Result := Result + ' DT_SAIDA DATETIME,     ';
  Result := Result + ' ESPECIE_VOLUME VarChar(10),';
  Result := Result + ' NOME_FANTASIA_CLIENTE        VarChar(60),';
  Result := Result + ' NOME_FANTASIA_EMITENTE        VarChar(60),';
  Result := Result + ' TELEFONE_EMITENTE        VarChar(15),';

  // Verificar
  // 1=NF-e normal;
  // 2=NF-e complementar;
  //  3=NF-e de ajuste;
  //  4=Devolução de mercadoria.
  Result := Result + ' STS_FINALIDADE_NFE Char(1),     ';


  Result := Result + ' FONE_CLIENTE            VarChar(15),';
  Result := Result + ' FONE_EMITENTE            VarChar(15),';
  Result := Result + ' IM_EMITENTE              VarChar(15),';
  Result := Result + ' IM_CLIENTE              VarChar(15),';
  Result := Result + ' STS_INTERMEDIARIO Char(1),     ';
  Result := Result + ' STS_PRESENCA Char(1),     ';
  Result := Result + ' STS_CONSUMIDOR_FINAL Char(1),     ';
  Result := Result + ' STS_CONTRIBUINTE Char(1),     ';
  Result := Result + ' INSC_ESTADUAL_CLIENTE VarChar(18),';
  Result := Result + ' INSC_ESTADUAL_EMITENTE VarChar(18),';
  Result := Result + ' LOGRADOURO_CLIENTE      VarChar(60),';
  Result := Result + ' LOGRADOURO_EMITENTE      VarChar(60),';
  Result := Result + ' MARCA_VOLUME      VarChar(15), ';
  Result := Result + ' MSG_PADRAO VarChar(1024), ';
  Result := Result + ' MODELO_FISCAL VARCHAR(2),     ';
  Result := Result + ' NAT_OPERACAO VARCHAR(60),     ';
  Result := Result + ' NOME_EMITENTE            VarChar(60),';
  Result := Result + ' NOME_MOTORISTA VarChar(60),';
  Result := Result + ' MUNICIPIO_CLIENTE  VarChar(60),';
  Result := Result + ' MUNICIPIO_EMITENTE  VarChar(60),';
  Result := Result + ' NOME_PAIS_CLIENTE       VarChar(60),';
  Result := Result + ' NOME_PAIS_EMITENTE       VarChar(60),';
  Result := Result + ' NOME_CLIENTE            VarChar(60),';
  Result := Result + ' NRO_EMITENTE             VarChar(60),';
  Result := Result + ' NRO_CLIENTE             VarChar(60),';
  Result := Result + ' NUM_CAIXA Integer, ';
  Result := Result + ' NUM_EMBALAGEM      Integer, ';
  Result := Result + ' NUM_NF INTEGER,     ';
  Result := Result + ' NUM_ORCAMENTO Integer, ';
  Result := Result + ' NUM_SERIE Integer, ';    // Verificar o campo
  Result := Result + ' PESO_BRUTO Numeric(15,3), ';
  Result := Result + ' PESO_LIQUIDO Numeric(15,3), ';
  Result := Result + ' PLACA_VEICULO VarChar(30),';
  Result := Result + ' QTD_VOLUME      Integer, ';
  Result := Result + ' SERIE  VARCHAR(3),     ';
  Result := Result + ' STS_CFO VarChar(1), ';
  Result := Result + ' STS_CIF_FOB          VarChar(1),';
  Result := Result + ' STS_CONVERTIDO          VarChar(1),';
  // Verificar a gravacao
  Result := Result + ' TOKEN_NFE          VarChar(60),';
  Result := Result + ' ID_TOKEN_NFE          VarChar(60),';
  Result := Result + ' REGIME_TRIBUTARIO      VarChar(1),';

  // Vericiar
  Result := Result + ' STS_TIPO_BIBLIOTECA          VarChar(1),';
  Result := Result + ' SUFRAMA           VarChar(25),';
  Result := Result + ' EMAIL_CLIENTE           VarChar(256),';

  // S - SSL, N - WinCript


  // 1=Produção; 2=Homologação   -- Verificar
  Result := Result + ' TP_AMBIENTE Char(1),     ';

  // Veriicar como esa esse campo 1=Emissão normal (não em contingência);
  // 1-Normal
  // 2=Contingência FS-IA, com impressão do DANFE em  Formulário de Segurança - Impressor Autônomo;
  // 3=Contingência SCAN (Sistema de Contingência do Ambiente Nacional); *Desativado * NT 2015/002
  // 4=Contingência EPEC (Evento Prévio da Emissão em Contingência);
  // 5=Contingência FS-DA, com impressão do DANFE em Formulário de Segurança - Documento Auxiliar;
  // 6=Contingência SVC-AN (SEFAZ Virtual de Contingência do AN);
  // 7=Contingência SVC-RS (SEFAZ Virtual de Contingência doRS);
  // 9=Contingência off-line da NFC-e;
  Result := Result + ' TP_EMISSAO Char(1),     ';

  Result := Result + ' TP_IMPRESSAO Char(1),     ';
  // Verificar cmpo esta sendo gravado 0=Sem geração de DANFE; 1=DANFE normal, Retrato; 2=DANFE normal, Paisagem; 3=DANFE Simplificado; 4=DANFE NFC-e;
  Result := Result + ' TP_OPERACAO  Char(1),     ';
  // Verificar o campo 0 - Entrada, 1 - Saida
  Result := Result + ' TP_NF INTEGER,     ';
  Result := Result + ' TP_ENTREGA Char(1),     ';
  Result := Result + ' UFD_CLIENTE             VarChar(2),';
  Result := Result + ' UFD_EMITENTE             VarChar(2),';
  Result := Result + ' UFD_PLACA VarChar(2),';
  Result := Result + ' USUARIO_INS  VarChar(15), ';
  Result := Result + ' VIA_TRANSPORTE          VarChar(1),';
  Result := Result + ' VLR_DESCONTO            Numeric(15,2), ';
  Result := Result + ' VLR_ENTRADA Numeric(15,2),  ';
  Result := Result + ' VLR_FRETE Numeric(15,2), ';
  Result := Result + ' VLR_NF             Numeric(15,2),';
  Result := Result + ' VLR_PRODUTOS       Numeric(15,2),';
  Result := Result + ' VLR_OUTRAS_DESPESA      Numeric(15,2), ';
  Result := Result + ' VLR_RECEBIDO      Numeric(15,2), ';
  Result := Result + ' VLR_SALDO_RECEBER      Numeric(15,2), ';
  Result := Result + ' VLR_SEGURO      Numeric(15,2), ';
  Result := Result + ' VLR_TOTAL_RECEBER Numeric(15,2), ';
  Result := Result + ' VLR_TROCO      Numeric(15,2) ';
  Result := Result + '  ); ';
end;

constructor TTabelaCabecalho.Create;
begin
  NomeTabela := 'CABECALHO';
end;


end.
