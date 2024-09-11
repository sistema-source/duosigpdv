unit tabelas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model_conexao_sqlite, conexao_sqllite,
  tabela_cabecalho,
  tabela_detalhe,
  tabela_forma_pagto,
  tabela_interface;

type

  { TTabelas }

  TTabelas = class

  private
    FExisteCabecalho: boolean;
    FExisteDetalhe: boolean;
    FExisteFormaPagto: boolean;
    procedure SetExisteCabecalho(AValue: boolean);
    procedure SetExisteDetalhe(AValue: boolean);
    procedure SetExisteRecebimento(AValue: boolean);
  public
    procedure CriarTabelas;
    function ExisteBanco: boolean;

    constructor Create;
    property ExisteCabecalho: boolean read FExisteCabecalho write SetExisteCabecalho;
    property ExisteDetalhe: boolean read FExisteDetalhe write SetExisteDetalhe;
    property ExisteRecebimento: boolean read FExisteFormaPagto
      write SetExisteRecebimento;

  end;

implementation

{ TTabelas }

procedure TTabelas.SetExisteCabecalho(AValue: boolean);
begin
  if FExisteCabecalho = AValue then Exit;
  FExisteCabecalho := AValue;
end;

procedure TTabelas.SetExisteDetalhe(AValue: boolean);
begin
  if FExisteDetalhe = AValue then Exit;
  FExisteDetalhe := AValue;
end;

procedure TTabelas.SetExisteRecebimento(AValue: boolean);
begin
  if FExisteFormaPagto = AValue then Exit;
  FExisteFormaPagto := AValue;
end;

procedure TTabelas.CriarTabelas;
var
  sqlConexao: TConexaoSQLIte;
  TTabela: ITabela;
begin
  sqlConexao := TConexaoSQLIte.Create(nil);
  try
    sqlConexao.CriarBanco;

    if not FExisteCabecalho then
      TTabelaCabecalho.New.CriarTabela(sqlConexao.SQLCon, sqlConexao.SQLTrans,
        sqlConexao.NomeBanco);

    if not FExisteDetalhe then
      TTabelaDetalhe.New.CriarTabela(sqlConexao.SQLCon, sqlConexao.SQLTrans,
        sqlConexao.NomeBanco);

    if not FExisteFormaPagto then
      TTabelaFormaPagto.New.CriarTabela(sqlConexao.SQLCon, sqlConexao.SQLTrans,
        sqlConexao.NomeBanco);

  finally
    FreeAndNil(sqlConexao);
  end;

end;

function TTabelas.ExisteBanco: boolean;
var
  d, m, a: word;
  s: string;
begin
  Result := False;
  DecodeDate(Date, a, m, d);
  s := ExtractFilePath(ParamStr(0)) + 'DadosLocal\Banco-Sql-' +
    IntToStr(a) + '-' + IntToStr(m) + '-' + IntToStr(d) + '.Db';

  if FileExists(s) then
    Result := True;
end;

constructor TTabelas.Create;
begin
  FExisteCabecalho := False;
  FExisteDetalhe := False;
  FExisteFormaPagto := False;
end;

end.
