unit view_fechamento_venda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, Buttons, DBCtrls, rxcurredit, rxdbcurredit, view_pai,
  lib_cores, uJKDialog,
  lib_imagelist, ACBrEnterTab, DB,
  model_conexao_firebird,
  model_venda, util_teclas, BCButtonFocus;

type

  { TViewFechamentoVenda }

  TViewFechamentoVenda = class(TViewPai)
    ACBrEnterTab1: TACBrEnterTab;
    BCButtonFocus1: TBCButtonFocus;
    BtnInserirFormaPagto: TBCButtonFocus;
    BtnVoltar: TBCButtonFocus;
    CmbBxFormaPagto: TComboBox;
    DBCheckBox1: TDBCheckBox;
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
    PnlBackFechamentoVenda: TPanel;
    procedure BtnInserirFormaPagtoClick(Sender: TObject);
    procedure CmbBxFormaPagtoEnter(Sender: TObject);
    procedure CmbBxFormaPagtoExit(Sender: TObject);
    procedure CmbBxFormaPagtoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtVlrLancamentoKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SpdBtnVoltarClick(Sender: TObject);
  private
    FModelVenda: TModelDmVenda;
    FNomeBandeira: string;
    FNumAutorizacao: string;
    FPnlMensagem: TPanel;
    procedure SetModelVenda(AValue: TModelDmVenda);
    procedure SetNomeBandeira(AValue: string);
    procedure SetNumAutorizacao(AValue: string);
    procedure MostrarMensagemErro(Sender: TObject; E: Exception);
    procedure EncerrarVenda;
    procedure SetPnlMensagem(AValue: TPanel);
  protected
    procedure ConfigurarComponentes; override;
  public


    property ModelVenda: TModelDmVenda read FModelVenda write SetModelVenda;
    property NomeBandeira: string read FNomeBandeira write SetNomeBandeira;
    property NumAutorizacao: string read FNumAutorizacao write SetNumAutorizacao;

    property PnlMensagem : TPanel read FPnlMensagem write SetPnlMensagem;
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

    FModelVenda.InserirFormaPagto(CmbBxFormaPagto.Text, EdtVlrLancamento.Value,
      FNomeBandeira, FNumAutorizacao);

    CmbBxFormaPagto.SetFocus;
  end;
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
  LblMensagem.Caption:= '';
  Application.OnException := @MostrarMensagemErro;
end;

procedure TViewFechamentoVenda.CmbBxFormaPagtoExit(Sender: TObject);
begin
  EdtVlrLancamento.Clear;
end;

procedure TViewFechamentoVenda.CmbBxFormaPagtoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    EdtVlrLancamento.SetFocus;
end;

procedure TViewFechamentoVenda.BtnInserirFormaPagtoClick(Sender: TObject);
begin
  FModelVenda.InserirFormaPagto(CmbBxFormaPagto.Text, EdtVlrLancamento.Value,
    FNomeBandeira, FNumAutorizacao);
  CmbBxFormaPagto.SetFocus;
end;

procedure TViewFechamentoVenda.CmbBxFormaPagtoEnter(Sender: TObject);
begin
  If EdtVlrTotalRecebido.Value >= EdtVlrTotalReceber.Value then
  begin
    EncerrarVenda;
  end;
end;

procedure TViewFechamentoVenda.SetModelVenda(AValue: TModelDmVenda);
begin
  if FModelVenda = AValue then Exit;
  FModelVenda := AValue;
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
  LblMensagem.Caption:= 'ENCERRADNDO VENDA ...' ;
  Application.ProcessMessages;
  Sleep(4000);
  Close;
  FModelVenda.NovaVenda;
  PnlMensagem.Caption:= 'CAIXA LIVRE';
end;

procedure TViewFechamentoVenda.SetPnlMensagem(AValue: TPanel);
begin
  if FPnlMensagem=AValue then Exit;
  FPnlMensagem:=AValue;
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
