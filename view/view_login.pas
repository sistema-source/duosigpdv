unit view_login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, RxViewsPanel, view_pai;

type

  { TViewLogin }

  TViewLogin = class(TViewPai)
    EdtUsuario: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
  private

  public

  end;

var
  ViewLogin: TViewLogin;

implementation

{$R *.lfm}

end.

