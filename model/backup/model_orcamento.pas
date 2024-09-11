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
  private
    FModelConexaoFirebird: TModelConexaoFirebird;
    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
  public
    function ObterListaOrcamento(pDtSrc: TDataSource; pCodLoja: string;
      pDtInicial, pDtFinal: TDate; pNomeCliente: string): boolean;


      property ModelConexaoFirebird : TModelConexaoFirebird read FModelConexaoFirebird write SetModelConexaoFirebird;
  end;

  { TModelDmOrcamento }
  IModelOrcamento = interface             // guid ok
['{30ECCB7C-CE15-4292-9885-2CA8201FC0CA}']
    function ObterListaOrcamento(pDtSrc: TDataSource; pCodLoja: string;
      pDtInicial, pDtFinal: TDate; pNomeCliente: string): boolean;
  end;

  { TModelOrcamento }
  TModelOrcamento = class(TInterfacedObject, IModelOrcamento)
  private
    FModelDmOrcamento: TModelDmOrcamento;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IModelOrcamento;
    function ObterListaOrcamento(pDtSrc: TDataSource; pCodLoja: string;
      pDtInicial, pDtFinal: TDate; pNomeCliente: string): boolean;
  end;


var
  ModelDmOrcamento: TModelDmOrcamento;

implementation

{$R *.lfm}

procedure TModelDmOrcamento.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird=AValue then Exit;
  FModelConexaoFirebird:=AValue;

  QryPesquisaOrcamento.Connection := FModelConexaoFirebird.ConexaoFirebird;
end;

{ TModelDmOrcamento }
function TModelDmOrcamento.ObterListaOrcamento(pDtSrc: TDataSource;
  pCodLoja: string; pDtInicial, pDtFinal: TDate; pNomeCliente: string): boolean;
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
  s := s + ' where s052.codlja = :pCodlja and s052.dtaorc >= :pDt_inicial and s052.dtaorc <= :pDt_final ';

  if pNomeCliente <> '' then
    s := s + ' and s052.nomcli like :pNomeCliente';

  s := s + ' order by s052.codlja, s052.numorc descending ';

  QryPesquisaOrcamento.Connection := FModelConexaoFirebird.ConexaoFirebird;
  QryPesquisaOrcamento.SQL.Text := s;

  QryPesquisaOrcamento.ParamByName('pCodlja').AsString := pCodLoja;
  QryPesquisaOrcamento.ParamByName('pDt_inicial').AsDate := pDtInicial;
  QryPesquisaOrcamento.ParamByName('pDt_final').AsDate := pDtFinal;
  if pNomeCliente <> '' then
    QryPesquisaOrcamento.ParamByName('pNomeCliente').AsString := pNomeCliente + '%';
  QryPesquisaOrcamento.Open;

  TNumericField(QryPesquisaOrcamento.FieldbyName('vlrtotorc')).DisplayFormat:= '###,###,###,##0.00';
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

function TModelOrcamento.ObterListaOrcamento(pDtSrc: TDataSource;
  pCodLoja: string; pDtInicial, pDtFinal: TDate; pNomeCliente: string): boolean;
begin
  FModelDmOrcamento.ObterListaOrcamento(pDtSrc, pCodLoja, pDtInicial,
    pDtFinal, pNomeCliente);
end;

end.
