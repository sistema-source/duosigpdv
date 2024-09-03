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
  Result := '  CREATE TABLE CABECALHO ( ' + ' ID CHAR(44) PRIMARY KEY,' + '      DT_EMISSAO DATE,   ' + '      DT_SAIDA DATE,     ' + '      VLR_NFE NUMERIC(15,2)' + '  ); ';
end;


end.
