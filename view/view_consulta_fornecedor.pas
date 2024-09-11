unit view_consulta_fornecedor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, view_pai,
  view_consulta, model_fornecedor, model_configuracao_pdv, model_conexao_firebird;

type

  { TViewConsultaFornecedor }

  TViewConsultaFornecedor = class(TViewConsulta)
    procedure CmbBxTipoPesquisaSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FModelFornecedor: TModelDmFornecedor;
    procedure SetModelFornecedor(AValue: TModelDmFornecedor);

  public

    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird); override;
    procedure Pesquisar; override;

    property ModelFornecedor: TModelDmFornecedor
      read FModelFornecedor write SetModelFornecedor;


  end;

var
  ViewConsultaFornecedor: TViewConsultaFornecedor;

implementation

{$R *.lfm}

{ TViewConsultaFornecedor }

procedure TViewConsultaFornecedor.CmbBxTipoPesquisaSelect(Sender: TObject);
begin

  inherited;
  LblFormaPesquisa.Caption := '[F5] Pesquisar por ' + CmbBxTipoPesquisa.Text;
  EdtPesquisarPor.Clear;

end;

procedure TViewConsultaFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  CmbBxTipoPesquisa.ItemIndex := 0;
  CmbBxTipoPesquisaExit(Sender);

  FModelFornecedor := TModelDmFornecedor.Create(Self);

  if not Assigned(ModelConfiguracaoPdv) then
    ModelConfiguracaoPdv := TModelConfiguracaoPdv.Create(Self);

  DtSrcConsulta.DataSet := FModelFornecedor.QryConsulta;
end;

procedure TViewConsultaFornecedor.SetModelFornecedor(AValue: TModelDmFornecedor);
begin
  if FModelFornecedor = AValue then Exit;
  FModelFornecedor := AValue;
end;

procedure TViewConsultaFornecedor.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  inherited SetModelConexaoFirebird(AValue);
  FModelFornecedor.ModelConexaoFirebird := ModelConexaoFirebird;
end;

procedure TViewConsultaFornecedor.Pesquisar;
begin
  inherited Pesquisar;
  Screen.Cursor := crSQLWait;
  BtnPesquisar.Enabled := False;
  LblMensagem.Caption := 'Aguarde!!! Pesquisando ...';
  Application.ProcessMessages;
  try
    FModelFornecedor.ObterListaFornecedor(CmbBxTipoPesquisa.Text, EdtPesquisarPor.Text);
  finally
    Screen.Cursor := crDefault;
    BtnPesquisar.Enabled := True;
    LblMensagem.Caption := '';
    Application.ProcessMessages;
    DBGrdPesquisa.SetFocus;
  end;
end;

end.
