unit tabela_pai;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  ZConnection,
  SQLite3Conn,
  ZDataset,
  SQLDB,
  tabela_interface;

type

  { TTabela }

  TTabela = class(TInterfacedObject, ITabela)
  private
    FNomeTabela: string;
    procedure SetNomeTabela(AValue: string);
  protected
    function ObterSQL: string; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: ITabela;
    procedure CriarTabela(pSQLCon: TSQLite3Connection; pSQLTrans: TSQLTransaction;
      pNomeBanco: string);

    property NomeTabela: string read FNomeTabela write SetNomeTabela;
  end;

implementation

{ TTabela }

procedure TTabela.SetNomeTabela(AValue: string);
begin
  if FNomeTabela = AValue then Exit;
  FNomeTabela := AValue;
end;

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

procedure TTabela.CriarTabela(pSQLCon: TSQLite3Connection;
  pSQLTrans: TSQLTransaction; pNomeBanco: string);

var
  Qry: TSQLQuery;
  OkTabela: boolean;
begin
  OkTabela := true;
  try
    pSQLCon.DatabaseName := pNomeBanco;
    pSQLCon.Connected    := True;                  // se banco não existir, cria.
    pSQLTrans.DataBase   := pSQLCon;               // nome banco
    pSQLTrans.Active     := True;                  // Ativa conexão

    // Verificar se a tabela existe
    Qry := TSQLQuery.Create(nil);
    try
      Qry.SQLConnection := pSQLCon;
      Qry.SQLTransaction := pSQLTrans;

      Qry.SQL.Text := ' SELECT ID FROM ' + FNomeTabela;
      try
//        Qry.Open;
      except
        on e: Exception do
        begin
          okTabela := true;
        end;
      end;
    finally
      Qry.Free;
    end;
    if OkTabela then
    begin
      pSQLCon.ExecuteDirect(ObterSQL);
      pSQLTrans.CommitRetaining;               // confirma gravando tabela nova banco
      pSQLTrans.Commit;                        // confirma fechando transação
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create(e.message);
    end;
  end;
end;

end.
