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
  Result := Result + '  CREATE TABLE CABECALHO ( ';
  Result := Result + ' ID CHAR(44) PRIMARY KEY,';

  Result := Result + ' BAIRRO_EMITENTE          VarChar(60),';
  Result := Result + ' BAIRRO_REMETENTE          VarChar(60),';
  Result := Result + ' CEP_EMITENTE             Integer,';
  Result := Result + ' CEP_REMETENTE             Integer,';
  Result := Result + ' CNAE_EMITENTE            Integer,';
  Result := Result + ' CNAE_REMETENTE            Integer,';
  Result := Result + ' CNPJ_CPF_EMITENTE  VarChar(18)';
  Result := Result + ' CNPJ_CPF_CLIENTE  VarChar(18)';
  Result := Result + ' COD_LOJA CHAR(2),';
  Result := Result + ' COD_MUNICIPIO_EMITENTE   Integer,';
  Result := Result + ' COD_MUNICIPIO_REMETENTE   Integer,';
  Result := Result + ' COD_NUMERICO INTEGER,     ';
  Result := Result + ' COD_PAIS_EMITENTE        Integer,';
  Result := Result + ' COD_PAIS_REMETENTE        Integer,';
  Result := Result + ' COMPLEMENTO_EMITENTE     VarChar(60),';
  Result := Result + ' COMPLEMENTO_REMETENTE     VarChar(60),';
  Result := Result + ' CRT_EMITENTE             Integer,';
  Result := Result + ' CRT_REMETENTE             Integer,';
  Result := Result + ' DT_EMISSAO DATE,   ';
  Result := Result + ' DT_SAIDA DATE,     ';
  Result := Result + ' FANTASIA_EMITENTE        VarChar(60),';
  Result := Result + ' FANTASIA_REMETENTE        VarChar(60),';
  Result := Result + ' FINALIDADE_NFE INTEGER,     ';
  Result := Result + ' FONE_EMITENTE            VarChar(15),';
  Result := Result + ' FONE_REMETENTE            VarChar(15),';
  Result := Result + ' IM_EMITENTE              VarChar(15),';
  Result := Result + ' IM_REMETENTE              VarChar(15),';
  Result := Result + ' IND_FINAL INTEGER,     ';
  Result := Result + ' IND_INTERMEDIARIO INTEGER,     ';
  Result := Result + ' IND_PRESENCA INTEGER,     ';
  Result := Result + ' LOGRADOURO_EMITENTE      VarChar(60),';
  Result := Result + ' LOGRADOURO_REMETENTE      VarChar(60),';
  Result := Result + ' MODELO_FISCAL VARCHAR(2),     ';
  Result := Result + ' NAT_OPERACAO VARCHAR(60),     ';
  Result := Result + ' NOME_EMITENTE            VarChar(60),';
  Result := Result + ' NOME_MUNICIPIO_EMITENTE  VarChar(60),';
  Result := Result + ' NOME_MUNICIPIO_REMETENTE  VarChar(60),';
  Result := Result + ' NOME_PAIS_EMITENTE       VarChar(60),';
  Result := Result + ' NOME_PAIS_REMETENTE       VarChar(60),';
  Result := Result + ' NOME_REMETENTE            VarChar(60),';
  Result := Result + ' NRO_EMITENTE             VarChar(60),';
  Result := Result + ' NRO_REMETENTE             VarChar(60),';
  Result := Result + ' NUM_NF INTEGER,     ';
  Result := Result + ' SERIE  VARCHAR(3),     ';
  Result := Result + ' TP_AMBIENTE INTEGER,     ';
  Result := Result + ' TP_EMISSAO INTEGER ,     ';
  Result := Result + ' TP_IMPRESSAO INTEGER,     ';
  Result := Result + ' TP_NF INTEGER,     ';
  Result := Result + ' UFD_EMIT VARCHAR(2),     ';
  Result := Result + ' UFD_EMITENTE             VarChar(2),';
  Result := Result + ' UFD_REMETENTE             VarChar(2),';
  Result := Result + ' VLR_DESCONTO             Numeric(15,2), ';
  Result := Result + ' VLR_FRETE Numeric(15,2), ';
  Result := Result + ' VLR_NF             Numeric(15,2)';
  Result := Result + ' VLR_NFE NUMERIC(15,2),';
  Result := Result + ' VLR_OUTRAS_DESPESA      Numeric(15,2), ';
  Result := Result + ' VLR_RECEBIDO      Numeric(15,2), ';
  Result := Result + ' VLR_SALDO_RECEBER      Numeric(15,2), ';
  Result := Result + ' VLR_SEGURO      Numeric(15,2), ';
  Result := Result + ' VLR_TOTAL_RECEBER Numeric(15,2), ';
  Result := Result + ' VLR_TROCO      Numeric(15,2), ';
  Result := Result + '  ); ';

end;

constructor TTabelaCabecalho.Create;
begin
  NomeTabela := 'CABECALHO';
end;


end.
