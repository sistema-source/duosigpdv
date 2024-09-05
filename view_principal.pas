unit view_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, DBGrids, tabelas,
  conexao_sqllite,
  view_pai,
  view_fechamento_venda,
  view_consultar_orcamento,
  model_conexao_firebird,
  lib_cores, DB;

type

  { TViewPrincipal }

  TViewPrincipal = class(TViewPai)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    LblOpcoes: TLabel;
    LblConsultarProduto: TLabel;
    LblEncerrarVenda: TLabel;
    LblRemoverProduto: TLabel;
    LblVlrTotalMercadoria: TLabel;
    PnlOpcoes: TPanel;
    PnlBackRodape: TPanel;
    PnlEdtCodProduto: TPanel;
    PnlMensagem: TPanel;
    PnlBackGround: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LblEncerrarVendaClick(Sender: TObject);
  private

  procedure Teste;
  protected
    procedure ConfigurarComponentes; override;
  public

  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.lfm}

{ TViewPrincipal }

procedure TViewPrincipal.Button1Click(Sender: TObject);
var
  t: TTabelas;
begin
  t := TTabelas.Create;
  try
    t.CriarTabelas;
  finally
    FreeAndNil(t);
  end;

end;

procedure TViewPrincipal.DBGrid1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #27 then
    ShowMessage(IntToStr(DBGrid1.Columns[2].Width));
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  ConfigurarComponentes;
end;

procedure TViewPrincipal.FormResize(Sender: TObject);
begin
  DBGrid1.Columns[0].Width := Trunc(Self.Width * 2 / 100);
  DBGrid1.Columns[1].Width := Trunc(Self.Width * 18 / 100);
  DBGrid1.Columns[2].Width := Trunc(Self.Width * 40 / 100);
  DBGrid1.Columns[3].Width := Trunc(Self.Width * 8 / 100);
  DBGrid1.Columns[4].Width := Trunc(Self.Width * 14 / 100);
  DBGrid1.Columns[5].Width := Trunc(Self.Width * 14 / 100);
  DBGrid1.Repaint;
  Application.ProcessMessages;
end;

procedure TViewPrincipal.FormShow(Sender: TObject);
var
  v: TViewConsultaOrcamento;
begin
  v := TViewConsultaOrcamento.Create(self);
  try
    v.ShowModal;
  finally
    FreeAndNil(v);
  end;

end;

procedure TViewPrincipal.LblEncerrarVendaClick(Sender: TObject);
var
  F: TViewFechamentoVenda;
begin
  f := TViewFechamentoVenda.Create(Self);
  try
    f.BorderStyle := bsNone;
    f.ShowModal;
  finally
    f.Free;
  end;

end;

procedure TViewPrincipal.Teste;
var
   t : TModelConexaoFirebird;

begin
     t := TModelConexaoFirebird.Create(self);
     t.ConectarBanco;

end;

procedure TViewPrincipal.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;
  PnlBackGround.Color := TLibCores.BackGround;
  PnlBackGround.Caption := '';
  PnlBackGround.BevelOuter := bvNone;


  PnlMensagem.Color := TLibCores.BackMensagem;
  PnlMensagem.Caption := '';
  PnlMensagem.BevelOuter := bvNone;

  PnlEdtCodProduto.Color := TLibCores.BackAcessoProduto;
  PnlEdtCodProduto.Caption := '';
  PnlEdtCodProduto.BevelOuter := bvNone;

  PnlBackRodape.Color := TLibCores.BackAcessoProduto;
  PnlBackRodape.Caption := '';
  PnlBackRodape.BevelOuter := bvNone;


  PnlOpcoes.Color := TLibCores.BackAcessoProduto;
  PnlOpcoes.Caption := '';
  PnlOpcoes.BevelOuter := bvNone;

  LblOpcoes.Font.Color := TLibCores.BackGround;
  LblConsultarProduto.Font.Color := LblOpcoes.Font.Color;
  LblRemoverProduto.Font.Color := LblOpcoes.Font.Color;
  LblEncerrarVenda.Font.Color := LblOpcoes.Font.Color;
  LblVlrTotalMercadoria.Font.Color := LblOpcoes.Font.Color;

end;

end.
