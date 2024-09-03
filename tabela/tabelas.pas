unit tabelas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model_conexao_sqlite, conexao_sqllite, tabela_cabecalho, tabela_interface;

type

  { TTabelas }

  TTabelas = class

    procedure CriarTabelas;
  end;

implementation

{ TTabelas }

procedure TTabelas.CriarTabelas;
var
  sqlConexao: TConexaoSQLIte;
  TTabela: ITabela;
begin
  sqlConexao := TConexaoSQLIte.Create(nil);
  try
    sqlConexao.CriarBanco;
    TTabelaCabecalho.New.CriarTabela(sqlConexao.SQLCon, sqlConexao.SQLTrans, sqlConexao.NomeBanco);
  finally
    FreeAndNil(sqlConexao);
  end;

end;

end.
