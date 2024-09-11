unit view_mensagem_carregar_dados;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, view_pai;

type

  { TViewMensagemCarregarDados }

  TViewMensagemCarregarDados = class(TViewPai)
    LblMensagem: TLabel;
  private

  public

  end;

var
  ViewMensagemCarregarDados: TViewMensagemCarregarDados;

implementation

{$R *.lfm}

end.

