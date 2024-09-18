unit tabela_forma_pagto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, tabela_pai;

type

  { TTabelaFormaPagto }
  TTabelaFormaPagto = class(TTabela)

  protected
    function ObterSQL: string; override;

    public
    constructor Create;
  end;


implementation

{ TTabelaFormaPagto }
function TTabelaFormaPagto.ObterSQL: string;
begin
  inherited;
  Result := '';
  Result := Result + '  CREATE TABLE FORMA_PAGTO ( ';
  Result := Result + ' ID CHAR(44) PRIMARY KEY,';
  Result := Result + ' ID_CABECALHO CHAR(44), ';
  Result := Result + ' DESCRICAO_FORMA_PAGTO VarChar(30),';
  Result := Result + ' NOME_BANDEIRA VarChar(30),';
  Result := Result + ' COD_FORMA_PAGTO VarChar(2),';
  Result := Result + ' VLR_FORMA_PAGTO NUMERIC(15,2),   ';
  Result := Result + ' NUM_AUTORIZACAO VarChar(60) ';
  Result := Result + ' DOC001 VarChar(4096) ';
  Result := Result + ' DOC002 VarChar(4096) ';
  Result := Result + '  ); ';
end;

constructor TTabelaFormaPagto.Create;
begin
  NomeTabela:= 'FORMA_PAGTO';
end;


end.
