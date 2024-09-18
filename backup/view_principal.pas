unit view_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, DBGrids, DBCtrls, EditBtn, tabelas,
  conexao_sqllite,
  uJKDialog,
  util_teclas,
  view_pai,
  View_blend,
  view_serie_nf,
  view_fechamento_venda,
  view_consultar_orcamento,
  view_consulta_produto,
  view_cliente,
  view_transporte,
  view_vendedor,
  view_cnpj_cpf,
  view_opcoes,
  view_mensagem_carregar_dados,
  model_conexao_firebird,
  model_conexao_sqlite,
  model_produto,
  model_venda,
  model_sessao,
  model_configuracao_pdv,
  lib_cores,
  lib_funcoes,
  BCButton, ACBrEnterTab, DB;

type

  { TViewPrincipal }
  TViewPrincipal = class(TViewPai)
    ACBrEnterTab1: TACBrEnterTab;
    DtSrcCabecalho: TDataSource;
    EdtVlrNF: TDBEdit;
    DtSrcDetalhe: TDataSource;
    DtSrcProduto: TDataSource;
    DBGrid1: TDBGrid;
    EdtCodProduto: TEdit;
    LblOpcoes: TLabel;
    LblConsultarProduto: TLabel;
    LblEncerrarVenda: TLabel;
    LblConsultarOrcamento: TLabel;
    LblVlrTotalMercadoria: TLabel;
    PnlOpcoes: TPanel;
    PnlBackRodape: TPanel;
    PnlEdtCodProduto: TPanel;
    PnlMensagem: TPanel;
    PnlBackGround: TPanel;
    procedure DBGrid1KeyPress(Sender: TObject; var Key: char);
    procedure EdtCodProdutoKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LblConsultarProdutoClick(Sender: TObject);
    procedure LblEncerrarVendaClick(Sender: TObject);
    procedure LblConsultarOrcamentoClick(Sender: TObject);
    procedure LblOpcoesClick(Sender: TObject);
  private
    FModelVenda: TModelDmVenda;
    FModelProduto: TModelDmProduto;
    FQtdProduto: currency;
    FViewConsultaProduto: TViewConsultaProduto;
    FViewConsultaOrcamento: TViewConsultaOrcamento;
    FViewSerieNf: TViewSerieNf;
    procedure SetQtdProduto(AValue: currency);
    procedure Teste;
    procedure InserirProduto;
    procedure CriarTabelas;

  protected
    procedure ConfigurarComponentes; override;
  public
    procedure AjustarQtdade;
    procedure MostrarMensagem(pMensagem: string);

    property QtdProduto: currency read FQtdProduto write SetQtdProduto;
  end;


var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.lfm}

{ TViewPrincipal }

procedure TViewPrincipal.DBGrid1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #27 then
    ShowMessage(IntToStr(DBGrid1.Columns[2].Width));
end;

procedure TViewPrincipal.EdtCodProdutoKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    InserirProduto;
  end;

end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin

  ConfigurarComponentes;

  ModelConexaoFirebird := TModelConexaoFirebird.Create(Self);

  FModelVenda := TModelDmVenda.Create(self);
  DtSrcDetalhe.DataSet := FModelVenda.QryDetalhe;
  DtSrcCabecalho.DataSet := FModelVenda.QryCabecalho;

  FModelProduto := TModelDmProduto.Create(self);
  FModelProduto.ModelConexaoFirebird := ModelConexaoFirebird;

  ModelConfiguracaoPdv := TModelConfiguracaoPdv.Create(Self);
  ModelConfiguracaoPdv.ModelConexaoFirebird := ModelConexaoFirebird;

  FQtdProduto := 1;

  CriarTabelas;

  TModelSessao.Usuario := 'DUOTEC';

end;

procedure TViewPrincipal.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    LblOpcoesClick(Sender);
  end
  else if key = VK_F2 then
  begin
    LblEncerrarVendaClick(Sender);
  end
  else if key = VK_F3 then
  begin
    LblConsultarProdutoClick(Sender);
  end
  else if key = VK_F4 then
  begin
    LblConsultarOrcamentoClick(Sender);
  end
  else if key = VK_F5 then
  begin
    EdtCodProduto.Clear;
    EdtCodProduto.SetFocus;
  end
  else if key = VK_F8 then
  begin
    AjustarQtdade;
  end
  else if key = VK_ESC then
  begin
    FModelVenda.CancelarVenda(FModelVenda.Id);
    Close;
  end;
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
begin
  MostrarMensagem('CAIXA LIVRE');
  ModelConfiguracaoPdv.CarregarDadosPadrao(TModelSessao.Usuario);

end;

procedure TViewPrincipal.LblConsultarProdutoClick(Sender: TObject);
var
  v: TViewMensagemCarregarDados;

begin

  try
    Screen.Cursor := crSQLWait;
    Blend(True);

    if not Assigned(FViewConsultaProduto) then
    begin
      try
        v := TViewMensagemCarregarDados.Create(Self);
        v.LblMensagem.Font.Color := TLibCores.Info;
        v.LblMensagem.Caption := 'AGUARDE!!!!  Carregando ...';
        v.Color := TLibCores.Gelo;
        v.Show;
        Application.ProcessMessages;
        FViewConsultaProduto := TViewConsultaProduto.Create(Self);
        FViewConsultaProduto.ModelConexaoFirebird := ModelConexaoFirebird;
        FViewConsultaProduto.BorderStyle := bsNone;
      finally
        FreeAndNil(v);
      end;
    end;
    Screen.Cursor := crDefault;
    FViewConsultaProduto.ShowModal;

    // Selecionou um produto
    if FViewConsultaProduto.Tag = 1 then
    begin
      if FViewConsultaProduto.DtSrcConsultaProduto.DataSet.RecordCount > 0 then
      begin
        EdtCodProduto.Text := FViewConsultaProduto.CodProduto;
        InserirProduto;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    Blend(False);
  end;
end;

procedure TViewPrincipal.LblEncerrarVendaClick(Sender: TObject);
var
  F: TViewFechamentoVenda;
begin
  if not Assigned(FViewSerieNf) then
  begin
    FViewSerieNf := TViewSerieNf.Create(Self);
    FViewSerieNf.BorderStyle := bsNone;
    FViewSerieNf.ModelVenda := FModelVenda;
  end;
  Blend(True);
  try
    FViewSerieNf.ShowModal;
  finally
    Blend(False);
  end;

  if FViewSerieNf.Tag = 0 then
    exit;

  f := TViewFechamentoVenda.Create(Self);
  try
    f.DtSrcCabecalho.DataSet := DtSrcCabecalho.DataSet;
    f.DtSrcFormaPagto.DataSet := FModelVenda.QryFormaPagto;
    f.ModelVenda := FModelVenda;
    f.ModelConexaoFirebird := ModelConexaoFirebird;
    f.PnlMensagemVenda := PnlMsg;
    f.BorderStyle := bsNone;
    Blend(True);
    f.ShowModal;
  finally
    Blend(False);
    f.Free;
  end;
end;

procedure TViewPrincipal.LblConsultarOrcamentoClick(Sender: TObject);
var
  v: TViewMensagemCarregarDados;
begin

  Blend(True);
  try
    if not Assigned(FViewConsultaOrcamento) then
    begin
      try
        v := TViewMensagemCarregarDados.Create(Self);
        v.LblMensagem.Font.Color := TLibCores.Info;
        v.LblMensagem.Caption := 'AGUARDE!!!!  Carregando ...';
        v.Color := TLibCores.Gelo;
        v.Show;
        Application.ProcessMessages;
        FViewConsultaOrcamento := TViewConsultaOrcamento.Create(Self);
        FViewConsultaOrcamento.BorderStyle := bsNone;
        FViewConsultaOrcamento.ModelConexaoFirebird := ModelConexaoFirebird;
      finally
        FreeAndNil(v);
      end;
    end;
    FViewConsultaOrcamento.ShowModal;
    if FViewConsultaOrcamento.Tag = 1 then
    begin
      try
        FModelVenda.CarregarDadosOrcamento(
          FViewConsultaOrcamento.DtSrcOrcamento.DataSet.FieldByName('CODLJA').AsString,
          FViewConsultaOrcamento.DtSrcOrcamento.DataSet.FieldByName('NUMORC').AsString);
      finally
      end;
    end;
  finally
    Blend(False);
  end;

end;

procedure TViewPrincipal.LblOpcoesClick(Sender: TObject);
var
  V: TViewOpcoes;
begin
  V := TViewOpcoes.Create(Self);

  try
    Blend(True);
    v.BorderStyle := bsNone;
    v.ModelConexaoFirebird := ModelConexaoFirebird;
    v.ModelVenda := FModelVenda;
    v.PnlMensagem := PnlMensagem;
    V.ShowModal;
    Blend(False);
  finally
    FreeAndNil(V);
  end;
end;

procedure TViewPrincipal.Teste;
var
  t: TModelConexaoFirebird;

begin
  t := TModelConexaoFirebird.Create(self);
  t.ConectarBanco;

end;

procedure TViewPrincipal.SetQtdProduto(AValue: currency);
begin
  if FQtdProduto = AValue then Exit;
  FQtdProduto := AValue;
end;



procedure TViewPrincipal.InserirProduto;
begin
  if FModelProduto.ObterProdutoParaPdv(DtSrcProduto, ModelConfiguracaoPdv.CodLoja,
    EdtCodProduto.Text) then
  begin

    FModelVenda.InserirCabecalhoVenda;
    MostrarMensagem('VENDA EM ANDAMENTO');
    if DtSrcProduto.DataSet.FieldByName('VLRBASVDA').AsCurrency = 0 then
    begin
      Blend(True);
      JKDialog('Mensagem', 'Produto com valor zerado não pode ser inserido',
        tdAlerta);
      Blend(False);
      EdtCodProduto.Clear;
      EdtcodProduto.SetFocus;
    end
    else
    begin
      FModelVenda.InserirDetalheVenda(DtSrcProduto, FQtdProduto);
      EdtCodProduto.Clear;
      EdtcodProduto.SetFocus;
    end;
  end
  else
  begin
    Blend(True);
    JKDialog('Mensagem', 'Produto não cadastrado', tdAlerta);
    Blend(False);
    EdtCodProduto.Clear;
    EdtcodProduto.SetFocus;
  end;
  FQtdProduto := 1;
end;

procedure TViewPrincipal.CriarTabelas;
var
  t: TTabelas;
begin
  t := TTabelas.Create;
  try
    if not T.ExisteBanco then
      t.CriarTabelas;
  finally
    FreeAndNil(t);
  end;

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
  PnlMensagem.Font.Size := 18;

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
  LblConsultarOrcamento.Font.Color := LblOpcoes.Font.Color;
  LblEncerrarVenda.Font.Color := LblOpcoes.Font.Color;
  LblVlrTotalMercadoria.Font.Color := LblOpcoes.Font.Color;


  EdtVlrNf.Font.Color := LblVlrTotalMercadoria.Font.Color;
  EdtVlrNf.Color := PnlBackRodape.Color;

  EdtCodProduto.Font.Color := LblVlrTotalMercadoria.Font.Color;
  EdtCodProduto.Color := PnlBackRodape.Color;

  ACBrEnterTab1.EnterAsTab := False;

end;

procedure TViewPrincipal.AjustarQtdade;
begin

end;

procedure TViewPrincipal.MostrarMensagem(pMensagem: string);
begin
  PnlMensagem.Caption := pMensagem;
end;

end.
