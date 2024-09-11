unit view_cnpj_cpf;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, uJKDialog,
  model_venda,
  StdCtrls, ACBrValidador, BCButtonFocus, view_pai, util_teclas, lib_funcoes;

type

  { TViewCnpjCpf }

  TViewCnpjCpf = class(TViewPai)
    ACBrValidador1: TACBrValidador;
    BtnOk: TBCButtonFocus;
    BtnVoltar: TBCButtonFocus;
    EdtCnpjCpf: TEdit;
    Label1: TLabel;
    LblMensagem: TLabel;
    Panel1: TPanel;
    Panel4: TPanel;
    PnlBackGround: TPanel;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure EdtCnpjCpfExit(Sender: TObject);
    procedure EdtCnpjCpfKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FModelVenda: TModelDmVenda;
    procedure MostrarMensagemErro(Sender: TObject; E: Exception);
    procedure SetModelVenda(AValue: TModelDmVenda);
    function ValidarCnpjCpf: boolean;


  public
    procedure ConfigurarComponentes; override;
    property ModelVenda: TModelDmVenda read FModelVenda write SetModelVenda;

  end;

var
  ViewCnpjCpf: TViewCnpjCpf;

implementation

{$R *.lfm}

{ TViewCnpjCpf }

procedure TViewCnpjCpf.BtnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TViewCnpjCpf.EdtCnpjCpfExit(Sender: TObject);
begin
  ValidarCnpjCpf;
end;

procedure TViewCnpjCpf.EdtCnpjCpfKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  CnpjCpf: string;
begin
  if Key = VK_RETURN then
  begin
    if ValidarCnpjCpf then
    begin
      if JKDialog('Confirmação', 'Confirma o CNPJ/CPF digitado ?', tdConfirmacao) then
      begin
        ModelVenda.CnpjCpfCliente:= EdtCnpjCpf.Text;
        Close;
      end;
    end;
  end;
end;

procedure TViewCnpjCpf.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = VK_ESC then
    Close;
end;

procedure TViewCnpjCpf.FormShow(Sender: TObject);
begin
  Application.OnException := @MostrarMensagemErro;
end;

procedure TViewCnpjCpf.MostrarMensagemErro(Sender: TObject; E: Exception);
begin
  Blend(True);
  JKDialog('Mensagem', e.Message, tdMensagem);
  Blend(False);

end;

procedure TViewCnpjCpf.SetModelVenda(AValue: TModelDmVenda);
begin
  if FModelVenda=AValue then Exit;
  FModelVenda:=AValue;
end;

function TViewCnpjCpf.ValidarCnpjCpf: boolean;
var
  CnpjCpf: string;
begin
  Result := False;
  CnpjCpf := TLibFuncoes.FormatarCnpjCpf(EdtCnpjCpf.Text);
  EdtCnpjCpf.Text := CnpjCpf;
  ACBrValidador1.Documento := CnpjCpf;
  if CnpjCpf.Length = 14 then
    ACBrValidador1.TipoDocto := docCPF
  else
    ACBrValidador1.TipoDocto := docCNPJ;

  if not ACBrValidador1.Validar then
  begin
    LblMensagem.Caption := 'CNPJ/CPF digitado errado';
    LblMensagem.Font.Color := clRed;
  end
  else
  begin
    LblMensagem.Caption := 'CNPJ/CPF correto ';
    LblMensagem.Font.Color := clGreen;
    Result := True;
  end;
end;

procedure TViewCnpjCpf.BtnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TViewCnpjCpf.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;
  ConfigurarBotao(BtnVoltar);
end;

end.
