unit view_consultar_orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids, StdCtrls, EditBtn, Buttons, view_pai,
  lib_imagelist,
  lib_cores, DB,
  model_loja,
  model_orcamento;

type

  { TViewConsultaOrcamento }

  TViewConsultaOrcamento = class(TViewPai)
    CmbBxLojas: TComboBox;
    DtSrcOrcamento: TDataSource;
    EdtDtInicial: TDateEdit;
    EdtDtFinal: TDateEdit;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    PnlTopoConsulta: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ShpBtnPesquisar: TShape;
    SpdBtnPesquisar: TSpeedButton;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpdBtnPesquisarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ModelOrcamento: TModelDmOrcamento;
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
  ModelOrcamento := TModelDmOrcamento.Create(nil);
end;

procedure TViewConsultaOrcamento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ModelOrcamento);
end;

procedure TViewConsultaOrcamento.SpdBtnPesquisarClick(Sender: TObject);
begin
  CarregarDadosOrcamento;
end;

procedure TViewConsultaOrcamento.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled := False;
  CarregarDadosOrcamento;
end;

procedure TViewConsultaOrcamento.ConfigurarComponentes;
var
  Model: TModelDmLoja;
begin
  inherited ConfigurarComponentes;
  ShpBtnPesquisar.Brush.Color := TLibCores.BackAcessoProduto;
  Model := TModelDmLoja.Create(nil);
  try
    Model.ObterListaCodigoLojas(CmbBxLojas.Items);
  finally
    Model.Free;
  end;
  EdtDtInicial.Date := date;
  EdtDtFinal.Date := date;
end;

procedure TViewConsultaOrcamento.CarregarDadosOrcamento;
begin
  ModelOrcamento.ObterListaOrcamento(DtSrcOrcamento, CmbBxLojas.Text, EdtDtInicial.Date, EdtDtFinal.Date);
end;

end.
