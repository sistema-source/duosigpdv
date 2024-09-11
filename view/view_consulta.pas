unit view_consulta;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  lib_cores, util_teclas, model_configuracao_pdv, model_conexao_firebird,
  StdCtrls, Buttons, DBGrids, view_pai, lib_imagelist, DB, BCButtonFocus, BCButton;

type

  { TViewConsulta }

  TViewConsulta = class(TViewPai)
    BtnPesquisar: TBCButtonFocus;
    BtnVoltar: TBCButtonFocus;
    BtnOk: TBCButtonFocus;
    CmbBxTipoPesquisa: TComboBox;
    DtSrcConsulta: TDataSource;
    DBGrdPesquisa: TDBGrid;
    EdtPesquisarPor: TEdit;
    Label1: TLabel;
    LblMensagem: TLabel;
    LblFormaPesquisa: TLabel;
    PnlRodape: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PnlBackGround: TPanel;
    PnlTopoConsulta: TPanel;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);  virtual;
    procedure BtnVoltarClick(Sender: TObject);
    procedure CmbBxTipoPesquisaExit(Sender: TObject);
    procedure CmbBxTipoPesquisaSelect(Sender: TObject);
    procedure DBGrdPesquisaDblClick(Sender: TObject);
    procedure DBGrdPesquisaKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure EdtPesquisarPorKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    FKeyField: String;

    FKeyPesquisa: string;
    FModelConexaoFirebird: TModelConexaoFirebird;
    procedure ConfirmarProduto(var Key: word);
    procedure SetKeyField(AValue: String);
    procedure SetKeyPesquisa(AValue: string);
  public
    procedure ConfigurarComponentes; override;
    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird); override;

    procedure Pesquisar; virtual;

    property KeyPesquisa: string read FKeyPesquisa write SetKeyPesquisa;
    property KeyField : String read FKeyField write SetKeyField;
    property ModelConexaoFirebird: TModelConexaoFirebird
      read FModelConexaoFirebird write SetModelConexaoFirebird;

  end;


implementation

{$R *.lfm}

{ TViewConsulta }

procedure TViewConsulta.BtnVoltarClick(Sender: TObject);
begin
  FKeyPesquisa := '';
  Self.Tag := 0;
  Close;
end;

procedure TViewConsulta.CmbBxTipoPesquisaExit(Sender: TObject);
begin

  self.tag := 0;
end;

procedure TViewConsulta.CmbBxTipoPesquisaSelect(Sender: TObject);
begin
  self.tag := 0;
end;

procedure TViewConsulta.BtnOkClick(Sender: TObject);
begin

  Self.Tag := 1;
  FKeyPesquisa := DtSrcConsulta.DataSet.FieldByName(FKeyField).AsString;
  Close;
end;

procedure TViewConsulta.BtnPesquisarClick(Sender: TObject);
begin
  Self.Tag := 0;
  Pesquisar;
end;

procedure TViewConsulta.DBGrdPesquisaDblClick(Sender: TObject);
begin
  BtnOkClick(Sender);

end;

procedure TViewConsulta.DBGrdPesquisaKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    BtnOkClick(Sender);

  if Key = VK_F5 then
  begin
    EdtPesquisarPor.SetFocus;
  end;
end;

procedure TViewConsulta.EdtPesquisarPorKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    BtnPesquisarClick(Sender);
  end;
end;

procedure TViewConsulta.FormActivate(Sender: TObject);
begin
  Self.Tag := 0;
  FKeyPesquisa := '';
end;

procedure TViewConsulta.FormCreate(Sender: TObject);
begin
  inherited;

  if not Assigned(ModelConfiguracaoPdv) then
    ModelConfiguracaoPdv := TModelConfiguracaoPdv.Create(Self);

end;

procedure TViewConsulta.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = VK_ESC then
  begin
    FKeyPesquisa := '';
    Close;
  end;

end;


procedure TViewConsulta.ConfirmarProduto(var Key: word);
begin
end;

procedure TViewConsulta.SetKeyField(AValue: String);
begin
  if FKeyField=AValue then Exit;
  FKeyField:=AValue;
end;

procedure TViewConsulta.SetKeyPesquisa(AValue: string);
begin
  if FKeyPesquisa = AValue then Exit;
  FKeyPesquisa := AValue;
end;

procedure TViewConsulta.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird = AValue then Exit;
  FModelConexaoFirebird := AValue;

end;

procedure TViewConsulta.Pesquisar;
begin
  self.tag := 0;
end;

procedure TViewConsulta.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;
  ConfigurarBotao(BtnVoltar);
  ConfigurarBotao(BtnOk);
  ConfigurarBotao(BtnPesquisar);

  // PnlRodape
  PnlRodape.Caption := '';

  // LblMEnsagem
  LblMensagem.Font.Color := TLibCores.Info;
  LblMensagem.Caption := '';
  LblMensagem.Font.Size := 14;

end;

end.
