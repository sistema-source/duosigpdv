program duosigpdv;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, view_principal, rxnew, lib_cores, view_pai, conexao_sqllite, model_conexao_sqlite, tabela_cabecalho, tabela_interface, tabela_pai, tabelas, view_fechamento_venda, lib_imagelist, 
view_consultar_orcamento, model_conexao_firebird, zcomponent, model_loja;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.

