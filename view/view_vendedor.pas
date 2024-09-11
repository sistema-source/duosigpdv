unit view_vendedor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, util_teclas,
  StdCtrls, BCButtonFocus, view_pai, model_vendedor, model_configuracao_pdv, model_venda,
  lib_funcoes;

type

  { TViewVendedor }

  TViewVendedor = class(TViewPai)
    BtnOk: TBCButtonFocus;
    BtnVoltar: TBCButtonFocus;
    CmbBxVendedor: TComboBox;
    Label1: TLabel;
    Panel1: TPanel;
    Panel4: TPanel;
    PnlBackGround: TPanel;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure CmbBxVendedorKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    FModelVenda: TModelDmVenda;
    FModelVendedor: TModelDmVendedor;
    procedure SetModelVenda(AValue: TModelDmVenda);
  public
    procedure ConfigurarComponentes; override;
    procedure CarregarComboBox;
    procedure ConfigurarDadosPadrao;

    property ModelVenda: TModelDmVenda read FModelVenda write SetModelVenda;

  end;

var
  ViewVendedor: TViewVendedor;

implementation

{$R *.lfm}

{ TViewVendedor }

procedure TViewVendedor.BtnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TViewVendedor.CmbBxVendedorKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    FModelVenda.CodVendedor := FModelVendedor.HashTable.Values[CmbBxVendedor.Text];
    Close;
  end;
end;

procedure TViewVendedor.FormCreate(Sender: TObject);
begin
  inherited;
  FModelVendedor := TModelDmVendedor.Create(self);
end;

procedure TViewVendedor.SetModelVenda(AValue: TModelDmVenda);
begin
  if FModelVenda = AValue then Exit;
  FModelVenda := AValue;
end;

procedure TViewVendedor.ConfigurarComponentes;
begin
  ConfigurarBotao(BtnVoltar);
  ConfigurarBotao(BtnOk);
  inherited ConfigurarComponentes;
end;

procedure TViewVendedor.CarregarComboBox;
begin
  FModelVendedor.ModelConexaoFirebird := ModelConexaoFirebird;

  CmbBxVendedor.Items.Clear;
  FModelVendedor.ObterListaCodigoVendedors(CmbBxVendedor.Items);

end;

procedure TViewVendedor.ConfigurarDadosPadrao;
Var
  i : Integer;
begin
    // Pegar o Vendedor Default
  i := TLibFuncoes.FindIndexByValue(FModelVendedor.HashTable,
    ModelConfiguracaoPdv.CodVendedor);
  CmbBxVendedor.ItemIndex := i;

end;

procedure TViewVendedor.BtnOkClick(Sender: TObject);
begin
  Close;
end;

end.
