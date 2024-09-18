unit view_serie_nf;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  BCButtonFocus, view_pai, model_venda, model_configuracao_pdv, util_teclas;

type

  { TViewSerieNf }

  TViewSerieNf = class(TViewPai)
    BtnNFCe: TBCButtonFocus;
    BtnNFe: TBCButtonFocus;
    BtnCancelar: TBCButtonFocus;
    Panel4: TPanel;
    PnlBackGround: TPanel;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnNFCeClick(Sender: TObject);
    procedure BtnNFeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FModelVenda: TModelDmVenda;
    procedure SetModelVenda(AValue: TModelDmVenda);

  protected
    procedure ConfigurarComponentes; override;

  public

    property ModelVenda: TModelDmVenda read FModelVenda write SetModelVenda;


  end;

var
  ViewSerieNf: TViewSerieNf;

implementation

{$R *.lfm}

{ TViewSerieNf }

procedure TViewSerieNf.BtnNFCeClick(Sender: TObject);
begin
  Self.Tag := 1;
  FModelVenda.AtribuirCodSerieCabecalho(ModelConfiguracaoPdv.CodSerieNFCe);
  Close;
end;

procedure TViewSerieNf.BtnCancelarClick(Sender: TObject);
begin
  Self.Tag := 0;
  FModelVenda.AtribuirCodSerieCabecalho('$$');
  Close;
end;

procedure TViewSerieNf.BtnNFeClick(Sender: TObject);
begin
  Self.Tag := 2;
  FModelVenda.AtribuirCodSerieCabecalho(ModelConfiguracaoPdv.CodSerieNFe);
  Close;
end;

procedure TViewSerieNf.FormActivate(Sender: TObject);
begin
  Self.Tag := 0;
end;

procedure TViewSerieNf.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F2 then
     BtnNFeClick(sender)
  else If Key = VK_F3 then
     BtnNFCeClick(sender);
end;

procedure TViewSerieNf.SetModelVenda(AValue: TModelDmVenda);
begin
  if FModelVenda = AValue then Exit;
  FModelVenda := AValue;
end;

procedure TViewSerieNf.ConfigurarComponentes;
begin
  inherited ConfigurarComponentes;

  ConfigurarBotao(BtnCancelar);
  ConfigurarBotao(BtnNFCe);
  ConfigurarBotao(BtnNFe);
end;

end.
