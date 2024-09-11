unit model_cliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model_conexao_firebird;

type

  { TModelDmCliente }

  TModelDmCliente = class(TDataModule)
  private
    FModelConexaoFirebird: TModelConexaoFirebird;
    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird);

  public
  property ModelConexaoFirebird : TModelConexaoFirebird read FModelConexaoFirebird write SetModelConexaoFirebird;

  end;

var
  ModelDmCliente: TModelDmCliente;

implementation

{$R *.lfm}

{ TModelDmCliente }

procedure TModelDmCliente.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird=AValue then Exit;
  FModelConexaoFirebird:=AValue;
end;

end.

