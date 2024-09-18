unit model_produto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, model_conexao_firebird, ACBrEnterTab, DB, Dialogs;

type

  { TModelDmProduto }

  TModelDmProduto = class(TDataModule)
    ACBrEnterTab1: TACBrEnterTab;
    QryPesquisa: TZQuery;
    QryConsultaProdutoPdv: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FModelConexaoFirebird: TModelConexaoFirebird;
    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
  public
    function ObterProdutoParaPdv(pDtSrc: TDataSource;
      pCodLoja, pCodProduto: string): boolean;

    procedure ObterProdutosConsultaPdv(pCodLoja, pTipoPesquisa, pVlrPesquisa: string);


    property ModelConexaoFirebird: TModelConexaoFirebird
      read FModelConexaoFirebird write SetModelConexaoFirebird;
  end;


  { IModelProduto }

  IModelProduto = interface
    ['{21BDF281-A507-4CAF-BBFA-29AA667B84AF}']
    function ObterProdutoParaPdv(pDtSrc: TDataSource;
      pCodLoja, pCodProduto: string): boolean;

  end;

  { TModelProduto }
  TModelProduto = class(TInterfacedObject, IModelProduto)
  private
    FModelDmProduto: TModelDmProduto;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IModelProduto;

    function ObterProdutoParaPdv(pDtSrc: TDataSource;
      pCodLoja, pCodProduto: string): boolean;
  end;


var
  ModelDmProduto: TModelDmProduto;

implementation

{$R *.lfm}

{ TModelDmProduto }

procedure TModelDmProduto.DataModuleCreate(Sender: TObject);
begin
end;

procedure TModelDmProduto.DataModuleDestroy(Sender: TObject);
begin

end;

procedure TModelDmProduto.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird = AValue then Exit;
  FModelConexaoFirebird := AValue;

  QryPesquisa.Connection := FModelConexaoFirebird.ConexaoFirebird;
  QryConsultaProdutoPdv.Connection := FModelConexaoFirebird.ConexaoFirebird;

end;

function TModelDmProduto.ObterProdutoParaPdv(pDtSrc: TDataSource;
  pCodLoja, pCodProduto: string): boolean;
var
  s: string;
begin
  pDtSrc.DataSet := QryPesquisa;
  QryPesquisa.Close;
  s := '';
  s := s + ' select s034.codprd, ';
  s := s + ' s034.codbar, ';
  s := s + ' s034.codfbr, ';
  s := s + ' s034.dcrprd, ';
  s := s + ' s034.codundprd, ';
  s := s + ' s035.vlrbasvda, ';
  s := s + ' s035.codtpotrb, ';
  s := s + ' s035.pertrb, ';
  s := s + ' s034.codprc, ';
  s := s + ' s035.pericm, ';
  s := s + ' s034.cest, ';
  s := s + ' s034.ncm, ';
  s := s + ' s035.codtpotrbsimples, ';
  s := S + ' s035.codtpotrbsimplesnaocontr,';
  s := S + ' s034.codcodtpotrbsimplesnaocontr,';
  s := s + ' s035.codtpotrbsimplesnaocontr,';
  s := s + ' s034.codtpopis, ';
  s := s + ' s034.codtpocofins, ';
  s := s + ' s034.peralipisnfe, ';
  s := s + ' s034.peralicofinsnfe ';
  s := s + ' from sinaf034 s034 ';
  s := s + ' left join sinaf035 s035 on s034.codprd = s035.codprd and s035.empgrp = :pCod_Empresa and s035.codlja = :pCodLoja ';
  s := s + ' where s034.codprd = :pCodProduto ';
  QryPesquisa.SQL.Text := s;
  QryPesquisa.ParamByName('pCod_Empresa').AsString := '01';
  QryPesquisa.ParamByName('pCodLoja').AsString := pCodLoja;
  QryPesquisa.ParamByName('pCodProduto').AsString := pCodProduto;
  QryPesquisa.Open;
  Result := not QryPesquisa.IsEmpty;
end;

procedure TModelDmProduto.ObterProdutosConsultaPdv(pCodLoja, pTipoPesquisa,
  pVlrPesquisa: string);

var
  s, LWhere, LOrderBy: string;
begin
  QryConsultaProdutoPdv.Connection := FModelConexaoFirebird.ConexaoFirebird;
  QryConsultaProdutoPdv.Close;
  s := '';
  s := s + 'select s034.codprd, s034.codbar, s034.codfbr, s034.dcrprd, ';
  s := s + ' s035.vlrbasvda' + ' from sinaf034 s034 ';
  s := s + ' left join sinaf035 s035 on s034.codprd = s035.codprd and s035.empgrp = :pCod_Empresa and s035.codlja = :pCodLoja ';

  LWhere := '';
  LOrderBy := '';
  if pTipoPesquisa = 'Código' then
  begin
    LWhere := LWhere + ' WHERE s034.codprd = :pVlrPesquisa';
    LOrderBy := LOrderBy + ' ORDER BY s034.codprd';
  end
  else if pTipoPesquisa = 'Código de Barra' then
  begin
    LWhere := LWhere + ' WHERE s034.codbar = :pVlrPesquisa';
    LOrderBy := LOrderBy + ' ORDER BY s034.codbar ';
  end
  else if pTipoPesquisa = 'Descrição' then
  begin
    LWhere := LWhere + ' WHERE s034.dcrprd like :pVlrPesquisa';
    pVlrPesquisa := pVlrPesquisa + '%';
    LOrderBy := LOrderBy + ' ORDER BY s034.dcrprd';
  end;
  QryConsultaProdutoPdv.SQL.Text := s + LWhere + LOrderBy;

  QryConsultaProdutoPdv.ParamByName('pCod_Empresa').AsString := '01';
  QryConsultaProdutoPdv.ParamByName('pCodLoja').AsString := pCodLoja;
  QryConsultaProdutoPdv.ParamByName('pVlrPesquisa').AsString := pVlrPesquisa;
  QryConsultaProdutoPdv.Open;

  TNumericField(QryConsultaProdutoPdv.FieldByName('VLRBASVDA')).DisplayFormat :=
    '###,###,###,##0.00';
end;

{ TModelProduto }

constructor TModelProduto.Create;
begin

end;

destructor TModelProduto.Destroy;
begin
  inherited Destroy;
end;

class function TModelProduto.New: IModelProduto;
begin

end;

function TModelProduto.ObterProdutoParaPdv(pDtSrc: TDataSource;
  pCodLoja, pCodProduto: string): boolean;
begin

end;

end.
