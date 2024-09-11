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
  Result := Result + ' ORDEM_GRAVACAO Integer,   ';

  Result := Result + ' COD_ACESSO VARCHAR(60),   ';
  Result := Result + ' COD_PRODUTO INTEGER, ';
  Result := Result + ' DESCRICAO VARCHAR(60), ';
  Result := Result + ' QTDADE NUMERIC(15,2), ';
  Result := Result + ' VLR_UNITARIO NUMERIC(15,2), ';
  Result := Result + ' PER_DECONTO NUMERIC(15,2), ';
  Result := Result + ' VLR_TOTAL NUMERIC(15,2) ';
  Result := Result + '  ); ';

end;

constructor TTabelaDetalhe.Create;
begin
  NomeTabela:= 'DETALHE';
end;


end.
