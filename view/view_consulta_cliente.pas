unit view_consulta_cliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, BCButtonFocus, view_pai, view_consulta;

type

  { TViewConsultaCliente }

  TViewConsultaCliente = class(TViewConsulta)
  private

  public

  end;

var
  ViewConsultaCliente: TViewConsultaCliente;

implementation

{$R *.lfm}

{ TViewConsultaCliente }

end.
