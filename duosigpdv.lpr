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
  view_consultar_orcamento, model_conexao_firebird, zcomponent, model_loja, model_orcamento, model_produto, model_venda, model_configuracao_pdv, lib_funcoes, view_mensagem_erro, view_blend,
  util_teclas, tabela_forma_pagto, view_consulta, view_cliente, view_serie_nf, view_transporte, model_vendedor, model_cliente, model_fornecedor, view_opcoes, view_cnpj_cpf, view_vendedor,
  view_consulta_cliente, view_consulta_municipio, view_consulta_fornecedor, view_mensagem_carregar_dados, view_login, view_consulta_produto;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TLibImagem, LibImagem);
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.CreateForm(TViewConsultaCliente, ViewConsultaCliente);
  Application.CreateForm(TViewConsultaMunicipio, ViewConsultaMunicipio);
  Application.CreateForm(TViewConsultaFornecedor, ViewConsultaFornecedor);
  Application.CreateForm(TViewMensagemCarregarDados, ViewMensagemCarregarDados);
  Application.CreateForm(TViewLogin, ViewLogin);
  Application.Run;
end.

