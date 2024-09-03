unit view_fechamento_venda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, DBGrids, Buttons, rxcurredit, rxdbcurredit, view_pai,
  lib_cores,
  lib_imagelist;

type

  { TViewFechamentoVenda }

  TViewFechamentoVenda = class(TViewPai)
    ComboBox1: TComboBox;
    EdtVlrLancamento: TCurrencyEdit;
    DBGrid1: TDBGrid;
    CmbBxFormaPagto: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    LblVlrTotalVenda: TLabel;
    LblVlrAcrescimo: TLabel;
    LblVlrDesconto: TLabel;
    LblVlrTotalReceber: TLabel;
    LblVlrRecebido: TLabel;
    LblVlrSaldo: TLabel;
    LblVlrTroco: TLabel;
    Panel1: TPanel;
    EdtVlrTotalVenda: TRxDBCurrEdit;
    EdtVlrAcrescimos: TRxDBCurrEdit;
    EdtVlrDescontos: TRxDBCurrEdit;
    EdtVlrTotalReceber: TRxDBCurrEdit;
    EdtVlrTotalRecebido: TRxDBCurrEdit;
    EdtVlrSaldo: TRxDBCurrEdit;
    EdtVlrTroco: TRxDBCurrEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    PnlBackFechamentoVenda: TPanel;
    ShpBotaoInserirFormaPagto: TShape;
    ShpBotaoInserirFormaPagto1: TShape;
    SpedBtnInserirFormaPagto: TSpeedButton;
    SpdBtnVoltar: TSpeedButton;
    procedure SpdBtnVoltarClick(Sender: TObject);
  private
  protected
    procedure ConfigurarComponentes; override;
  public

  end;

var
  ViewFechamentoVenda: TViewFechamentoVenda;

implementation

{$R *.lfm}

{ TViewFechamentoVenda }

procedure TViewFechamentoVenda.SpdBtnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TViewFechamentoVenda.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;
  PnlBackFechamentoVenda.Color := TLibCores.BackAcessoProduto; ;
  PnlBackFechamentoVenda.Caption := '';
  PnlBackFechamentoVenda.BevelOuter := bvNone;

  ShpBotaoInserirFormaPagto.Brush.Color:= TLibCores.BackAcessoProduto;


    LblVlrAcrescimo.Font.Color := LblVlrTotalVenda.Font.Color;
    LblVlrDesconto.Font.Color := LblVlrTroco.Font.Color;
    LblVlrRecebido.Font.Color := TLibCores.Verde;
    LblVlrSaldo.Font.Color := LblVlrTotalVenda.Font.Color;
    LblVlrTotalReceber.Font.Color := LblVlrTotalVenda.Font.Color;
    LblVlrTotalVenda.Font.Color := TLibCores.BackAcessoProduto;
    LblVlrTroco.Font.Color := TLibCores.Vermelho;

    SpdBtnVoltar.Font.Color := TLibCores.Gelo;





end;

end.
