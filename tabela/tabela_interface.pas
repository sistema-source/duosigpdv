unit tabela_interface;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  SQLite3Conn,
  SQLDB;

type

  ITabela = interface
    procedure CriarTabela(pSQLCon: TSQLite3Connection; pSQLTrans: TSQLTransaction; pNomeBanco: string);
  end;

implementation

end.
