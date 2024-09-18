unit model_fornecedor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model_conexao_firebird, ZDataset;

type

  { TModelDmFornecedor }

  TModelDmFornecedor = class(TDataModule)
    QryConsulta: TZQuery;
  private
    FModelConexaoFirebird: TModelConexaoFirebird;
    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird);

  public


    procedure ObterListaFornecedor(pTipoPesquisa, pVlrPesquisa: string);

    function ObterCpjRazaoSocialFornecedor(pCodFornecedor: integer;
      out pCnpj: string; out pRazaoSocial: string): boolean;


    property ModelConexaoFirebird: TModelConexaoFirebird
      read FModelConexaoFirebird write SetModelConexaoFirebird;




  end;

var
  ModelDmFornecedor: TModelDmFornecedor;

implementation

{$R *.lfm}

{ TModelDmFornecedor }

procedure TModelDmFornecedor.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird = AValue then Exit;
  FModelConexaoFirebird := AValue;
end;

procedure TModelDmFornecedor.ObterListaFornecedor(pTipoPesquisa, pVlrPesquisa: string);
var
  s, LWhere, LOrderBy: string;
begin
  QryConsulta.Connection := FModelConexaoFirebird.ConexaoFirebird;
  QryConsulta.Close;
  s := '';
  s := s + 'select s029.codfrn,';
  s := s + ' s029.cgcfrn, ';
  s := s + ' s029.razfrn ';
  s := s + ' from sinaf029 s029 ';
  LWhere := '';
  LOrderBy := '';
  if pTipoPesquisa = 'Código' then
  begin
    LWhere := LWhere + ' WHERE s029.codfrn = :pVlrPesquisa';
  end
  else if pTipoPesquisa = 'Cnpj/Cpf' then
  begin
    LWhere := LWhere + ' WHERE s029.cgcfrn = :pVlrPesquisa';
  end
  else if pTipoPesquisa = 'Razão Social' then
  begin
    LWhere := LWhere + ' WHERE s029.razfrn like :pVlrPesquisa';
    pVlrPesquisa := pVlrPesquisa + '%';
    LOrderBy := LOrderBy + ' ORDER BY s029.razfrn';
  end;
  QryConsulta.SQL.Text := s + LWhere + LOrderBy;

  QryConsulta.ParamByName('pVlrPesquisa').AsString := pVlrPesquisa;
  QryConsulta.Open;

end;

function TModelDmFornecedor.ObterCpjRazaoSocialFornecedor(pCodFornecedor: integer;
  out pCnpj: string; out pRazaoSocial: string): boolean;
var
  Qry: TZReadOnlyQuery;
  s: string;
begin
  s := 'select s029.codfrn, s029.razfrn, s029.cgcfrn from sinaf029 s029 ';
  s := s + ' where s029.codfrn = :pCodFornecedor';
  Qry := TZReadOnlyQuery.Create(nil);
  Qry.Connection := FModelConexaoFirebird.ConexaoFirebird;
  try
    Qry.SQL.Text := s;
    Qry.ParamByName('pCodFornecedor').AsInteger := pCodFornecedor;
    Qry.Open;
    Result := not Qry.IsEmpty;
    pCnpj := Qry.FieldByName('cgcfrn').AsString;
    pRazaoSocial := Qry.FieldByName('razfrn').AsString;
  finally
    Qry.Free;
  end;
end;

end.
