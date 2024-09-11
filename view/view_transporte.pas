unit view_transporte;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, model_fornecedor,
  StdCtrls, BCButtonFocus, rxcurredit, view_pai, model_venda, lib_cores, ACBrEnterTab,
  view_mensagem_carregar_dados, view_consulta_fornecedor, model_configuracao_pdv;

type

  { TViewTransporte }

  TViewTransporte = class(TViewPai)
    ACBrEnterTab1: TACBrEnterTab;
    BtnOk: TBCButtonFocus;
    BtnPesquisarFornecedor: TBCButtonFocus;
    BtnVoltar: TBCButtonFocus;
    CmbBxTipoFrete: TComboBox;
    CmbBxTipoEntrega: TComboBox;
    CmbBxUfdPlaca: TComboBox;
    EdtPesoLiquido: TCurrencyEdit;
    EdtMarca: TEdit;
    EdtPesoBruto: TCurrencyEdit;
    EdtPlacaVeiculo: TEdit;
    EdtNomeMotorista: TEdit;
    EdtCnpjCpf: TEdit;
    EdtCodTransportadora: TEdit;
    EdtNomeTransportadora: TEdit;
    EdtNumero: TEdit;
    EdtEspecieVolume: TEdit;
    EdtQtdade: TEdit;
    Label1: TLabel;
    LblVlrTotalVenda: TLabel;
    LblVlrTotalVenda1: TLabel;
    LblVlrTotalVenda10: TLabel;
    LblVlrTotalVenda11: TLabel;
    LblVlrTotalVenda12: TLabel;
    LblVlrTotalVenda13: TLabel;
    LblVlrTotalVenda14: TLabel;
    LblVlrTotalVenda15: TLabel;
    LblVlrTotalVenda2: TLabel;
    LblVlrTotalVenda5: TLabel;
    LblVlrTotalVenda6: TLabel;
    LblVlrTotalVenda7: TLabel;
    LblVlrTotalVenda8: TLabel;
    LblVlrTotalVenda9: TLabel;
    Panel1: TPanel;
    Panel4: TPanel;
    PnlBackGround: TPanel;
    PnlRodape: TPanel;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnPesquisarFornecedorClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure EdtCodTransportadoraExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FModelFornecedor: TModelDmFornecedor;
    FModelVenda: TModelDmVenda;
    FViewConsultaForncedor: TViewConsultaFornecedor;
    procedure ConfigurarDadosPadraoTipoFrete;
    procedure ConfigurarDadosPadraoTipoEntrega;

    procedure SetModelFornecedor(AValue: TModelDmFornecedor);
    procedure SetModelVenda(AValue: TModelDmVenda);
    procedure SetViewConsultaForncedor(AValue: TViewConsultaFornecedor);

  public

    procedure ConfigurarDadosPadrao;
    procedure ConfigurarComponentes; override;

    property ModelFornecedor: TModelDmFornecedor
      read FModelFornecedor write SetModelFornecedor;

    property ModelVenda: TModelDmVenda read FModelVenda write SetModelVenda;

    property ViewConsultaForncedor: TViewConsultaFornecedor
      read FViewConsultaForncedor write SetViewConsultaForncedor;

  end;

var
  ViewTransporte: TViewTransporte;

implementation

{$R *.lfm}

{ TViewTransporte }

procedure TViewTransporte.BtnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TViewTransporte.EdtCodTransportadoraExit(Sender: TObject);
var
  LCnpj, LRazaoSocial: string;
begin
  if EdtCodTransportadora.Text > '0' then
  begin

    if not FModelFornecedor.ObterCpjRazaoSocialFornecedor(
      StrToIntDef(EdtCodTransportadora.Text, 0), LCnpj, LRazaoSocial) then
      raise Exception.Create('Fornecedor [' + EdtCodTransportadora.Text +
        ' ] não esta cadastrado');

    EdtCnpjCpf.Text := LCnpj;
    EdtNomeTransportadora.Text := LRazaoSocial;
  end;
end;

procedure TViewTransporte.FormShow(Sender: TObject);
begin
  FModelFornecedor := TModelDmFornecedor.Create(Self);
  FModelFornecedor.ModelConexaoFirebird := ModelConexaoFirebird;
end;

procedure TViewTransporte.SetModelVenda(AValue: TModelDmVenda);
begin
  if FModelVenda = AValue then Exit;
  FModelVenda := AValue;
end;

procedure TViewTransporte.SetModelFornecedor(AValue: TModelDmFornecedor);
begin
  if FModelFornecedor = AValue then Exit;
  FModelFornecedor := AValue;
end;

procedure TViewTransporte.ConfigurarDadosPadraoTipoFrete;
begin
  // Configuracao do Tipo do Frete
  if ModelConfiguracaoPdv.TipoFrete = '0' then
    CmbBxTipoFrete.ItemIndex := 0
  else if ModelConfiguracaoPdv.TipoFrete = '1' then
    CmbBxTipoFrete.ItemIndex := 1
  else if ModelConfiguracaoPdv.TipoFrete = '2' then
    CmbBxTipoFrete.ItemIndex := 2
  else if ModelConfiguracaoPdv.TipoFrete = '3' then
    CmbBxTipoFrete.ItemIndex := 3
  else if ModelConfiguracaoPdv.TipoFrete = '4' then
    CmbBxTipoFrete.ItemIndex := 4
  else if ModelConfiguracaoPdv.TipoFrete = '9' then
    CmbBxTipoFrete.ItemIndex := 5
  else if ModelConfiguracaoPdv.TipoFrete = 'C' then
    CmbBxTipoFrete.ItemIndex := 0
  else if ModelConfiguracaoPdv.TipoFrete = 'F' then
    CmbBxTipoFrete.ItemIndex := 1;
end;

procedure TViewTransporte.ConfigurarDadosPadraoTipoEntrega;
begin
  if ModelConfiguracaoPdv.TipoEntrega = 'B' then
    CmbBxTipoEntrega.ItemIndex := 0
  else if ModelConfiguracaoPdv.TipoEntrega = 'T' then
    CmbBxTipoEntrega.ItemIndex := 1
  else if ModelConfiguracaoPdv.TipoEntrega = 'D' then
    CmbBxTipoEntrega.ItemIndex := 2;
end;

procedure TViewTransporte.SetViewConsultaForncedor(AValue: TViewConsultaFornecedor);
begin
  if FViewConsultaForncedor = AValue then Exit;
  FViewConsultaForncedor := AValue;
end;

procedure TViewTransporte.ConfigurarDadosPadrao;
begin
  ConfigurarDadosPadraoTipoFrete;
  ConfigurarDadosPadraoTipoEntrega;
  EdtMarca.Text := ModelConfiguracaoPdv.MarcaVolume;
  EdtEspecieVolume.Text := ModelConfiguracaoPdv.EspecieVolume;
end;

procedure TViewTransporte.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;
  ConfigurarBotao(BtnOk);
  ConfigurarBotao(BtnVoltar);
  ConfigurarBotao(BtnPesquisarFornecedor);
end;


procedure TViewTransporte.BtnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TViewTransporte.BtnPesquisarFornecedorClick(Sender: TObject);
var
  v: TViewMensagemCarregarDados;
begin
  try
    Screen.Cursor := crSQLWait;
    Blend(True);

    if not Assigned(FViewConsultaForncedor) then
    begin
      try
        v := TViewMensagemCarregarDados.Create(Self);
        v.LblMensagem.Font.Color := TLibCores.Info;
        v.LblMensagem.Caption := 'AGUARDE!!!!  Carregando ...';
        v.Color := TLibCores.Gelo;
        v.Show;
        Application.ProcessMessages;
        FViewConsultaForncedor := TViewConsultaFornecedor.Create(Self);
        FViewConsultaForncedor.ModelConexaoFirebird := ModelConexaoFirebird;
        FViewConsultaForncedor.BorderStyle := bsNone;
        FViewConsultaForncedor.KeyField := 'CODFRN';
      finally
        FreeAndNil(v);
      end;
    end;
    Screen.Cursor := crDefault;
    FViewConsultaForncedor.ShowModal;

    // Selecionou um Fornecedor
    if FViewConsultaForncedor.Tag = 1 then
    begin
      if FViewConsultaForncedor.DtSrcConsulta.DataSet.RecordCount > 0 then
      begin
        EdtCodTransportadora.Text := FViewConsultaForncedor.KeyPesquisa;
        EdtCodTransportadoraExit(Sender);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    Blend(False);
  end;

end;

end.
