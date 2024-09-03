unit view_consultar_orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids, StdCtrls, EditBtn, Buttons, view_pai,
  lib_imagelist,
  lib_cores
  ;

type

  { TViewConsultaOrcamento }

  TViewConsultaOrcamento = class(TViewPai)
    ComboBox1: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    PnlTopoConsulta: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ShpBtnPesquisar: TShape;
    SpdBtnPesquisar: TSpeedButton;
  private
  protected
           procedure ConfigurarComponentes; override;

  public

  end;

var
  ViewConsultaOrcamento: TViewConsultaOrcamento;

implementation



{$R *.lfm}

{ TViewConsultaOrcamento }

procedure TViewConsultaOrcamento.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;
  ShpBtnPesquisar.Brush.Color:= TLibCores.BackAcessoProduto;

end;

end.

