unit model_vendedor;

interface

uses
  Classes, SysUtils, ZDataset, model_conexao_firebird;

type
  { TModelDmVendedor }
  TModelDmVendedor = class(TDataModule)
    ZQuery1: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FHashTable: TStringList;
    FModelConexaoFirebird: TModelConexaoFirebird;
    procedure SetHashTable(AValue: TStringList);
    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
  public
    function ObterListaCodigoVendedors(pLista: TStrings): boolean;
    property HashTable: TStringList read FHashTable write SetHashTable;
    property ModelConexaoFirebird: TModelConexaoFirebird
      read FModelConexaoFirebird write SetModelConexaoFirebird;
  end;

  IModelVendedor = interface
    ['{F423AD5C-6958-4547-A27C-3319D28187DA}']
    function ObterListaCodigoVendedors(pLista: TStrings): boolean;
  end;

  { TModelVendedor }
  TModelVendedor = class(TInterfacedObject, IModelVendedor)
  private
    FModelDmVendedor: TModelDmVendedor;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IModelVendedor;

    function ObterListaCodigoVendedors(pLista: TStrings): boolean;


  end;



implementation

{$R *.lfm}

{ TModelVendedor }
constructor TModelVendedor.Create;
begin
  FModelDMVendedor := TModelDMVendedor.Create(nil);
end;

destructor TModelVendedor.Destroy;
begin
  FreeAndNil(FModelDMVendedor);
  inherited Destroy;
end;

class function TModelVendedor.New: IModelVendedor;
begin
  Result := Self.Create;
end;

function TModelVendedor.ObterListaCodigoVendedors(pLista: TStrings): boolean;
begin
  FModelDmVendedor.ObterListaCodigoVendedors(pLista);
  Result := True;
end;

{ TModelDmVendedor }

procedure TModelDmVendedor.DataModuleCreate(Sender: TObject);
begin
  FHashTable := TStringList.Create;
end;

procedure TModelDmVendedor.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FHashTable);
end;

procedure TModelDmVendedor.SetHashTable(AValue: TStringList);
begin
  if FHashTable = AValue then Exit;
  FHashTable := AValue;
end;

procedure TModelDmVendedor.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird = AValue then Exit;
  FModelConexaoFirebird := AValue;
end;

function TModelDmVendedor.ObterListaCodigoVendedors(pLista: TStrings): boolean;
var
  Qry: TZReadOnlyQuery;
  s: string;
begin
  HashTable.Clear;
  Qry := TZReadOnlyQuery.Create(nil);
  try
    Qry.Connection := FModelConexaoFirebird.ConexaoFirebird;
    Qry.SQL.Text := ' SELECT S106.CODVND, S106.NOMVND  FROM SINAF106 S106 ' +
      ' WHERE S106.STAATI = :ATIVO ORDER BY S106.NOMVND ';
    Qry.ParamByName('ATIVO').AsString := 'S';
    Qry.Open;
    while not Qry.EOF do
    begin
      s := Qry.FieldByName('NOMVND').AsString + ' [' +
        Qry.FieldByName('CODVND').AsString + ']';
      pLista.Add(s);
      HashTable.Values[s] := Qry.FieldByName('CODVND').AsString;
      Qry.Next;

    end;
  finally
    Qry.Free;
  end;
end;

end.
