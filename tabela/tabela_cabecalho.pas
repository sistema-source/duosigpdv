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
  end;


implementation

{ TTabelaCabecalho }
function TTabelaCabecalho.ObterSQL: string;
begin
  inherited;
  Result := '';
  Result := Result + '  CREATE TABLE CABECALHO ( ';
  Result := Result + ' ID CHAR(44) PRIMARY KEY,';
  Result := Result + ' DT_EMISSAO DATE,   ';
  Result := Result + ' DT_SAIDA DATE,     ';
  Result := Result + ' UFD_EMIT VARCHAR(2),     ';
  Result := Result + ' COD_NUMERICO INTEGER,     ';
  Result := Result + ' NAT_OPERACAO VARCHAR(60),     ';
  Result := Result + ' MODELO_FISCAL VARCHAR(2),     ';
  Result := Result + ' SERIE  VARCHAR(3),     ';
  Result := Result + ' NUM_NF INTEGER,     ';
  Result := Result + ' TP_EMISSAO INTEGER ,     ';
  Result := Result + ' TP_NF INTEGER,     ';
  Result := Result + ' TP_IMPRESSAO INTEGER,     ';
  Result := Result + ' TP_AMBIENTE INTEGER,     ';
  Result := Result + ' VLR_NFE NUMERIC(15,2)';
  Result := Result + ' FINALIDADE_NFE INTEGER,     ';
  Result := Result + ' IND_FINAL INTEGER,     ';
  Result := Result + ' IND_PRESENCA INTEGER,     ';
  Result := Result + ' IND_INTERMEDIARIO INTEGER,     ';

  Result := Result + '   NOME_REMETENTE            VarChar(60)';
  Result := Result + '   FANTASIA_REMETENTE        VarChar(60)';
  Result := Result + '   LOGRADOURO_REMETENTE      VarChar(60)';
  Result := Result + '   NRO_REMETENTE             VarChar(60)';
  Result := Result + '   COMPLEMENTO_REMETENTE     VarChar(60)';
  Result := Result + '   BAIRRO_REMETENTE          VarChar(60)';
  Result := Result + '   COD_MUNICIPIO_REMETENTE   Integer';
  Result := Result + '   NOME_MUNICIPIO_REMETENTE  VarChar(60)';
  Result := Result + '   UFD_REMETENTE             VarChar(2)';
  Result := Result + '   CEP_REMETENTE             Integer';
  Result := Result + '   COD_PAIS_REMETENTE        Integer';
  Result := Result + '   NOME_PAIS_REMETENTE       VarChar(60)';
  Result := Result + '   FONE_REMETENTE            VarChar(15)';
  Result := Result + '   IM_REMETENTE              VarChar(15)';
  Result := Result + '   CNAE_REMETENTE            Integer';
  Result := Result + '   CRT_REMETENTE             Integer';

  Result := Result + '   NOME_REMETENTE            VarChar(60)';
  Result := Result + '   FANTASIA_REMETENTE        VarChar(60)';
  Result := Result + '   LOGRADOURO_REMETENTE      VarChar(60)';
  Result := Result + '   NRO_REMETENTE             VarChar(60)';
  Result := Result + '   COMPLEMENTO_REMETENTE     VarChar(60)';
  Result := Result + '   BAIRRO_REMETENTE          VarChar(60)';
  Result := Result + '   COD_MUNICIPIO_REMETENTE   Integer';
  Result := Result + '   NOME_MUNICIPIO_REMETENTE  VarChar(60)';
  Result := Result + '   UFD_REMETENTE             VarChar(2)';
  Result := Result + '   CEP_REMETENTE             Integer';
  Result := Result + '   COD_PAIS_REMETENTE        Integer';
  Result := Result + '   NOME_PAIS_REMETENTE       VarChar(60)';
  Result := Result + '   FONE_REMETENTE            VarChar(15)';
  Result := Result + '   IM_REMETENTE              VarChar(15)';
  Result := Result + '   CNAE_REMETENTE            Integer';
  Result := Result + '   CRT_REMETENTE             Integer';
  Result := Result + '  ); ';

end;


end.
