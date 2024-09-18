unit model_cliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model_conexao_firebird, ZDataset;

type

  { TModelDmCliente }

  TModelDmCliente = class(TDataModule)
    QryConsulta: TZQuery;
  private
    FModelConexaoFirebird: TModelConexaoFirebird;
    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird);

  public


    procedure ObterListaCliente(pTipoPesquisa, pVlrPesquisa: string);

    function ObterDadosCliente(pCodCliente: integer;
      out pCnpj, pNomeCliente, pCep, pEndereco, pBairro, pCodMunicipio,
      pMunicipio, pTelefone, pEmail, pUF: string): boolean;


    property ModelConexaoFirebird: TModelConexaoFirebird
      read FModelConexaoFirebird write SetModelConexaoFirebird;

  end;

var
  ModelDmCliente: TModelDmCliente;

implementation

{$R *.lfm}

{ TModelDmCliente }

procedure TModelDmCliente.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird = AValue then Exit;
  FModelConexaoFirebird := AValue;
  QryConsulta.Connection := FModelConexaoFirebird.ConexaoFirebird;
end;

procedure TModelDmCliente.ObterListaCliente(pTipoPesquisa, pVlrPesquisa: string);
var
  s, LWhere, LOrderBy: string;
begin
  QryConsulta.Connection := FModelConexaoFirebird.ConexaoFirebird;
  QryConsulta.Close;
  s := '';
  s := s + 'select s019.codcli,';
  s := s + ' s019.cgccpfcli, ';
  s := s + ' s019.nomcli ';
  s := s + ' from sinaf019 s019 ';
  s := s + ' where coalesce(s019.staati,'+QuotedStr('S')+ ') = '+QuotedStr('S');

  LWhere := '';
  LOrderBy := '';
  if pTipoPesquisa = 'Código' then
  begin
    LWhere := LWhere + ' and  s019.codcli = :pVlrPesquisa';
  end
  else if pTipoPesquisa = 'Cnpj/Cpf' then
  begin
    LWhere := LWhere + ' and  s019.cgccpfcli = :pVlrPesquisa';
  end
  else if pTipoPesquisa = 'Nome' then
  begin
    LWhere := LWhere + ' and  s019.nomcli like :pVlrPesquisa';
    pVlrPesquisa := pVlrPesquisa + '%';
    LOrderBy := LOrderBy + ' ORDER BY s019.nomcli ';
  end;
  QryConsulta.SQL.Text := s + LWhere + LOrderBy;

  QryConsulta.ParamByName('pVlrPesquisa').AsString := pVlrPesquisa;
  QryConsulta.Open;
end;

function TModelDmCliente.ObterDadosCliente(pCodCliente: integer;
  out pCnpj, pNomeCliente, pCep, pEndereco, pBairro, pCodMunicipio,
  pMunicipio, pTelefone, pEmail, pUf: string): boolean;
var
  Qry: TZReadOnlyQuery;
  s: string;
begin
  s := 'select s019.codcli, s019.nomcli, s019.cgccpfcli, s019.cepcli, s019.endcli, s019.baicli, s019.codmunibge, s019.muncli, s019.ufdcli,  s019.emailcli,  s019.staati, ';
  s := s + ' (select first 1 s082.numtel from sinaf082 s082 where s082.codcli = s019.codcli and   s082.statpo = ' + QuotedStr('T');
  s := s + ' and   s082.numtel <> ' + QuotedStr('') + ') as numtel ';
  s := s + ' from sinaf019 s019 ';
  s := s + ' where s019.codcli = :pCodCliente';
  Qry := TZReadOnlyQuery.Create(nil);
  Qry.Connection := FModelConexaoFirebird.ConexaoFirebird;
  try
    Qry.SQL.Text := s;
    Qry.ParamByName('pCodCliente').AsInteger := pCodCliente;
    Qry.Open;

    // Cliente inativo não faz venda
    If Qry.FieldbyName('STAATI').AsString = 'N' then
    begin
      raise Exception.Create('Cliente inativo');
    end;

    Result := not Qry.IsEmpty;
    pCnpj := Qry.FieldByName('cgccpfcli').AsString;
    pNomeCliente := Qry.FieldByName('nomcli').AsString;
    pCep := Qry.FieldByName('cepcli').AsString;
    pEndereco := Qry.FieldByName('endcli').AsString;
    pBairro := Qry.FieldByName('baicli').AsString;
    pCodMunicipio := Qry.FieldByName('codmunibge').AsString;
    pMunicipio := Qry.FieldByName('muncli').AsString;
    pTelefone := Qry.FieldByName('numtel').AsString;
    pEmail := Qry.FieldByName('emailcli').AsString;
    pUf := Qry.FieldByName('ufdcli').AsString;
  finally
    Qry.Free;
  end;
end;

end.
