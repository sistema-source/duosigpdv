unit tabela_detalhe;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, tabela_pai;

type

  { TTabelaCabecalho }

  { TTabelaDetalhe }

  TTabelaDetalhe = class(TTabela)

  protected
    function ObterSQL: string; override;

  public
    constructor Create;
  end;


implementation

{ TTabelaDetalhe }
function TTabelaDetalhe.ObterSQL: string;
begin
  inherited;
  Result := '';
  Result := Result + '  CREATE TABLE DETALHE ( ';
  Result := Result + ' ID CHAR(44) PRIMARY KEY,';
  Result := Result + ' ID_CABECALHO CHAR(44),';
  Result := Result + ' CEST VARCHAR(10), ';
  Result := Result + ' CFO VARCHAR(4), ';
  Result := Result + ' COD_ACESSO VARCHAR(60),   ';
  Result := Result + ' COD_BARRA VARCHAR(30),   ';
  Result := Result + ' COD_PROCEDENCIA VARCHAR(1), ';
  Result := Result + ' COD_PRODUTO INTEGER, ';
  Result := Result + ' COD_PROMOCAO INTEGER, ';
  Result := Result + ' COD_BENEFICIO VARCHAR(15), ';
  Result := Result + ' STS_IMPRIMIR_COD_BARRA VARCHAR(1), ';
  Result := Result + ' COD_VENDEDOR VARCHAR(3), ';
  Result := Result + ' COMPLEMENTO VARCHAR(4096), ';
  Result := Result + ' CST_ICMS VARCHAR(4), ';
  Result := Result + ' CST_PIS_COFINS VARCHAR(2), ';
  Result := Result + ' CST_SIMPLES VARCHAR(4), ';
  Result := Result + ' DESCRICAO VARCHAR(60), ';
  Result := Result + ' NCM VARCHAR(10), ';
  Result := Result + ' ORDEM_GRAVACAO Integer,   ';
  Result := Result + ' PER_COFINS  NUMERIC(5,2), ';
  Result := Result + ' PER_DESCONTO NUMERIC(5,2), ';
  Result := Result + ' PER_ICMS NUMERIC(5,2), ';
  Result := Result + ' PER_MVA NUMERIC(5,2), ';
  Result := Result + ' PER_PIS NUMERIC(5,2), ';
  Result := Result + ' PER_SIMPLES NUMERIC(5,2), ';
  Result := Result + ' PER_TRIBUTACAO NUMERIC(5,2), ';
  Result := Result + ' PER_FUNDO_POBREZA NUMERIC(5,2), ';
  Result := Result + ' PER_DIFAL_DESTINO NUMERIC(5,2), ';
  Result := Result + ' QTDADE NUMERIC(15,2), ';

  Result := Result + '   EX_TIPI VarChar(15), ';
  Result := Result + '   MODALIDADE_BASE_ICMS VarChar(1), ';
  Result := Result + '   MODALIDADE_BASE_ICMS_ST VarChar(1), ';

    Result := Result + '   FCI VarChar(30), ';
    Result := Result + '   NUM_PEDIDO_CLIENTE VarChar(30), ';
    Result := Result + '   NUM_ORDEM_PEDIDO_CLIENTE VarChar(30), ';

        Result := Result + '   OBS_PRODUTO VarChar(500), ';
  Result := Result + ' STS_CFO VARCHAR(1), ';
  Result := Result + ' UNIDADE VARCHAR(2), ';
  Result := Result + ' VLR_BASE_FCP NUMERIC(15,2), ';
  Result := Result + ' VLR_FCP NUMERIC(15,2), ';
  Result := Result + ' PER_FCP NUMERIC(5,2), ';

  Result := Result + ' VLR_BASE_ICMS NUMERIC(15,2), ';
  Result := Result + ' VLR_BASE_ICMS_ST NUMERIC(15,2), ';
  Result := Result + ' VLR_COFINS NUMERIC(15,2), ';
  Result := Result + ' VLR_DESCONTO NUMERIC(15,2), ';
  Result := Result + ' VLR_FRETE NUMERIC(15,2), ';
  Result := Result + ' VLR_ICMS NUMERIC(5,2), ';
  Result := Result + ' VLR_ICMS_ST NUMERIC(5,2), ';
  Result := Result + ' VLR_IMPOSTO_ESTADUAL NUMERIC(15,2), ';
  Result := Result + ' VLR_IMPOSTO_FEDERAL NUMERIC(15,2), ';
  Result := Result + ' VLR_IMPOSTO_MUNICIPAL NUMERIC(15,2), ';
  Result := Result + ' VLR_OUTRAS_DESPESAS NUMERIC(15,2), ';
  Result := Result + ' VLR_PIS NUMERIC(15,2), ';
  Result := Result + ' VLR_SEGURO NUMERIC(15,2), ';
  Result := Result + ' VLR_TOTAL NUMERIC(15,2), ';
  Result := Result + ' VLR_BRUTO NUMERIC(15,2), ';
  Result := Result + ' VLR_UNITARIO NUMERIC(15,2) ';
  Result := Result + '  ); ';
end;

constructor TTabelaDetalhe.Create;
begin
  NomeTabela := 'DETALHE';
end;


end.
