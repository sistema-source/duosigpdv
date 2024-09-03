unit view_pai;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type

  { TViewPai }

  TViewPai = class(TForm)
    procedure FormCreate(Sender: TObject);
  private

  protected
    procedure ConfigurarComponentes; virtual;
  public

  end;

var
  ViewPai: TViewPai;

implementation

{$R *.lfm}

{ TViewPai }

procedure TViewPai.FormCreate(Sender: TObject);
begin
  ConfigurarComponentes;
end;

end.
