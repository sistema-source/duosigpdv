unit view_consulta_cliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  model_cliente,  model_conexao_firebird,
  StdCtrls, DBGrids, BCButtonFocus, view_pai, view_consulta;

type

  { TViewConsultaCliente }

  TViewConsultaCliente = class(TViewConsulta)
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FModelCliente: TModelDmCliente;
    procedure SetModelCliente(AValue: TModelDmCliente);

  public

    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird); override;
    procedure Pesquisar; override;
    property ModelCliente: TModelDmCliente read FModelCliente write SetModelCliente;

  end;

var
  ViewConsultaCliente: TViewConsultaCliente;

implementation

{$R *.lfm}

{ TViewConsultaCliente }

procedure TViewConsultaCliente.BtnOkClick(Sender: TObject);
begin
  If Not DtSrcConsulta.DataSet.Active then
    raise Exception.Create('Não existe um cliente selecionado');

  If Not DtSrcConsulta.DataSet.RecordCount <= 0 then
    raise Exception.Create('Não existe um cliente selecionado');

  inherited;
end;

procedure TViewConsultaCliente.FormCreate(Sender: TObject);
begin
  inherited;
  FModelCliente := TModelDmCliente.Create(self);
  DtSrcConsulta.DataSet := FModelCliente.QryConsulta;
end;

procedure TViewConsultaCliente.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FModelCliente);
end;

procedure TViewConsultaCliente.FormShow(Sender: TObject);
begin
    MostrarLabelPesquisa;
end;

procedure TViewConsultaCliente.SetModelCliente(AValue: TModelDmCliente);
begin
  if FModelCliente = AValue then Exit;
  FModelCliente := AValue;
end;

procedure TViewConsultaCliente.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  inherited SetModelConexaoFirebird(AValue);
  FModelCliente.ModelConexaoFirebird := ModelConexaoFirebird;
end;

procedure TViewConsultaCliente.Pesquisar;
begin
  inherited Pesquisar;
  Screen.Cursor := crSQLWait;
  BtnPesquisar.Enabled := False;
  LblMensagem.Caption := 'Aguarde!!! Pesquisando ...';
  Application.ProcessMessages;
  try
    FModelCliente.ObterListaCliente(CmbBxTipoPesquisa.Text,
      EdtPesquisarPor.Text);
  finally
    Screen.Cursor := crDefault;
    BtnPesquisar.Enabled := True;
    LblMensagem.Caption := '';
    Application.ProcessMessages;
    DBGrdPesquisa.SetFocus;
  end;
end;

end.
