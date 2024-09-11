unit model_cliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model_conexao_firebird;

type
  TModelDmCliente = class(TDataModule)
  private

  public

  end;

var
  ModelDmCliente: TModelDmCliente;

implementation

{$R *.lfm}

end.

