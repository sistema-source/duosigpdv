unit view_consultar_orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, EditBtn, Buttons, view_pai,
  lib_imagelist,
  lib_cores, util_teclas, BCButtonFocus, DB,
  model_loja,
  model_orcamento,
  model_conexao_firebird, ACBrEnterTab,
  model_configuracao_pdv;

type

  { TViewConsultaOrcamento }

  TViewConsultaOrcamento = class(TViewPai)
    ACBrEnterTab1: TACBrEnterTab;
    BtnPesquisar: TBCButtonFocus;
    BtnOk: TBCButtonFocus;
    CmbBxLojas: TComboBox;
    DtSrcOrcamento: TDataSource;
    EdtNomeCliente: TEdit;
    EdtDtInicial: TDateEdit;
    EdtDtFinal: TDateEdit;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LblMensagem: TLabel;
    PnlRodapeOpcoes: TPanel;
    PnlBackGround: TPanel;
    PnlTopoConsulta: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    BtnVoltar: TBCButtonFocus;
    Timer1: TTimer;
    procedure BtnOkButtonClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure EdtDtInicialExit(Sender: TObject);
    procedure EdtNomeClienteEnter(Sender: TObject);
    procedure EdtNomeClienteExit(Sender: TObject);
    procedure EdtNomeClienteKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure SpdBtnPesquisa3Click(Sender: TObject);
    procedure BtnVoltarButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FModelOrcamento: TModelDmOrcamento;
  protected
    procedure ConfigurarComponentes; override;
    procedure CarregarDadosOrcamento;
  public

  end;

var
  ViewConsultaOrcamento: TViewConsultaOrcamento;

implementation



{$R *.lfm}

{ TViewConsultaOrcamento }

procedure TViewConsultaOrcamento.FormCreate(Sender: TObject);
begin
  inherited;
  FModelOrcamento := TModelDmOrcamento.Create(Self);
end;

procedure TViewConsultaOrcamento.BtnOkButtonClick(Sender: TObject);
begin
  Self.Tag := 1;
  Close;
end;

procedure TViewConsultaOrcamento.DBGrid1KeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    BtnOkButtonClick(Sender);
  end
  else if Key = VK_F5 then
  begin
    EdtNomeCliente.SetFocus;
  end;
end;

procedure TViewConsultaOrcamento.EdtDtInicialExit(Sender: TObject);
var
  s: string;
begin
  s := StringReplace(TDateEdit(Sender).Text, '/', '', [rfReplaceAll]);
  s := Copy(s, 1, 2) + '/' + copy(s, 3, 2) + '/' + Copy(s, 5, 4);
  try
    TDateEdit(Sender).Date := StrToDate(s);
  except
    on e: Exception do
    begin
      raise Exception.Create('Data inválida');
    end
  end;
end;

procedure TViewConsultaOrcamento.EdtNomeClienteEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TViewConsultaOrcamento.EdtNomeClienteExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := True;
end;

procedure TViewConsultaOrcamento.EdtNomeClienteKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    SpdBtnPesquisa3Click(Sender);
  end;
end;

procedure TViewConsultaOrcamento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FModelOrcamento);
end;

procedure TViewConsultaOrcamento.FormKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if Key = VK_ESC then
    Close;
end;

procedure TViewConsultaOrcamento.SpdBtnPesquisa3Click(Sender: TObject);
begin
  CarregarDadosOrcamento;
  if FModelOrcamento.QryPesquisaOrcamento.RecordCount > 0 then
    DBGrid1.SetFocus;
end;

procedure TViewConsultaOrcamento.BtnVoltarButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TViewConsultaOrcamento.Timer1Timer(Sender: TObject);
begin
{  timer1.Enabled := False;
  CarregarDadosOrcamento;}
end;


procedure TViewConsultaOrcamento.ConfigurarComponentes;
var
  Model: TModelDmLoja;
begin
  inherited ConfigurarComponentes;

  PnlRodapeOpcoes.Caption := '';

  ConfigurarBotao(BtnVoltar);
  ConfigurarBotao(BtnPesquisar);
  ConfigurarBotao(BtnOk);

  Model := TModelDmLoja.Create(nil);
  try
    Model.ObterListaCodigoLojas(CmbBxLojas.Items);
  finally
    Model.Free;
  end;
  EdtDtInicial.Date := date;
  EdtDtFinal.Date := date;

  CmbBxLojas.ItemIndex := CmbBxLojas.Items.IndexOf(ModelConfiguracaoPdv.CodLoja);

  if ModelConfiguracaoPdv.CodLoja <> '' then
  begin
    CmbBxLojas.ReadOnly := True;
    CmbBxLojas.Enabled := False;
  end;

  LblMensagem.Font.Color := TLibCores.Info;
  LblMensagem.Caption := '';

end;

procedure TViewConsultaOrcamento.CarregarDadosOrcamento;
begin

  try
    LblMensagem.Caption := 'Aguarde!!!  Carregando dados ';
    Application.ProcessMessages;
    FModelOrcamento.ObterListaOrcamento(DtSrcOrcamento, CmbBxLojas.Text,
      EdtDtInicial.Date, EdtDtFinal.Date, EdtNomeCliente.Text);
  finally
    LblMensagem.Caption := '';
  end;
end;

end.
