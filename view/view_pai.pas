unit view_pai;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, BCButtonFocus,
  View_blend, lib_cores, util_teclas, model_conexao_firebird,uJKDialog;

type

  { TViewPai }

  TViewPai = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    FModelConexaoFirebird: TModelConexaoFirebird;
    FViewBlend: TViewBlend;
  protected
    procedure ConfigurarComponentes; virtual;
    procedure ConfigurarBotao(pValue: TBCButtonFocus);

  public

    procedure  MostrarMensagemErro(Sender: TObject; E: Exception);
    procedure Blend(pValue: boolean);

    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird); virtual;

    property ModelConexaoFirebird: TModelConexaoFirebird
      read FModelConexaoFirebird write SetModelConexaoFirebird;

  end;

var
  ViewPai: TViewPai;

implementation

{$R *.lfm}

{ TViewPai }

procedure TViewPai.FormCreate(Sender: TObject);
begin
  Application.OnException := @MostrarMensagemErro;

  ConfigurarComponentes;

end;

procedure TViewPai.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = VK_ESC then
    Close;

end;

procedure TViewPai.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird = AValue then Exit;
  FModelConexaoFirebird := AValue;
end;

procedure TViewPai.ConfigurarComponentes;
begin

end;

procedure TViewPai.ConfigurarBotao(pValue: TBCButtonFocus);
begin
  pValue.StateClicked.Background.Gradient1.StartColor := TLibCores.BackAcessoProduto;

  pValue.StateClicked.Background.Gradient1.EndColor :=
    pValue.StateClicked.Background.Gradient1.StartColor;

  pValue.StateClicked.Background.Gradient1EndPercent := 100;

  pValue.StateHover.Background.Gradient1.StartColor :=
    pValue.StateClicked.Background.Gradient1.StartColor;

  pValue.StateHover.Background.Gradient1.EndColor :=
    pValue.StateClicked.Background.Gradient1.StartColor;
  pValue.StateHover.Background.Gradient1EndPercent := 100;

  pValue.StateNormal.Background.Gradient1.StartColor :=
    pValue.StateClicked.Background.Gradient1.StartColor;

  pValue.StateNormal.Background.Gradient1.EndColor :=
    pValue.StateClicked.Background.Gradient1.StartColor;

  pValue.StateNormal.Background.Gradient1EndPercent := 100;

end;

procedure TViewPai.MostrarMensagemErro(Sender: TObject; E: Exception);
begin
   Blend(True);
  JKDialog('Mensagem', e.Message, tdMensagem);
  Blend(False);

end;

procedure TViewPai.Blend(pValue: boolean);
begin

  if pValue then
  begin
    if not Assigned(FViewBlend) then
      FViewBlend := TViewBlend.Create(Self);

    FViewBlend.Left := 0;
    FViewBlend.Top := 0;
    FViewBlend.Height := Screen.Height;
    FViewBlend.Width := Screen.Width;
    FViewBlend.Show;

  end
  else
  begin
    FViewBlend.Hide;
  end;

end;

end.
