unit tabela_pai;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  SQLite3Conn,
  SQLDB,
  tabela_interface;

type

  { TTabela }

  TTabela = class(TInterfacedObject, ITabela)
  protected
    function ObterSQL: string; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: ITabela;
    procedure CriarTabela(pSQLCon: TSQLite3Connection; pSQLTrans: TSQLTransaction; pNomeBanco: string);
  end;

implementation

{ TTabela }

function TTabela.ObterSQL: string;
begin
  Result := '';

end;

constructor TTabela.Create;
begin

end;

destructor TTabela.Destroy;
begin
  inherited Destroy;
end;

class function TTabela.New: ITabela;
begin
  Result := self.Create;
end;

procedure TTabela.CriarTabela(pSQLCon: TSQLite3Connection; pSQLTrans: TSQLTransaction; pNomeBanco: string);
begin
  try
    pSQLCon.DatabaseName := pNomeBanco;
    pSQLCon.Connected := True;                  // se banco não existir, cria.
    pSQLTrans.DataBase := pSQLCon;                   // nome banco
    pSQLTrans.Active := True;                     // Ativa conexão
    pSQLCon.ExecuteDirect(ObterSQL);
    pSQLTrans.CommitRetaining;               // confirma gravando tabela nova banco
    pSQLTrans.Commit;                        // confirma fechando transação
  except
    on e: Exception do
    begin
      raise Exception.Create(e.message);
    end;
  end;
end;

end.
