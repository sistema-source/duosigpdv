unit model_loja;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, model_conexao_firebird;

type
  { TModelDmLoja }
  TModelDmLoja = class(TDataModule)
    ZQuery1: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FModelConexaoFirebird: TModelConexaoFirebird;
  public
    function ObterListaCodigoLojas(pLista: TStrings): boolean;
  end;

  IModelLoja = interface
    ['{F423AD5C-6958-4547-A27C-3319D28187DA}']
    function ObterListaCodigoLojas(pLista: TStrings): boolean;
  end;

  { TModelLoja }
  TModelLoja = class(TInterfacedObject, IModelLoja)
  private
    FModelDmLoja: TModelDmLoja;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IModelLoja;

    function ObterListaCodigoLojas(pLista: TStrings): boolean;
  end;



implementation

{$R *.lfm}

{ TModelLoja }

constructor TModelLoja.Create;
begin
  FModelDMLoja := TModelDMLoja.Create(nil);
end;

destructor TModelLoja.Destroy;
begin
  FreeAndNil(FModelDMLoja);
  inherited Destroy;
end;

class function TModelLoja.New: IModelLoja;
begin
  Result := Self.Create;
end;

function TModelLoja.ObterListaCodigoLojas(pLista: TStrings): boolean;
begin
  FModelDmLoja.ObterListaCodigoLojas(pLista);
  Result := True;
end;

{ TModelDmLoja }

procedure TModelDmLoja.DataModuleCreate(Sender: TObject);
begin
  FModelConexaoFirebird := TModelConexaoFirebird.Create(nil);
end;

procedure TModelDmLoja.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FModelConexaoFirebird);
end;

function TModelDmLoja.ObterListaCodigoLojas(pLista: TStrings): boolean;
var
  Qry: TZReadOnlyQuery;
begin
  Qry := TZReadOnlyQuery.Create(nil);
  try
    Qry.Connection := FModelConexaoFirebird.ConexaoFirebird;
    Qry.SQL.Text := ' SELECT S018.CODLJA FROM SINAF018 S018 ' + ' WHERE S018.STAATI = :ATIVA ORDER BY S018.CODLJA ';
    Qry.ParamByName('ATIVA').AsString := 'S';
    Qry.Open;
    while not Qry.EOF do
    begin
      pLista.Add(Qry.FieldByName('CODLJA').AsString);
      Qry.Next;
    end;
  finally
    Qry.Free;
  end;
end;

end.
