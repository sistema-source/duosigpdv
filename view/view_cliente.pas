unit view_cliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,   lib_cores,
  StdCtrls, BCButtonFocus, view_pai, view_consulta_cliente, view_mensagem_carregar_dados,
  model_cliente;

type

  { TViewCliente }

  TViewCliente = class(TViewPai)
    BtnOk: TBCButtonFocus;
    BtnPesquisarCliente: TBCButtonFocus;
    BtnVoltar: TBCButtonFocus;
    EdCodMunicipio: TEdit;
    EdtBairro: TEdit;
    EdtCepCliente: TEdit;
    EdtCnpjCpf: TEdit;
    EdtCodCliente: TEdit;
    EdtEndereco: TEdit;
    EdtNomeCliente: TEdit;
    EdtNomeMunicipio: TEdit;
    EdtNumero: TEdit;
    EdtTelefone: TEdit;
    EdtTelefone1: TEdit;
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
    procedure FormCreate(Sender: TObject);
  private
    FModelCliente: TModelDmCliente;
    FViewConsultaCliente: TViewConsultaCliente;
    procedure SetModelCliente(AValue: TModelDmCliente);
    procedure SetViewConsultaCliente(AValue: TViewConsultaCliente);

  public



    procedure ConfigurarComponentes; override;


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

procedure TViewCliente.FormCreate(Sender: TObject);
begin
  inherited;
  FModelCliente := TModelDmCliente.Create(Self);
end;

procedure TViewCliente.SetModelCliente(AValue: TModelDmCliente);
begin
  if FModelCliente = AValue then Exit;
  FModelCliente := AValue;
end;

procedure TViewCliente.SetViewConsultaCliente(AValue: TViewConsultaCliente);
begin
  if FViewConsultaCliente = AValue then Exit;
  FViewConsultaCliente := AValue;
end;

procedure TViewCliente.BtnOkClick(Sender: TObject);
begin
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
        EdtCodCliente(Sender);
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
