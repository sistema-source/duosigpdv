unit model_orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, Dialogs,
  DB,
  model_conexao_firebird;

type

  { TModelDmOrcamento }

  TModelDmOrcamento = class(TDataModule)
    QryPesquisaOrcamento: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FModelConexaoFirebird: TModelConexaoFirebird;
  public
    function ObterListaOrcamento(pDtSrc: TDataSource; pCodLoja: string; pDtInicial, pDtFinal: TDate): boolean;
  end;

  { TModelDmOrcamento }
  IModelOrcamento = interface
    ['{8B1953B4-0231-4B4A-A70B-268F287DF182}']
    function ObterListaOrcamento(pDtSrc: TDataSource; pCodLoja: string; pDtInicial, pDtFinal: TDate): boolean;
  end;

  { TModelOrcamento }
  TModelOrcamento = class(TInterfacedObject, IModelOrcamento)
  private
    FModelDmOrcamento: TModelDmOrcamento;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IModelOrcamento;
    function ObterListaOrcamento(pDtSrc: TDataSource; pCodLoja: string; pDtInicial, pDtFinal: TDate): boolean;
  end;


var
  ModelDmOrcamento: TModelDmOrcamento;

implementation

{$R *.lfm}

procedure TModelDmOrcamento.DataModuleCreate(Sender: TObject);
begin
  FModelConexaoFirebird := TModelConexaoFirebird.Create(nil);
end;

procedure TModelDmOrcamento.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FModelConexaoFirebird);
end;

{ TModelDmOrcamento }
function TModelDmOrcamento.ObterListaOrcamento(pDtSrc: TDataSource; pCodLoja: string; pDtInicial, pDtFinal: TDate): boolean;
var
  s: string;
begin
  QryPesquisaOrcamento.Close;
  s := '';
  s := s + ' select ';
  s := s + ' s052.codlja, ';
  s := s + ' s052.numorc, ';
    s := s + ' s052.codcli, ';

  s := s + ' s052.dtaorc, ';
  s := s + ' coalesce(s052.nomcli, s019.nomcli) as nomcli, ';
  s := s + ' s052.vlrtotorc ';
  s := s + ' from sinaf052 s052 ';
  s := s + ' left join sinaf019 s019 on s019.codcli = s052.codcli ';
  s := s + ' where s052.codlja = :codlja and s052.dtaorc >= :dt_inicial and s052.dtaorc <= :dt_final ';
  s := s + ' order by s052.codlja, s052.numorc descending ';

  QryPesquisaOrcamento.Connection := FModelConexaoFirebird.ConexaoFirebird;
  QryPesquisaOrcamento.SQL.Text := s;

  QryPesquisaOrcamento.ParamByName('codlja').AsString := pCodLoja;
  QryPesquisaOrcamento.ParamByName('dt_inicial').AsDate := pDtInicial;
  QryPesquisaOrcamento.ParamByName('dt_final').AsDate := pDtFinal;
  QryPesquisaOrcamento.Open;
  pDtSrc.DataSet := QryPesquisaOrcamento;
end;

{ TModelOrcamento }

constructor TModelOrcamento.Create;
begin
  FModelDmOrcamento := TModelDmOrcamento.Create(nil);
end;

destructor TModelOrcamento.Destroy;
begin
  FreeAndNil(FModelDmOrcamento);
  inherited Destroy;
end;

class function TModelOrcamento.New: IModelOrcamento;
begin
  Result := Self.Create;
end;

function TModelOrcamento.ObterListaOrcamento(pDtSrc: TDataSource; pCodLoja: string; pDtInicial, pDtFinal: TDate): boolean;
begin
  FModelDmOrcamento.ObterListaOrcamento(pDtSrc, pCodLoja, pDtInicial, pDtFinal);
end;

end.
