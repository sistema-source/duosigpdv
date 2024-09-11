unit view_base_exemplo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, BCButtonFocus, view_pai;

type

  { TViewSerieNf }

  TViewSerieNf = class(TViewPai)
    BtnNFCe: TBCButtonFocus;
    BtnNFe: TBCButtonFocus;
    BtnCancelar: TBCButtonFocus;
    Panel4: TPanel;
    PnlBackGround: TPanel;
  private

  public

  end;

var
  ViewSerieNf: TViewSerieNf;

implementation

{$R *.lfm}

end.

