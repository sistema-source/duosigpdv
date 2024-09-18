unit view_cliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, lib_cores,
  StdCtrls, ACBrEnterTab, BCButtonFocus, view_pai, view_consulta_cliente, util_teclas,
  view_mensagem_carregar_dados,
  model_cliente, model_venda;

type

  { TViewCliente }

  TViewCliente = class(TViewPai)
    ACBrEnterTab1: TACBrEnterTab;
    BtnOk: TBCButtonFocus;
    BtnPesquisarCliente: TBCButtonFocus;
    BtnVoltar: TBCButtonFocus;
    EdtUf: TEdit;
    EdtCodMunicipio: TEdit;
    EdtBairro: TEdit;
    EdtCepCliente: TEdit;
    EdtCnpjCpf: TEdit;
    EdtCodCliente: TEdit;
    EdtEndereco: TEdit;
    EdtNomeCliente: TEdit;
    EdtNomeMunicipio: TEdit;
    EdtTelefone: TEdit;
    EdtEmail: TEdit;
    Label1: TLabel;
    LblVlrTotalVenda: TLabel;
    LblVlrTotalVenda1: TLabel;
    LblVlrTotalVenda2: TLabel;
    LblVlrTotalVenda3: TLabel;
    LblVlrTotalVenda4: TLabel;
    LblVlrTotalVenda5: TLabel;
    LblVlrTotalVenda6: TLabel;
    LblVlrTotalVenda7: TLabel;
    LblVlrTotalVenda8: TLabel;
    LblVlrTotalVenda9: TLabel;
    Panel1: TPanel;
    PnlRodape: TPanel;
    Panel4: TPanel;
    PnlBackGround: TPanel;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnPesquisarClienteClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure EdtCodClienteEnter(Sender: TObject);
    procedure EdtCodClienteExit(Sender: TObject);
    procedure EdtCodClienteKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FModelCliente: TModelDmCliente;
    FModelVenda: TModelDmVenda;
    FViewConsultaCliente: TViewConsultaCliente;
    procedure LimparCampos;
    procedure SetModelCliente(AValue: TModelDmCliente);
    procedure SetModelVenda(AValue: TModelDmVenda);
    procedure SetViewConsultaCliente(AValue: TViewConsultaCliente);
  public

    procedure ConfigurarComponentes; override;

    property ModelVenda: TModelDmVenda read FModelVenda write SetModelVenda;
    property ModelCliente: TModelDmCliente read FModelCliente write SetModelCliente;
    property ViewConsultaCliente: TViewConsultaCliente
      read FViewConsultaCliente write SetViewConsultaCliente;


  end;

var
  ViewCliente: TViewCliente;

implementation

{$R *.lfm}

{ TViewCliente }

procedure TViewCliente.BtnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TViewCliente.EdtCodClienteEnter(Sender: TObject);
begin
  EdtCodCliente.Clear;
  LimparCampos;
end;

procedure TViewCliente.EdtCodClienteExit(Sender: TObject);
var
  LCnpj, LRazaoSocial, LCep, LEndereco, LBairro, LCodMunicipio, LMunicipio,
  LUf, LTelefone, LEmail: string;
begin
  if EdtCodCliente.Text > '0' then
  begin
    if not FModelCliente.ObterDadosCliente(
      StrToIntDef(EdtCodCliente.Text, 0), LCnpj, LRazaoSocial, LCep,
      LEndereco, LBairro, LCodMunicipio, LMunicipio, LTelefone, LEmail, LUf) then
    begin
      EdtCodCliente.SetFocus;
      raise Exception.Create('Cliente [' + EdtCodCliente.Text +
        ' ] não esta cadastrado');
    end;

    EdtCnpjCpf.Text := LCnpj;
    EdtNomeCliente.Text := LRazaoSocial;
    EdtBairro.Text := LBairro;
    EdtCepCliente.Text := LCep;
    EdtEndereco.Text := LEndereco;
    EdtNomeMunicipio.Text := LMunicipio;
    EdtCodMunicipio.Text := LCodMunicipio;
    EdtTelefone.Text := LTelefone;
    EdtEmail.Text := LEmail;
    EdtUf.Text := LUf;
  end;

end;

procedure TViewCliente.EdtCodClienteKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_F7 then
    BtnPesquisarClienteClick(Sender);
end;

procedure TViewCliente.FormShow(Sender: TObject);
begin
  FModelCliente := TModelDmCliente.Create(Self);
  FModelCliente.ModelConexaoFirebird := ModelConexaoFirebird;
end;

procedure TViewCliente.LimparCampos;
begin
  EdtNomeCliente.Clear;
  EdtCnpjCpf.Clear;
  EdtCepCliente.Clear;
  EdtEndereco.Clear;
  EdtBairro.Clear;
  EdtCodMunicipio.Clear;
  EdtNomeMunicipio.Clear;
  EdtUf.Clear;
  EdtTelefone.Clear;
  EdtEmail.Clear;
end;

procedure TViewCliente.SetModelCliente(AValue: TModelDmCliente);
begin
  if FModelCliente = AValue then Exit;
  FModelCliente := AValue;
end;

procedure TViewCliente.SetModelVenda(AValue: TModelDmVenda);
begin
  if FModelVenda = AValue then Exit;
  FModelVenda := AValue;
end;

procedure TViewCliente.SetViewConsultaCliente(AValue: TViewConsultaCliente);
begin
  if FViewConsultaCliente = AValue then Exit;
  FViewConsultaCliente := AValue;
end;

procedure TViewCliente.BtnOkClick(Sender: TObject);
begin
  if EdtCodCliente.Text > '0' then
  begin
    ModelVenda.CodCliente := StrToIntDef(EdtCodCliente.Text, 0);
    ModelVenda.CnpjCpfCliente := EdtCnpjCpf.Text;
  end
  else
  begin
    raise Exception.Create('Cliente tem que estar cadastrado');
  end;
  Close;
end;

procedure TViewCliente.BtnPesquisarClienteClick(Sender: TObject);
var
  v: TViewMensagemCarregarDados;
begin
  try
    Screen.Cursor := crSQLWait;
    Blend(True);

    if not Assigned(FViewConsultaCliente) then
    begin
      try
        v := TViewMensagemCarregarDados.Create(Self);
        v.LblMensagem.Font.Color := TLibCores.Info;
        v.LblMensagem.Caption := 'AGUARDE!!!!  Carregando ...';
        v.Color := TLibCores.Gelo;
        v.Show;
        Application.ProcessMessages;
        FViewConsultaCliente := TViewConsultaCliente.Create(Self);
        FViewConsultaCliente.ModelConexaoFirebird := ModelConexaoFirebird;
        FViewConsultaCliente.BorderStyle := bsNone;
        FViewConsultaCliente.KeyField := 'CODCLI';
      finally
        FreeAndNil(v);
      end;
    end;
    Screen.Cursor := crDefault;
    FViewConsultaCliente.ShowModal;

    // Selecionou um Fornecedor
    if FViewConsultaCliente.Tag = 1 then
    begin
      if FViewConsultaCliente.DtSrcConsulta.DataSet.RecordCount > 0 then
      begin
        EdtCodCliente.Text := FViewConsultaCliente.KeyPesquisa;
        EdtCodClienteExit(Sender);
      end
      else
      begin
        EdtCodCliente.SetFocus;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    Blend(False);
  end;
end;

procedure TViewCliente.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;
  ConfigurarBotao(BtnVoltar);
  ConfigurarBotao(BtnOk);
  ConfigurarBotao(BtnPesquisarCliente);
end;

end.
