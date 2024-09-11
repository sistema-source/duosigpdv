unit model_venda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, DB, Forms,
  ACBrUtil, Dialogs,
  model_conexao_sqlite,
  model_conexao_firebird,
  model_configuracao_pdv,
  lib_funcoes;

type

  { TModelDmVenda }
  TModelDmVenda = class(TDataModule)
    DtSrcOrcamento: TDataSource;
    QryDetalhe: TZQuery;
    QryCabecalho: TZQuery;
    QryFormaPagto: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FCodCliente: integer;
    FCodCondicaoPagto: integer;
    FCodHistorico: string;
    FCodLoja: string;
    FCodSerieNF: string;
    FCodTabelaPreco: Integer;
    FCodTpCobranca: string;
    FCodTpEstoque: integer;
    FCodTpOperacao: string;
    FCodVendedor: string;
    FCodZonaVenda: string;
    FDtSrcCabecalho: TDataSource;
    FDtSrcDetalhe: TDataSource;
    FDtSrcFormaPagamento: TDataSource;
    FId: string;
    FContador: integer;
    FModelConexaoSqlite: TModelConexaoSqlite;
    FModelConexaoFirebird: TModelConexaoFirebird;
    FNumCaixa: integer;
    FTipoEntrega: string;
    FTipoFrete: string;
    FViaTransporte: string;
    procedure SetCodCliente(AValue: integer);
    procedure SetCodCondicaoPagto(AValue: integer);
    procedure SetCodHistorico(AValue: string);
    procedure SetCodLoja(AValue: string);
    procedure SetCodSerieNF(AValue: string);
    procedure SetCodTabelaPreco(AValue: Integer);
    procedure SetCodTpCobranca(AValue: string);
    procedure SetCodTpEstoque(AValue: integer);
    procedure SetCodTpOperacao(AValue: string);
    procedure SetCodVendedor(AValue: string);
    procedure SetCodZonaVenda(AValue: string);
    procedure SetDtSrcCabecalho(AValue: TDataSource);
    procedure SetDtSrcDetalhe(AValue: TDataSource);
    procedure SetDtSrcFormaPagamento(AValue: TDataSource);
    procedure SetId(AValue: string);
    function PodeInserirDuplicado(pValue: string): boolean;
    procedure SetNumCaixa(AValue: integer);
    procedure SetTipoEntrega(AValue: string);
    procedure SetTipoFrete(AValue: string);
    procedure SetViaTransporte(AValue: string);

  public
    procedure CarregarDadosOrcamento(pCodLoja, pNumOrcamento: string);
    procedure InserirCabecalhoVenda;
    procedure AtribuirCodSerieCabecalho(pValue: string);
    procedure ApagarFormaPagto(pId: string);
    procedure InserirDetalheVenda(pDtSrcProduto: TDataSource; pQtdade: currency);
    procedure InserirFormaPagto(pFormaPagto: string; pVlrPagto: currency;
      pNomeBandeira, pNumAutorizacao: string);
    procedure CancelarVenda(pId: string);
    procedure NovaVenda;
    procedure ObterDadosPadraoParaNovaVenda;
    ///
    property Id: string read FId write SetId;
    property DtSrcCabecalho: TDataSource read FDtSrcCabecalho write SetDtSrcCabecalho;
    property DtSrcDetalhe: TDataSource read FDtSrcDetalhe write SetDtSrcDetalhe;
    property DtSrcFormaPagamento: TDataSource
      read FDtSrcFormaPagamento write SetDtSrcFormaPagamento;
    ///
    property CodLoja: string read FCodLoja write SetCodLoja;
    property CodSerieNF: string read FCodSerieNF write SetCodSerieNF;
    property CodVendedor: string read FCodVendedor write SetCodVendedor;
    property CodHistorico: string read FCodHistorico write SetCodHistorico;
    property NumCaixa: integer read FNumCaixa write SetNumCaixa;
    property CodTpOperacao: string read FCodTpOperacao write SetCodTpOperacao;
    property CodCliente: integer read FCodCliente write SetCodCliente;
    property CodZonaVenda: string read FCodZonaVenda write SetCodZonaVenda;
    property CodTpEstoque: integer read FCodTpEstoque write SetCodTpEstoque;
    property CodTabelaPreco : Integer read FCodTabelaPreco write SetCodTabelaPreco;
    property TipoFrete: string read FTipoFrete write SetTipoFrete;
    property CodCondicaoPagto: integer read FCodCondicaoPagto write SetCodCondicaoPagto;
    property CodTpCobranca: string read FCodTpCobranca write SetCodTpCobranca;
    property ViaTransporte: string read FViaTransporte write SetViaTransporte;
    property TipoEntrega: string read FTipoEntrega write SetTipoEntrega;
    property CnpjCpfCliente : String;
  end;


implementation

{$R *.lfm}

{ TModelDmVenda }

procedure TModelDmVenda.DataModuleCreate(Sender: TObject);
begin
  FModelConexaoSqlite := TModelConexaoSqlite.Create(Self);
  FModelConexaoFirebird := TModelConexaoFirebird.Create(Self);
  QryCabecalho.Connection := FModelConexaoSqlite.Conexao;
  QryDetalhe.Connection := FModelConexaoSqlite.Conexao;
  QryFormaPagto.Connection := FModelConexaoSqlite.Conexao;
end;

procedure TModelDmVenda.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FModelConexaoSqlite);
end;

procedure TModelDmVenda.SetId(AValue: string);
begin
  if FId = AValue then Exit;
  FId := AValue;
end;

function TModelDmVenda.PodeInserirDuplicado(pValue: string): boolean;
begin
  Result := True;
  if QryFormaPagto.Locate('DESCRICAO_FORMA_PAGTO', pVAlue, [loCaseInsensitive]) then
  begin
    if (pValue <> 'Déibto') and (pValue <> 'Crédito') then
      Result := False;
  end;

end;

procedure TModelDmVenda.SetNumCaixa(AValue: integer);
begin
  if FNumCaixa = AValue then Exit;
  FNumCaixa := AValue;
end;

procedure TModelDmVenda.SetTipoEntrega(AValue: string);
begin
  if FTipoEntrega = AValue then Exit;
  FTipoEntrega := AValue;
end;

procedure TModelDmVenda.SetTipoFrete(AValue: string );
begin
  if FTipoFrete = AValue then Exit;
  FTipoFrete := AValue;
end;

procedure TModelDmVenda.SetViaTransporte(AValue: string);
begin
  if FViaTransporte = AValue then Exit;
  FViaTransporte := AValue;
end;

procedure TModelDmVenda.CancelarVenda(pId: string);
var
  Qry: TZQuery;
  s: string;
begin
  Qry := TZQuery.Create(Self);
  Qry.Connection := FModelConexaoSqlite.Conexao;

  try
    if pId <> '' then
    begin
      s := ' DELETE FROM CABECALHO  WHERE ID =  ' + QuotedStr(pId);
      Qry.SQL.Text := s;
      Qry.ExecSQL;

      Qry.Close;
      s := ' DELETE FROM DETALHE WHERE ID_CABECALHO =  ' + QuotedStr(pId);
      Qry.SQL.Text := s;
      Qry.ExecSQL;

      if QryCabecalho.Active then
        QryCabecalho.Close;

      if QryDetalhe.Active then
        QryDetalhe.Close;

      if QryFormaPagto.Active then
        QryFormaPagto.Close;

    end;

  finally
    Qry.Free;
  end;

end;

procedure TModelDmVenda.NovaVenda;
begin

  FId := '';

  QryCabecalho.Close;
  QryCabecalho.ParamByName('PID').AsString := FId;
  QryCabecalho.Open;

  QryDetalhe.Close;
  QryDetalhe.ParamByName('PID_CABECALHO').AsString := FId;
  QryDetalhe.Open;

  QryFormaPagto.Close;
  QryFormaPagto.ParamByName('PID_CABECALHO').AsString := FId;
  QryFormaPagto.Open;
end;

procedure TModelDmVenda.ObterDadosPadraoParaNovaVenda;
begin
  CodLoja     := ModelConfiguracaoPdv.CodLoja;
  CodSerieNF  := ModelConfiguracaoPdv.CodSerieNFCe;
  CodVendedor := ModelConfiguracaoPdv.CodVendedor;
  CodHistorico:= ModelConfiguracaoPdv.CodHistorico;
  NumCaixa := ModelConfiguracaoPdv.NumCaixa;
  CodTpOperacao:= ModelConfiguracaoPdv.CodTpOperacao;
  CodCliente := ModelConfiguracaoPdv.CodCliente;
  CodZonaVenda:= ModelConfiguracaoPdv.CodZonaVenda;
  CodTpEstoque:= ModelConfiguracaoPdv.CodTpEstoque;
  CodTabelaPreco := ModelConfiguracaoPdv.CodTabelaPreco;
  TipoFrete := ModelConfiguracaoPdv.TipoFrete;
  CodCondicaoPagto:= ModelConfiguracaoPdv.CodCondicaoPagto;
  CodTpCobranca:= ModelConfiguracaoPdv.CodTpCobranca;
  ViaTransporte:= ModelConfiguracaoPdv.ViaTransporte;
  TipoEntrega:= ModelConfiguracaoPdv.TipoEntrega;
end;

procedure TModelDmVenda.CarregarDadosOrcamento(pCodLoja, pNumOrcamento: string);
var
  QryOrcamento: TZQuery;
  s: string;
begin

  if FId <> '' then
  begin
    CancelarVenda(FId);
    FId := '';
  end;

  InserirCabecalhoVenda;

  QryOrcamento := TZQuery.Create(Self);
  QryOrcamento.Connection := FModelConexaoFirebird.ConexaoFirebird;
  s := '';
  s := s + ' SELECT  ';
  S := S + ' S053.CODLJA, S053.CODPRD, S034.CODBAR, S034.DCRPRD, S053.QTDPRD, S053.VLRPRD AS VLRBASVDA ';
  S := S + ' FROM SINAF053 S053 ';
  S := S + ' LEFT JOIN SINAF034 S034 ON S034.CODPRD = S053.CODPRD ';
  S := S + ' WHERE S053.EMPGRP = :PEMPRESA';
  S := S + ' AND   S053.CODLJA = :PCODLOJA';
  S := S + ' AND   S053.NUMORC = :PNUMORCAMENTO';

  QryOrcamento.SQL.Text := s;
  QryOrcamento.ParamByName('pEmpresa').AsString := '01';
  QryOrcamento.ParamByName('pCodLoja').AsString := pCodLoja;
  QryOrcamento.ParamByName('pNumOrcamento').AsString := pNumOrcamento;
  QryOrcamento.Open;
  DtSrcOrcamento.DataSet := QryOrcamento;
  try
    QryOrcamento.First;
    while not QryOrcamento.EOF do
    begin
      Self.InserirDetalheVenda(DtSrcOrcamento,
        QryOrcamento.FieldByName('QTDPRD').AsCurrency);
      Application.ProcessMessages;
      QryOrcamento.Next;
    end;
  finally
    QryOrcamento.Free;
  end;

end;

procedure TModelDmVenda.SetDtSrcCabecalho(AValue: TDataSource);
begin
  if FDtSrcCabecalho = AValue then Exit;
  FDtSrcCabecalho := AValue;
end;

procedure TModelDmVenda.SetCodCliente(AValue: integer);
begin
  if FCodCliente = AValue then Exit;
  FCodCliente := AValue;
end;

procedure TModelDmVenda.SetCodCondicaoPagto(AValue: integer);
begin
  if FCodCondicaoPagto = AValue then Exit;
  FCodCondicaoPagto := AValue;
end;

procedure TModelDmVenda.SetCodHistorico(AValue: string);
begin
  if FCodHistorico = AValue then Exit;
  FCodHistorico := AValue;
end;

procedure TModelDmVenda.SetCodLoja(AValue: string);
begin
  if FCodLoja = AValue then Exit;
  FCodLoja := AValue;
end;

procedure TModelDmVenda.SetCodSerieNF(AValue: string);
begin
  if FCodSerieNF = AValue then Exit;
  FCodSerieNF := AValue;
end;

procedure TModelDmVenda.SetCodTabelaPreco(AValue: Integer);
begin
  if FCodTabelaPreco=AValue then Exit;
  FCodTabelaPreco:=AValue;
end;

procedure TModelDmVenda.SetCodTpCobranca(AValue: string);
begin
  if FCodTpCobranca = AValue then Exit;
  FCodTpCobranca := AValue;
end;

procedure TModelDmVenda.SetCodTpEstoque(AValue: integer);
begin
  if FCodTpEstoque = AValue then Exit;
  FCodTpEstoque := AValue;
end;

procedure TModelDmVenda.SetCodTpOperacao(AValue: string);
begin
  if FCodTpOperacao = AValue then Exit;
  FCodTpOperacao := AValue;
end;

procedure TModelDmVenda.SetCodVendedor(AValue: string);
begin
  if FCodVendedor = AValue then Exit;
  FCodVendedor := AValue;
end;

procedure TModelDmVenda.SetCodZonaVenda(AValue: string);
begin
  if FCodZonaVenda = AValue then Exit;
  FCodZonaVenda := AValue;
end;

procedure TModelDmVenda.SetDtSrcDetalhe(AValue: TDataSource);
begin
  if FDtSrcDetalhe = AValue then Exit;
  FDtSrcDetalhe := AValue;
  FDtSrcDetalhe.DataSet := QryDetalhe;
end;

procedure TModelDmVenda.SetDtSrcFormaPagamento(AValue: TDataSource);
begin
  if FDtSrcFormaPagamento = AValue then Exit;
  FDtSrcFormaPagamento := AValue;
end;

procedure TModelDmVenda.InserirCabecalhoVenda;
begin
  if FID = '' then
  begin
    if QryCabecalho.Active then
      QryCabecalho.Cancel;

    FId := TLibFuncoes.ObterGuid;
    FContador := 1;

    QryCabecalho.Close;
    QryCabecalho.ParamByName('PID').AsString := FId;
    QryCabecalho.Open;
    QryCabecalho.Append;
    QryCabecalho.FieldByName('ID').AsString := FId;
    QryCabecalho.FieldByName('COD_LOJA').AsString := ModelConfiguracaoPdv.CodLoja;
    QryCabecalho.FieldByName('SERIE').AsString := '$$';
    QryCabecalho.FieldByName('NUM_NF').AsInteger := 0;
    QryCabecalho.FieldByName('DT_EMISSAO').AsDateTime := Date;
    QryCabecalho.FieldByName('DT_SAIDA').AsDateTime := Date;
{  := + ' UFD_EMIT VARCHAR(2),     ';
  := + ' COD_NUMERICO INTEGER,     ';
  := + ' NAT_OPERACAO VARCHAR(60),     ';
  := + ' MODELO_FISCAL VARCHAR(2),     ';
  := + ' TP_EMISSAO INTEGER ,     ';
  := + ' TP_NF INTEGER,     ';
  := + ' TP_IMPRESSAO INTEGER,     ';
  := + ' TP_AMBIENTE INTEGER,     ';
  := + ' VLR_NFE NUMERIC(15,2),';
  := + ' FINALIDADE_NFE INTEGER,     ';
  := + ' IND_FINAL INTEGER,     ';
  := + ' IND_PRESENCA INTEGER,     ';
  := + ' IND_INTERMEDIARIO INTEGER,     ';
  := + '   NOME_EMITENTE            VarChar(60),';
  := + '   FANTASIA_EMITENTE        VarChar(60),';
  := + '   LOGRADOURO_EMITENTE      VarChar(60),';
  := + '   NRO_EMITENTE             VarChar(60),';
  := + '   COMPLEMENTO_EMITENTE     VarChar(60),';
  := + '   BAIRRO_EMITENTE          VarChar(60),';
  := + '   COD_MUNICIPIO_EMITENTE   Integer,';
  := + '   NOME_MUNICIPIO_EMITENTE  VarChar(60),';
  := + '   UFD_EMITENTE             VarChar(2),';
  := + '   CEP_EMITENTE             Integer,';
  := + '   COD_PAIS_EMITENTE        Integer,';
  := + '   NOME_PAIS_EMITENTE       VarChar(60),';
  := + '   FONE_EMITENTE            VarChar(15),';
  := + '   IM_EMITENTE              VarChar(15),';
  := + '   CNAE_EMITENTE            Integer,';
  := + '   CRT_EMITENTE             Integer,';
  := + '   NOME_REMETENTE            VarChar(60),';
  := + '   FANTASIA_REMETENTE        VarChar(60),';
  := + '   LOGRADOURO_REMETENTE      VarChar(60),';
  := + '   NRO_REMETENTE             VarChar(60),';
  := + '   COMPLEMENTO_REMETENTE     VarChar(60),';
  := + '   BAIRRO_REMETENTE          VarChar(60),';
  := + '   COD_MUNICIPIO_REMETENTE   Integer,';
  := + '   NOME_MUNICIPIO_REMETENTE  VarChar(60),';
  := + '   UFD_REMETENTE             VarChar(2),';
  := + '   CEP_REMETENTE             Integer,';
  := + '   COD_PAIS_REMETENTE        Integer,';
  := + '   NOME_PAIS_REMETENTE       VarChar(60),';
  := + '   FONE_REMETENTE            VarChar(15),';
  := + '   IM_REMETENTE              VarChar(15),';
  := + '   CNAE_REMETENTE            Integer,';
  := + '   CRT_REMETENTE             Integer';
 }
    QryCabecalho.Post;
    QryCabecalho.Edit;

    TNumericField(QryCabecalho.FieldByName('VLR_NF')).DisplayFormat :=
      '###,###,###,##0.00';

    QryDetalhe.Close;
    QryDetalhe.ParamByName('PID_CABECALHO').AsString := FId;
    QryDetalhe.Open;

    TNumericField(QryDetalhe.FieldByName('VLR_UNITARIO')).DisplayFormat :=
      '###,###,###,##0.00';
    TNumericField(QryDetalhe.FieldByName('VLR_TOTAL')).DisplayFormat :=
      '###,###,###,##0.00';

    QryFormaPagto.Close;
    QryFormaPagto.ParamByName('PID_CABECALHO').AsString := FId;
    QryFormaPagto.Open;
    TNumericField(QryFormaPagto.FieldByName('VLR_FORMA_PAGTO')).DisplayFormat :=
      '###,###,###,##0.00';

  end;

end;

procedure TModelDmVenda.AtribuirCodSerieCabecalho(pValue: string);
begin
  QryCabecalho.FieldByName('SERIE').AsString := pValue;
end;

procedure TModelDmVenda.ApagarFormaPagto(pId: string);
begin
  QryCabecalho.FieldByName('VLR_RECEBIDO').AsCurrency :=
    QryCabecalho.FieldByName('VLR_RECEBIDO').AsCurrency -
    QryFormaPagto.FieldByName('VLR_FORMA_PAGTO').AsCurrency;

  QryCabecalho.FieldByName('VLR_SALDO_RECEBER').AsCurrency :=
    QryCabecalho.FieldByName('VLR_TOTAL_RECEBER').AsCurrency -
    QryCabecalho.FieldByName('VLR_RECEBIDO').AsCurrency;

  if QryCabecalho.FieldByName('VLR_SALDO_RECEBER').AsCurrency < 0 then
    QryCabecalho.FieldByName('VLR_SALDO_RECEBER').AsCurrency := 0;

  QryCabecalho.FieldByName('VLR_TROCO').AsCurrency :=
    QryCabecalho.FieldByName('VLR_RECEBIDO').AsCurrency -
    QryCabecalho.FieldByName('VLR_TOTAL_RECEBER').AsCurrency;

  if QryCabecalho.FieldByName('VLR_TROCO').AsCurrency < 0 then
    QryCabecalho.FieldByName('VLR_TROCO').AsCurrency := 0;

  QryFormaPagto.Delete;
end;

procedure TModelDmVenda.InserirDetalheVenda(pDtSrcProduto: TDataSource;
  pQtdade: currency);
begin
  if FId <> '' then
  begin
    QryDetalhe.Append;
    QryDetalhe.FieldByName('ID').AsString := TLibFuncoes.ObterGuid;

    QryDetalhe.FieldByName('ID_CABECALHO').AsString := FId;
    QryDetalhe.FieldByName('ORDEM_GRAVACAO').AsInteger := FContador;

    QryDetalhe.FieldByName('COD_ACESSO').AsString :=
      pDtSrcProduto.DataSet.FieldByName('CODPRD').AsString;

    QryDetalhe.FieldByName('COD_PRODUTO').AsString :=
      pDtSrcProduto.DataSet.FieldByName('CODPRD').AsString;

    QryDetalhe.FieldByName('DESCRICAO').AsString :=
      pDtSrcProduto.DataSet.FieldByName('DCRPRD').AsString;

    QryDetalhe.FieldByName('QTDADE').AsCurrency := pQtdade;


    QryDetalhe.FieldByName('VLR_UNITARIO').AsCurrency :=
      pDtSrcProduto.DataSet.FieldByName('VLRBASVDA').AsCurrency;

    QryDetalhe.FieldByName('PER_DECONTO').AsCurrency := 0;

    QryDetalhe.FieldByName('VLR_TOTAL').AsCurrency :=
      RoundABNT(QryDetalhe.FieldByName('QTDADE').AsCurrency *
      QryDetalhe.FieldByName('VLR_UNITARIO').AsCurrency, 2);

    QryDetalhe.Post;

    QryCabecalho.FieldByName('VLR_NF').AsCurrency :=
      QryCabecalho.FieldByName('VLR_NF').AsCurrency +
      QryDetalhe.FieldByName('VLR_TOTAL').AsCurrency;

    QryCabecalho.FieldByName('VLR_TOTAL_RECEBER').AsCurrency :=
      QryCabecalho.FieldByName('VLR_TOTAL_RECEBER').AsCurrency +
      QryDetalhe.FieldByName('VLR_TOTAL').AsCurrency;

    Inc(FContador);
  end;

end;

procedure TModelDmVenda.InserirFormaPagto(pFormaPagto: string;
  pVlrPagto: currency; pNomeBandeira, pNumAutorizacao: string);
begin
  if FId <> '' then
  begin

    if not PodeInserirDuplicado(pFormaPagto) then
    begin
      raise Exception.Create('A Forma de Pagamento [' + pFormaPagto +
        '] não pode ser lançado em duplicidade');
      Exit;
    end;

    QryFormaPagto.Append;
    QryFormaPagto.FieldByName('ID').AsString := TLibFuncoes.ObterGuid;

    QryFormaPagto.FieldByName('ID_CABECALHO').AsString := FId;
    QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString := pFormaPagto;
    QryFormaPagto.FieldByName('NOME_BANDEIRA').AsString := pNomeBandeira;
    QryFormaPagto.FieldByName('VLR_FORMA_PAGTO').AsCurrency := pVlrPagto;
    QryFormaPagto.FieldByName('NUM_AUTORIZACAO').AsString := pNumAutorizacao;

    if UpperCase(QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString) =
      'DINHEIRO' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '01'
    else if UpperCase(QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString) =
      'CHEQUE' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '02'
    else if UpperCase(QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString) =
      'CRÉDITO' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '03'
    else if UpperCase(QryFormaPagto.FieldByName(
      'DESCRICAO_FORMA_PAGTO').AsString) =
      'DÉBITO' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '04'
    else if UpperCase(QryFormaPagto.FieldByName(
      'DESCRICAO_FORMA_PAGTO').AsString) =
      'CARTEIRA DIGITAL' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '18'
    else if UpperCase(QryFormaPagto.FieldByName(
      'DESCRICAO_FORMA_PAGTO').AsString) = 'PIX' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '17';

    QryFormaPagto.Post;


    QryCabecalho.FieldByName('VLR_RECEBIDO').AsCurrency :=
      QryCabecalho.FieldByName('VLR_RECEBIDO').AsCurrency +
      QryFormaPagto.FieldByName('VLR_FORMA_PAGTO').AsCurrency;

    QryCabecalho.FieldByName('VLR_SALDO_RECEBER').AsCurrency :=
      QryCabecalho.FieldByName('VLR_TOTAL_RECEBER').AsCurrency -
      QryCabecalho.FieldByName('VLR_RECEBIDO').AsCurrency;

    if QryCabecalho.FieldByName('VLR_SALDO_RECEBER').AsCurrency < 0 then
      QryCabecalho.FieldByName('VLR_SALDO_RECEBER').AsCurrency := 0;

    QryCabecalho.FieldByName('VLR_TROCO').AsCurrency :=
      QryCabecalho.FieldByName('VLR_RECEBIDO').AsCurrency -
      QryCabecalho.FieldByName('VLR_TOTAL_RECEBER').AsCurrency;

    if QryCabecalho.FieldByName('VLR_TROCO').AsCurrency < 0 then
      QryCabecalho.FieldByName('VLR_TROCO').AsCurrency := 0;

  end;
end;

end.
