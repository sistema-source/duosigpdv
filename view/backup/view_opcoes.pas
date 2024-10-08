unit view_opcoes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  model_conexao_firebird, model_venda, util_teclas,
  BCButtonFocus, view_pai, view_vendedor, view_cnpj_cpf, view_transporte, view_cliente;

type

  { TViewOpcoes }

  TViewOpcoes = class(TViewPai)
    BtnCancelarVenda: TBCButtonFocus;
    BtnDadosTransporte: TBCButtonFocus;
    BtnDadosCliente: TBCButtonFocus;
    BtnVoltar: TBCButtonFocus;
    BtnVendedor: TBCButtonFocus;
    BtnCnpjCpf: TBCButtonFocus;
    Panel4: TPanel;
    PnlBackGround: TPanel;
    procedure BtnCancelarVendaButtonClick(Sender: TObject);
    procedure BtnCnpjCpfClick(Sender: TObject);
    procedure BtnDadosClienteClick(Sender: TObject);
    procedure BtnDadosTransporteClick(Sender: TObject);
    procedure BtnVendedorClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    FPnlMensagem: TPanel;
    FModelVenda: TModelDmVenda;
    procedure SeTModelDmVenda(AValue: TModelDmVenda);
    procedure SetPnlMensagem(AValue: TPanel);
  public
    procedure ConfigurarComponentes; override;
    property ModelVenda: TModelDmVenda read FModelVenda write SeTModelDmVenda;
    property PnlMensagem : TPanel read FPnlMensagem write SetPnlMensagem;


  end;

implementation

{$R *.lfm}

{ TViewOpcoes }

procedure TViewOpcoes.BtnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TViewOpcoes.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  if key = VK_F2 then
    BtnVendedorClick(Sender)
  else if key = VK_F3 then
    BtnCnpjCpfClick(Sender)
  else if key = VK_F4 then
    BtnDadosTransporteClick(Sender)
  else if key = VK_F5 then
    BtnDadosClienteClick(Sender)
  else if key = VK_F6 then
    BtnCancelarVendaButtonClick(Sender);

end;

procedure TViewOpcoes.SeTModelDmVenda(AValue: TModelDmVenda);
begin
  if FModelVenda = AValue then Exit;
  FModelVenda := AValue;
end;

procedure TViewOpcoes.SetPnlMensagem(AValue: TPanel);
begin
  if FPnlMensagem=AValue then Exit;
  FPnlMensagem:=AValue;
end;


procedure TViewOpcoes.BtnVendedorClick(Sender: TObject);
begin
  if not Assigned(ViewVendedor) then
  begin
    ViewVendedor := TViewVendedor.Create(Application);
    ViewVendedor.BorderStyle := bsNone;
    ViewVendedor.ModelConexaoFirebird := ModelConexaoFirebird;
    ViewVendedor.ModelVenda := ModelVenda;
    ViewVendedor.CarregarComboBox;
    ViewVendedor.ConfigurarDadosPadrao;
  end;
  Blend(True);
  ViewVendedor.ShowModal;
  Blend(False);
end;

procedure TViewOpcoes.BtnCnpjCpfClick(Sender: TObject);
begin
  if not Assigned(ViewCnpjCpf) then
  begin
    ViewCnpjCpf := TViewCnpjCpf.Create(Application);
    ViewCnpjCpf.BorderStyle := bsNone;
    ViewCnpjCpf.ModelVenda := ModelVenda;
  end;
  Blend(True);
  ViewCnpjCpf.ShowModal;
  Blend(False);
end;

procedure TViewOpcoes.BtnCancelarVendaButtonClick(Sender: TObject);
begin
  ModelVenda.CancelarVenda(ModelVenda.Id);
  FPnlMensagem.Caption:= 'CAIXA LIVRE';
  Close;
end;

procedure TViewOpcoes.BtnDadosClienteClick(Sender: TObject);
begin
  if not Assigned(ViewCliente) then
  begin
    ViewCliente := TViewCliente.Create(Application);
    ViewCliente.BorderStyle := bsNone;
    ViewCliente.ModelConexaoFirebird := ModelConexaoFirebird;
    viewCliente.ModelVenda := FModelVenda;
  end;
  Blend(True);
  ViewCliente.ShowModal;
  Blend(False);
end;

procedure TViewOpcoes.BtnDadosTransporteClick(Sender: TObject);
begin
  if not Assigned(ViewTransporte) then
  begin
    ViewTransporte := TViewTransporte.Create(Application);
    ViewTransporte.BorderStyle := bsNone;
    ViewTransporte.ModelConexaoFirebird := ModelConexaoFirebird;
    ViewTransporte.ModelVenda := ModelVenda;
    ViewTransporte.ConfigurarDadosPadrao;
  end;
  Blend(True);
  ViewTransporte.ShowModal;
  Blend(False);

end;

procedure TViewOpcoes.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;
  ConfigurarBotao(BtnCnpjCpf);
  ConfigurarBotao(BtnVoltar);
  ConfigurarBotao(BtnVendedor);
  ConfigurarBotao(BtnDadosCliente);
  ConfigurarBotao(BtnDadosTransporte);
  ConfigurarBotao(BtnCancelarVenda);
  ConfigurarBotao(BtnVoltar);
end;

end.
