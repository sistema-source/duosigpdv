unit view_fechamento_venda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, Buttons, DBCtrls, rxcurredit, rxdbcurredit, view_pai,
  lib_cores, uJKDialog,
  lib_imagelist, ACBrEnterTab, ACBrTEFD, DB,
  model_conexao_firebird,
  model_venda, util_teclas,
  model_paygo_tef,
  model_configuracao_pdv,
  BCButtonFocus;

type
  { TViewFechamentoVenda }
  TViewFechamentoVenda = class(TViewPai)
    ACBrEnterTab1: TACBrEnterTab;
    ACBrTEFD1: TACBrTEFD;
    BCButtonFocus1: TBCButtonFocus;
    BtnInserirFormaPagto: TBCButtonFocus;
    BtnVoltar: TBCButtonFocus;
    ChkBxVendaPresencial: TCheckBox;
    CmbBxFormaPagto: TComboBox;
    DtSrcFormaPagto: TDataSource;
    DtSrcCabecalho: TDataSource;
    EdtVlrLancamento: TCurrencyEdit;
    DBGrid1: TDBGrid;
    GrpBxFormaPagto: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    LblMensagem: TLabel;
    LblVlrTotalVenda: TLabel;
    LblVlrAcrescimo: TLabel;
    LblVlrDesconto: TLabel;
    LblVlrTotalReceber: TLabel;
    LblVlrRecebido: TLabel;
    LblVlrSaldo: TLabel;
    LblVlrTroco: TLabel;
    Panel1: TPanel;
    EdtVlrTotalVenda: TRxDBCurrEdit;
    EdtVlrAcrescimos: TRxDBCurrEdit;
    EdtVlrDescontos: TRxDBCurrEdit;
    EdtVlrTotalReceber: TRxDBCurrEdit;
    EdtVlrTotalRecebido: TRxDBCurrEdit;
    EdtVlrSaldo: TRxDBCurrEdit;
    EdtVlrTroco: TRxDBCurrEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    PnlTitulo: TPanel;
    PnlBackFechamentoVenda: TPanel;
    procedure BtnInserirFormaPagtoClick(Sender: TObject);
    procedure CmbBxFormaPagtoEnter(Sender: TObject);
    procedure CmbBxFormaPagtoExit(Sender: TObject);
    procedure CmbBxFormaPagtoKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure EdtVlrLancamentoKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SpdBtnVoltarClick(Sender: TObject);
  private

    PnlMsg, PnlMsgCliente, PnlMsgOperador: TPanel;
    MmLog: TMemo;
    FDoc001: string;
    FDoc002: string;
    FModelPayGoTef: TModelPayGoTef;

    FModelVenda: TModelDmVenda;
    FNomeBandeira: string;
    FNumAutorizacao: string;
    FPnlMensagemVenda: TPanel;
    procedure SetDoc001(AValue: string);
    procedure SetDoc002(AValue: string);
    procedure SetModelPayGoTef(AValue: TModelPayGoTef);
    procedure SetModelVenda(AValue: TModelDmVenda);
    procedure SetNomeBandeira(AValue: string);
    procedure SetNumAutorizacao(AValue: string);
    procedure MostrarMensagemErro(Sender: TObject; E: Exception);
    procedure EncerrarVenda;
    procedure SetPnlMensagemVenda(AValue: TPanel);
    procedure CriarFormularioModelPayGoTef;

  protected
    procedure ConfigurarComponentes; override;
  public



    property ModelVenda: TModelDmVenda read FModelVenda write SetModelVenda;
    property NomeBandeira: string read FNomeBandeira write SetNomeBandeira;
    property NumAutorizacao: string read FNumAutorizacao write SetNumAutorizacao;
    property Doc001: string read FDoc001 write SetDoc001;
    property Doc002: string read FDoc002 write SetDoc002;
    property PnlMensagemVenda: TPanel read FPnlMensagemVenda write SetPnlMensagemVenda;

    property ModelPayGoTef: TModelPayGoTef read FModelPayGoTef write SetModelPayGoTef;
  end;

var
  ViewFechamentoVenda: TViewFechamentoVenda;

implementation

{$R *.lfm}

{ TViewFechamentoVenda }

procedure TViewFechamentoVenda.SpdBtnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TViewFechamentoVenda.EdtVlrLancamentoKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if not Assigned(FModelVenda) then
      raise Exception.Create('Não foi atribuido a variável ModelVenda');

    BtnInserirFormaPagtoClick(Sender);

    CmbBxFormaPagto.SetFocus;
  end;
end;

procedure TViewFechamentoVenda.FormCreate(Sender: TObject);
begin
  inherited;
  PnlMsgCliente := TPanel.Create(self);
  PnlMsgOperador := TPanel.Create(Self);
  PnlMsg := TPanel.Create(Self);
  MmLog := TMemo.Create(Self);
end;

procedure TViewFechamentoVenda.FormKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then
  begin
    Blend(True);
    if JKDialog('Mensagem', 'Deseja apagar a forma de pagamento [' +
      DtSrcFormaPagto.DataSet.FieldByName('DESCRICAO_FORMA_PAGTO').AsString +
      '] com o valor de R$ ' + FormatFloat('###,###,###,##0.00',
      DtSrcFormaPagto.DataSet.FieldByName('VLR_FORMA_PAGTO').AsCurrency) +
      ' ? ', tdConfirmacao) then
    begin
      FModelVenda.ApagarFormaPagto(DtSrcFormaPagto.DataSet.FieldByName('ID').AsString);
    end;
    Blend(False);
  end;

  if Key = VK_ESC then
  begin
    SpdBtnVoltarClick(Sender);
  end;

end;

procedure TViewFechamentoVenda.FormShow(Sender: TObject);
begin
  LblMensagem.Caption := '';
  Application.OnException := @MostrarMensagemErro;
end;

procedure TViewFechamentoVenda.CmbBxFormaPagtoExit(Sender: TObject);
begin
  EdtVlrLancamento.Clear;
end;

procedure TViewFechamentoVenda.CmbBxFormaPagtoKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    EdtVlrLancamento.SetFocus;
end;

procedure TViewFechamentoVenda.BtnInserirFormaPagtoClick(Sender: TObject);
begin

  try
    PnlMsg.Visible := True;

    if (CmbBxFormaPagto.Text = 'TEF CRÉDITO') or
      (CmbBxFormaPagto.Text = 'TEF DÉBITO') then
    begin
      Blend(True);
      if not Assigned(ModelPayGoTef) then
        CriarFormularioModelPayGoTef;

      ModelPayGoTef.ModeloFiscal := '99';
      ModelPayGoTef.ConfigurarImpressora;
    end;
    if CmbBxFormaPagto.Text = 'TEF CRÉDITO' then
      If Not modelPayGoTef.VenderCartaoCredito('', EdtVlrLancamento.Value) then
      begin
        CmbBxFormaPagto.SetFocus;
        Abort;
      end;

    if CmbBxFormaPagto.Text = 'TEF DÉBITO' then
      modelPayGoTef.VenderCartaoDebito('', EdtVlrLancamento.Value);

    if (CmbBxFormaPagto.Text = 'TEF CRÉDITO') or
      (CmbBxFormaPagto.Text = 'TEF DÉBITO') then
    begin
      FDoc001 := ModelPayGoTef.Doc001;
      FDoc002 := ModelPayGoTef.Doc002;
      FNomeBandeira := ModelPayGoTef.Bandeira;
      FNumAutorizacao := ModelPayGoTef.CodAutorizacao;
    end;

    FModelVenda.InserirFormaPagto(CmbBxFormaPagto.Text, EdtVlrLancamento.Value,
      FNomeBandeira, FNumAutorizacao, Doc001, Doc002);
  finally
    Blend(False);
    PnlMsg.Visible := False;
  end;
  CmbBxFormaPagto.SetFocus;
end;

procedure TViewFechamentoVenda.CmbBxFormaPagtoEnter(Sender: TObject);
begin
  if EdtVlrTotalRecebido.Value >= EdtVlrTotalReceber.Value then
  begin
    EncerrarVenda;
  end;
end;

procedure TViewFechamentoVenda.SetModelVenda(AValue: TModelDmVenda);
begin
  if FModelVenda = AValue then Exit;
  FModelVenda := AValue;
end;

procedure TViewFechamentoVenda.SetModelPayGoTef(AValue: TModelPayGoTef);
begin
  if FModelPayGoTef = AValue then Exit;
  FModelPayGoTef := AValue;
end;

procedure TViewFechamentoVenda.SetDoc001(AValue: string);
begin
  if FDoc001 = AValue then Exit;
  FDoc001 := AValue;
end;

procedure TViewFechamentoVenda.SetDoc002(AValue: string);
begin
  if FDoc002 = AValue then Exit;
  FDoc002 := AValue;
end;


procedure TViewFechamentoVenda.SetNomeBandeira(AValue: string);
begin
  if FNomeBandeira = AValue then Exit;
  FNomeBandeira := AValue;
end;

procedure TViewFechamentoVenda.SetNumAutorizacao(AValue: string);
begin
  if FNumAutorizacao = AValue then Exit;
  FNumAutorizacao := AValue;
end;

procedure TViewFechamentoVenda.MostrarMensagemErro(Sender: TObject; E: Exception);
begin
  Blend(True);
  JKDialog('Mensagem', e.Message, tdMensagem);
  Blend(False);
end;

procedure TViewFechamentoVenda.EncerrarVenda;
begin
  LblMensagem.Caption := 'ENCERRANDO  VENDA ...';
  try
    Application.ProcessMessages;
    If ChkBxVendaPresencial.Checked then
      ModelVenda.IndPresenca:= 'S'
    Else
    ModelVenda.IndPresenca:= 'N';

    ModelVenda.EncerrarVenda;

  except
    on e: Exception do
    begin
      LblMensagem.Caption := '';
      CmbBxFormaPagto.SetFocus;
      raise Exception.Create(e.message);
    end;
  end;
  FModelVenda.NovaVenda;
  PnlMensagemVenda.Caption := 'CAIXA LIVRE';
  Close;
end;

procedure TViewFechamentoVenda.SetPnlMensagemVenda(AValue: TPanel);
begin
  if FPnlMensagemVenda = AValue then Exit;
  FPnlMensagemVenda := AValue;
end;

procedure TViewFechamentoVenda.CriarFormularioModelPayGoTef;
begin
  ModelPayGoTef := TModelPayGoTef.Create(self);
  ModelPayGoTef.PnlMsgCliente := PnlMsgCliente;
  ModelPayGoTef.PnlMsgOperador := PnlMsgOperador;
  ModelPayGoTef.MmLog := MmLog;
  ModelPayGoTef.AtivarTef;

end;

procedure TViewFechamentoVenda.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;
  PnlBackFechamentoVenda.Color := TLibCores.BackAcessoProduto;

  PnlBackFechamentoVenda.Caption := '';
  PnlBackFechamentoVenda.BevelOuter := bvNone;

  ConfigurarBotao(BtnVoltar);
  ConfigurarBotao(BtnInserirFormaPagto);

  LblVlrTotalVenda.Font.Color := TLibCores.BackAcessoProduto;
  LblVlrAcrescimo.Font.Color := LblVlrTotalVenda.Font.Color;
  LblVlrSaldo.Font.Color := LblVlrTotalVenda.Font.Color;
  LblVlrTotalReceber.Font.Color := LblVlrTotalVenda.Font.Color;

  LblVlrTroco.Font.Color := TLibCores.Vermelho;
  LblVlrDesconto.Font.Color := LblVlrTroco.Font.Color;

  LblVlrRecebido.Font.Color := TLibCores.Verde;

end;

end.
