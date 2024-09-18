unit model_venda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, DB, Forms,
  ACBrUtil, Dialogs,
  model_conexao_sqlite,
  model_sessao,
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
    QryPesquisa: TZReadOnlyQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FCnpjCpfCliente: string;
    FCodCliente: integer;
    FCodCondicaoPagto: integer;
    FCodHistorico: string;
    FCodLoja: string;
    FCodSerieNF: string;
    FCodTabelaPreco: integer;
    FCodTpCobranca: string;
    FCodTpEstoque: integer;
    FCodTpOperacao: string;
    FCodVendedor: string;
    FCodZonaVenda: string;
    FDtSrcCabecalho: TDataSource;
    FDtSrcDetalhe: TDataSource;
    FDtSrcFormaPagamento: TDataSource;
    FEspecieVolume: string;
    FFinalidadeNFe: string;
    FId: string;
    FContador: integer;
    FStsConsumidorFinal: string;
    FIndIntermediario: string;
    FStsPresenca: string;
    FMarcaVolume: string;
    FModelConexaoSqlite: TModelConexaoSqlite;
    FModelConexaoFirebird: TModelConexaoFirebird;
    FNomeCliente: string;
    FNomeMotorista: string;
    FNumCaixa: integer;
    FNumEmbalagem: string;
    FNumOrcamento: integer;
    FPesoBruto: double;
    FPesoLiquido: double;
    FPlacaVeiculo: string;
    FQtdVolume: integer;
    FStsCifFob: string;
    FTipoEntrega: string;
    FTipoFrete: string;
    FTpEmissao: string;
    FTpImpressao: string;
    FTpNf: string;
    FUfdPlaca: string;
    FViaTransporte: string;
    procedure SetCnpjCpfCliente(AValue: string);
    procedure SetCodCliente(AValue: integer);
    procedure SetCodCondicaoPagto(AValue: integer);
    procedure SetCodHistorico(AValue: string);
    procedure SetCodLoja(AValue: string);
    procedure SetCodSerieNF(AValue: string);
    procedure SetCodTabelaPreco(AValue: integer);
    procedure SetCodTpCobranca(AValue: string);
    procedure SetCodTpEstoque(AValue: integer);
    procedure SetCodTpOperacao(AValue: string);
    procedure SetCodVendedor(AValue: string);
    procedure SetCodZonaVenda(AValue: string);
    procedure SetDtSrcCabecalho(AValue: TDataSource);
    procedure SetDtSrcDetalhe(AValue: TDataSource);
    procedure SetDtSrcFormaPagamento(AValue: TDataSource);
    procedure SetEspecieVolume(AValue: string);
    procedure SetFinalidadeNFe(AValue: string);
    procedure SetId(AValue: string);
    function PodeInserirDuplicado(pValue: string): boolean;
    procedure SetIndFinal(AValue: string);
    procedure SetIndIntermediario(AValue: string);
    procedure SetIndPresenca(AValue: string);
    procedure SetMarcaVolume(AValue: string);
    procedure SetNomeCliente(AValue: string);
    procedure SetNomeMotorista(AValue: string);
    procedure SetNumCaixa(AValue: integer);
    procedure SetNumEmbalagem(AValue: string);
    procedure SetNumOrcamento(AValue: integer);
    procedure SetPesoBruto(AValue: double);
    procedure SetPesoLiquido(AValue: double);
    procedure SetPlacaVeiculo(AValue: string);
    procedure SetQtdVolume(AValue: integer);
    procedure SetStsCifFob(AValue: string);
    procedure SetTipoEntrega(AValue: string);
    procedure SetTipoFrete(AValue: string);
    procedure SetTpEmissao(AValue: string);
    procedure SetTpImpressao(AValue: string);
    procedure SetTpNf(AValue: string);
    procedure SetUfdPlaca(AValue: string);
    procedure SetViaTransporte(AValue: string);

    function AtribuirCstIcmsAndCfo(pQryDetalhe, pQryCabecalho: TZQuery): string;

  public
    procedure CarregarDadosOrcamento(pCodLoja, pNumOrcamento: string);
    procedure InserirCabecalhoVenda;
    procedure AtribuirCodSerieCabecalho(pValue: string);
    procedure ApagarFormaPagto(pId: string);
    procedure InserirDetalheVenda(pDtSrcProduto: TDataSource; pQtdade: currency);
    procedure InserirFormaPagto(pFormaPagto: string; pVlrPagto: currency;
      pNomeBandeira, pNumAutorizacao, pDoc001, pDoc002: string);
    procedure CancelarVenda(pId: string);
    procedure NovaVenda;
    procedure EncerrarVenda;
    procedure EncerrarVendaProduto;

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
    property NomeCliente: string read FNomeCliente write SetNomeCliente;
    property CodZonaVenda: string read FCodZonaVenda write SetCodZonaVenda;
    property CodTpEstoque: integer read FCodTpEstoque write SetCodTpEstoque;
    property CodTabelaPreco: integer read FCodTabelaPreco write SetCodTabelaPreco;
    property TipoFrete: string read FTipoFrete write SetTipoFrete;
    property CodCondicaoPagto: integer read FCodCondicaoPagto write SetCodCondicaoPagto;
    property CodTpCobranca: string read FCodTpCobranca write SetCodTpCobranca;
    property ViaTransporte: string read FViaTransporte write SetViaTransporte;
    property TipoEntrega: string read FTipoEntrega write SetTipoEntrega;
    property CnpjCpfCliente: string read FCnpjCpfCliente write SetCnpjCpfCliente;

    property EspecieVolume: string read FEspecieVolume write SetEspecieVolume;
    property FinalidadeNFe: string read FFinalidadeNFe write SetFinalidadeNFe;
    property IndFinal: string read FStsConsumidorFinal write SetIndFinal;
    property IndIntermediario: string read FIndIntermediario write SetIndIntermediario;
    property IndPresenca: string read FStsPresenca write SetIndPresenca;
    property MarcaVolume: string read FMarcaVolume write SetMarcaVolume;
    property NomeMotorista: string read FNomeMotorista write SetNomeMotorista;
    property NumEmbalagem: string read FNumEmbalagem write SetNumEmbalagem;
    property NumOrcamento: integer read FNumOrcamento write SetNumOrcamento;
    property PesoBruto: double read FPesoBruto write SetPesoBruto;
    property PesoLiquido: double read FPesoLiquido write SetPesoLiquido;
    property PlacaVeiculo: string read FPlacaVeiculo write SetPlacaVeiculo;
    property QtdVolume: integer read FQtdVolume write SetQtdVolume;
    property StsCifFob: string read FStsCifFob write SetStsCifFob;
    property TpEmissao: string read FTpEmissao write SetTpEmissao;
    property TpImpressao: string read FTpImpressao write SetTpImpressao;
    property TpNf: string read FTpNf write SetTpNf;
    property UfdPlaca: string read FUfdPlaca write SetUfdPlaca;
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

procedure TModelDmVenda.SetIndFinal(AValue: string);
begin
  if FStsConsumidorFinal = AValue then Exit;
  FStsConsumidorFinal := AValue;
end;

procedure TModelDmVenda.SetIndIntermediario(AValue: string);
begin
  if FIndIntermediario = AValue then Exit;
  FIndIntermediario := AValue;
end;

procedure TModelDmVenda.SetIndPresenca(AValue: string);
begin
  if FStsPresenca = AValue then Exit;
  FStsPresenca := AValue;
end;

procedure TModelDmVenda.SetMarcaVolume(AValue: string);
begin
  if FMarcaVolume = AValue then Exit;
  FMarcaVolume := AValue;
end;

procedure TModelDmVenda.SetNomeCliente(AValue: string);
begin
  if FNomeCliente = AValue then Exit;
  FNomeCliente := AValue;
end;

procedure TModelDmVenda.SetNomeMotorista(AValue: string);
begin
  if FNomeMotorista = AValue then Exit;
  FNomeMotorista := AValue;
end;

procedure TModelDmVenda.SetNumCaixa(AValue: integer);
begin
  if FNumCaixa = AValue then Exit;
  FNumCaixa := AValue;
end;

procedure TModelDmVenda.SetNumEmbalagem(AValue: string);
begin
  if FNumEmbalagem = AValue then Exit;
  FNumEmbalagem := AValue;
end;

procedure TModelDmVenda.SetNumOrcamento(AValue: integer);
begin
  if FNumOrcamento = AValue then Exit;
  FNumOrcamento := AValue;
end;

procedure TModelDmVenda.SetPesoBruto(AValue: double);
begin
  if FPesoBruto = AValue then Exit;
  FPesoBruto := AValue;
end;

procedure TModelDmVenda.SetPesoLiquido(AValue: double);
begin
  if FPesoLiquido = AValue then Exit;
  FPesoLiquido := AValue;
end;

procedure TModelDmVenda.SetPlacaVeiculo(AValue: string);
begin
  if FPlacaVeiculo = AValue then Exit;
  FPlacaVeiculo := AValue;
end;

procedure TModelDmVenda.SetQtdVolume(AValue: integer);
begin
  if FQtdVolume = AValue then Exit;
  FQtdVolume := AValue;
end;

procedure TModelDmVenda.SetStsCifFob(AValue: string);
begin
  if FStsCifFob = AValue then Exit;
  FStsCifFob := AValue;
end;

procedure TModelDmVenda.SetTipoEntrega(AValue: string);
begin
  if FTipoEntrega = AValue then Exit;
  FTipoEntrega := AValue;
end;

procedure TModelDmVenda.SetTipoFrete(AValue: string);
begin
  if FTipoFrete = AValue then Exit;
  FTipoFrete := AValue;
end;

procedure TModelDmVenda.SetTpEmissao(AValue: string);
begin
  if FTpEmissao = AValue then Exit;
  FTpEmissao := AValue;
end;

procedure TModelDmVenda.SetTpImpressao(AValue: string);
begin
  if FTpImpressao = AValue then Exit;
  FTpImpressao := AValue;
end;

procedure TModelDmVenda.SetTpNf(AValue: string);
begin
  if FTpNf = AValue then Exit;
  FTpNf := AValue;
end;

procedure TModelDmVenda.SetUfdPlaca(AValue: string);
begin
  if FUfdPlaca = AValue then Exit;
  FUfdPlaca := AValue;
end;

procedure TModelDmVenda.SetViaTransporte(AValue: string);
begin
  if FViaTransporte = AValue then Exit;
  FViaTransporte := AValue;
end;

function TModelDmVenda.AtribuirCstIcmsAndCfo(pQryDetalhe, pQryCabecalho:
  TZQuery): string;
var
  s: string;

begin

  S := ' select ';
  s := s + ' s105.codope, ';
  s := s + ' s105.codtpotrb, ';
  s := s + ' s105.cfoint, ';
  s := s + ' s105.cfoext, ';
  s := s + '  s105.cfoforestnaocon, ';
  s := s + ' s105.cfointnaocon ';
  s := s + ' from sinaf105 s105 ';
  s := s + ' where s105.codtpotrb = :pCodTpoTrb ';
  s := s + ' and s105.codope = :pCodOpe';
  QryPesquisa.Close;
  QryPesquisa.SQL.Text := s;
  QryPesquisa.ParamByName('pCodTpoTrb').AsString :=
    PQryDetalhe.FieldByName('CST_ICMS').AsString;
  QryPesquisa.ParamByName('pCodOpe').AsString :=
    pQryCabecalho.FieldByName('COD_TP_OPERACAO').AsString;
  QryPesquisa.Open;

  if (pQryCabecalho.FieldByName('UFD_CLIENTE').AsString =
    pQryCabecalho.FieldByName('UFD_EMITENTE').AsString) or
    (pQryCabecalho.FieldByName('STS_PRESENCA').AsString = 'S') then
  begin
    // Venda dentro do estado
    if PQryCabecalho.FieldByName('STS_CONTRIBUINTE').AsString = 'S' then   // Se for contribuinte
      pQryDetalhe.FieldByName('CFO').AsString :=
        QryPesquisa.FieldByName('cfoint').AsString
    else
      pQryDetalhe.FieldByName('CFO').AsString :=
        QryPesquisa.FieldByName('cfointnaocon').AsString;

  end
  else
  begin

    // Venda fora do estado
    if PQryCabecalho.FieldByName('STS_CONTRIBUINTE').AsString = 'S' then   // Se for contribuinte
      pQryDetalhe.FieldByName('CFO').AsString :=
        QryPesquisa.FieldByName('cfoext').AsString
    else
      pQryDetalhe.FieldByName('CFO').AsString :=
        QryPesquisa.FieldByName('cfoforestnaocon').AsString;

    // Pegar o Codigo do Tipo de Tributacao do Estado de Destino
    s := '  select ';
    s := s + ' s076.ufd, ';
    s := s + ' s076.nomufd, ';
    s := s + ' s076.pericm, ';
    s := s + ' s076.msgpad, ';
    s := s + ' s076.codufdibge, ';
    s := s + ' s076.perfndpbz, ';
    s := s + ' s076.pericmprdimp, ';
    s := s + ' s076.pericmsdifaldestino ';
    s := s + ' from sinaf076 s076 ';
    s := s + ' where s079.ufd = :pUfd ';
    QryPesquisa.Close;
    QryPesquisa.SQL.Text := s;
    QryPesquisa.ParamByName('pUfd').AsString :=
      pQryCabecalho.FieldByName('UFD_CLIENTE').AsString;
    QryPesquisa.Open;

    // Produto Importado,pega a aliquota de impostos importado
    if (pQryDetalhe.FieldByName('COD_PROCEDENCIA').AsString = '1') or
      (pQryDetalhe.FieldByName('COD_PROCEDENCIA').AsString = '2') or
      (pQryDetalhe.FieldByName('COD_PROCEDENCIA').AsString = '3') or
      (pQryDetalhe.FieldByName('COD_PROCEDENCIA').AsString = '8') then
    begin
      pQryDetalhe.FieldByName('PER_ICMS').AsCurrency :=
        QryPesquisa.FieldByName('pericmprdimp').AsCurrency;
    end
    else
    begin
      pQryDetalhe.FieldByName('PER_ICMS').AsCurrency :=
        QryPesquisa.FieldByName('pericm').AsCurrency;
    end;

    PQryDetalhe.FieldByName('PER_FUNDO_POBREZA').AsCurrency :=  QryPesquisa.FieldByName('perfndpbz').AsCurrency;
    PQryDetalhe.FieldByName('PER_DIFAL_DESTINO').AsCurrency :=  QryPesquisa.FieldByName('pericmsdifaldestino').AsCurrency;

    PQryCabecalho.FieldByName('MSG_PADRAO').AsString :=
      QryPesquisa.FieldByName('msgpad').AsString;
  end;

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

      Qry.Close;
      s := ' DELETE FROM FORMA_PAGTO WHERE ID_CABECALHO =  ' + QuotedStr(pId);
      Qry.SQL.Text := s;
      Qry.ExecSQL;

      if QryCabecalho.Active then
        QryCabecalho.Close;

      if QryDetalhe.Active then
        QryDetalhe.Close;

      if QryFormaPagto.Active then
        QryFormaPagto.Close;

      FId := '';
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

procedure TModelDmVenda.EncerrarVenda;
var
  Qry: TZReadOnlyQuery;
  s: string;
begin
  Qry := TZReadOnlyQuery.Create(nil);
  Qry.Connection := FModelConexaoFirebird.ConexaoFirebird;
  try

    // Ler Loja
    s := ' SELECT ';
    s := s + '  S018.BAILJA, ';
    s := s + '  S018.CEPLJA, ';
    s := s + '  S018.CNAE,   ';
    s := s + '  S018.CGCLJA, ';
    s := s + '  S018.CODMUNIBGE, ';
    s := s + '  s554.CODPAISIBGE,';
    s := s + '  ' + QuotedStr('') + ' as CMPENDLJA, ';
    s := s + '  S018.NOMFNT,     ';
    s := s + '  S018.NUMTELLJA,  ';
    s := s + '  S018.IME,        ';
    s := s + '  S018.INE,        ';
    s := s + '  S018.ENDLJA,     ';
    s := s + '  S018.NOMLJA,     ';
    s := s + '  s554.MUN,        ';
    s := s + '  ' + QuotedStr('BRASIL') + ' as NOMPAIS, ';
    s := s + '  S018.ENDLJA as NRO,  ';
    s := s + '  S018.STATPOAMB,      ';
    s := s + '  S018.UFDLJA          ';
    s := s + '  FROM SINAF018 S018   ';
    s := s + '  LEFT JOIN SINAF554 S554 ON S554.CODMUNIBGE = S018.CODMUNIBGE ';
    s := s + '  WHERE S018.CODLJA = ' + QuotedStr(FCodLoja);
    Qry.SQL.Text := s;
    Qry.Open;

    QryCabecalho.FieldByName('BAIRRO_EMITENTE').AsString :=
      Qry.FieldByName('BAILJA').AsString;
    QryCabecalho.FieldByName('CEP_EMITENTE').AsString :=
      Qry.FieldByName('CEPLJA').AsString;
    QryCabecalho.FieldByName('CNAE_EMITENTE').AsString :=
      Qry.FieldByName('CNAE').AsString;
    QryCabecalho.FieldByName('CNPJ_CPF_EMITENTE').AsString :=
      Qry.FieldByName('CGCLJA').AsString;
    QryCabecalho.FieldByName('COD_MUNICIPIO_EMITENTE').AsString :=
      Qry.FieldByName('CODMUNIBGE').AsString;
    QryCabecalho.FieldByName('COD_PAIS_EMITENTE').AsString :=
      Qry.FieldByName('CODPAISIBGE').AsString;
    QryCabecalho.FieldByName('COMPLEMENTO_EMITENTE').AsString :=
      Qry.FieldByName('CMPENDLJA').AsString;
    QryCabecalho.FieldByName('FANTASIA_EMITENTE').AsString :=
      Qry.FieldByName('NOMFNT').AsString;
    QryCabecalho.FieldByName('FONE_EMITENTE').AsString :=
      Qry.FieldByName('NUMTELLJA').AsString;
    QryCabecalho.FieldByName('IM_EMITENTE').AsString := Qry.FieldByName('IME').AsString;
    QryCabecalho.FieldByName('INSC_ESTADUAL_EMITENTE').AsString :=
      Qry.FieldByName('INE').AsString;
    QryCabecalho.FieldByName('LOGRADOURO_EMITENTE').AsString :=
      TLibFuncoes.Extract(Qry.FieldByName('ENDLJA').AsString, 1, ';');
    QryCabecalho.FieldByName('NOME_EMITENTE').AsString :=
      Qry.FieldByName('NOMLJA').AsString;
    QryCabecalho.FieldByName('MUNICIPIO_EMITENTE').AsString :=
      Qry.FieldByName('MUN').AsString;
    QryCabecalho.FieldByName('NOME_PAIS_EMITENTE').AsString :=
      Qry.FieldByName('NOMPAIS').AsString;
    QryCabecalho.FieldByName('NRO_EMITENTE').AsString :=
      TLibFuncoes.Extract(Qry.FieldByName('NRO').AsString, 2, ';');
    QryCabecalho.FieldByName('TP_AMBIENTE').AsString :=
      Qry.FieldByName('STATPOAMB').AsString;
    QryCabecalho.FieldByName('UFD_EMITENTE').AsString :=
      Qry.FieldByName('UFDLJA').AsString;

    // Dados do cliente
    s := ' SELECT ';
    s := S + ' S019.BAICLI, ';
    s := S + ' S019.CEPCLI, ';
    s := S + ' S019.CNAE,';
    s := S + ' S019.CGCCPFCLI, ';
    s := S + ' S019.CODMUNIBGE,';
    s := S + ' S554.CODPAISIBGE, ';
    s := S + ' S019.CPMEND, ';
    s := S + ' S019.IME, ';
    s := S + ' S019.INE, ';
    s := S + ' S019.ENDCLI, ';
    s := S + ' S554.MUN, ';
    s := S + ' S554.NOMPAISIBGE, ';
    s := S + ' s019.NOMCLI, ';
    s := S + ' s019.ENDCLI, ';
    s := S + ' s019.UFDCLI, ';
    s := S + ' (SELECT FIRST 1 S082.NUMTEL FROM SINAF082 S082 ';
    s := S + ' where s082.codcli = s019.codcli ';
    s := S + ' and   s082.statpo = ' + QuotedStr('T');
    s := S + ' and   s082.numtel <> ' + QuotedStr('') + ') as numtel,';
    s := S + ' s019.nomfnt, ';
    s := S + ' s019.codzonvda, ';
    s := S + ' s019.codtpocob, ';
    s := S + ' s019.codvnd ';
    s := S + ' FROM SINAF019 S019 ';
    s := S + ' LEFT JOIN SINAF554 S554 ON S554.CODMUNIBGE = S019.CODMUNIBGE ';
    S := S + ' WHERE S019.CODCLI = ' + IntToStr(FCodCliente);

    Qry.Close;
    Qry.SQL.Text := s;
    Qry.Open;

    QryCabecalho.FieldByName('COD_CLIENTE').AsInteger := FCodCliente;

    QryCabecalho.FieldByName('BAIRRO_CLIENTE').AsString :=
      Qry.FieldByName('BAICLI').AsString;

    QryCabecalho.FieldByName('CEP_CLIENTE').AsString :=
      Qry.FieldByName('CEPCLI').AsString;
    QryCabecalho.FieldByName('CNAE_CLIENTE').AsString :=
      Qry.FieldByName('CNAE').AsString;
    QryCabecalho.FieldByName('CNPJ_CPF_CLIENTE').AsString := FCnpjCpfCliente;
    QryCabecalho.FieldByName('COD_MUNICIPIO_CLIENTE').AsString :=
      Qry.FieldByName('CODMUNIBGE').AsString;
    QryCabecalho.FieldByName('COD_PAIS_CLIENTE').AsString :=
      Qry.FieldByName('CODPAISIBGE').AsString;
    QryCabecalho.FieldByName('COMPLEMENTO_CLIENTE').AsString :=
      Qry.FieldByName('CPMEND').AsString;
    QryCabecalho.FieldByName('IM_CLIENTE').AsString := Qry.FieldByName('IME').AsString;
    QryCabecalho.FieldByName('INSC_ESTADUAL_CLIENTE').AsString :=
      Qry.FieldByName('INE').AsString;
    QryCabecalho.FieldByName('LOGRADOURO_CLIENTE').AsString :=
      TLibFuncoes.Extract(Qry.FieldByName('ENDCLI').AsString, 1, ';');
    QryCabecalho.FieldByName('MUNICIPIO_CLIENTE').AsString :=
      Qry.FieldByName('MUN').AsString;

    QryCabecalho.FieldByName('NOME_PAIS_CLIENTE').AsString :=
      Qry.FieldByName('NOMPAISIBGE').AsString;

    QryCabecalho.FieldByName('NOME_CLIENTE').AsString := FNomeCliente;

    QryCabecalho.FieldByName('NRO_CLIENTE').AsString :=
      TLibFuncoes.Extract(Qry.FieldByName('ENDCLI').AsString, 2, ';');
    QryCabecalho.FieldByName('UFD_CLIENTE').AsString :=
      Qry.FieldByName('UFDCLI').AsString;
    QryCabecalho.FieldByName('FONE_CLIENTE').AsString :=
      Qry.FieldByName('numtel').AsString;
    QryCabecalho.FieldByName('FANTASIA_CLIENTE').AsString :=
      Qry.FieldByName('nomfnt').AsString;
    ///
    QryCabecalho.FieldByName('COD_CONDICAO_PAGTO').AsInteger := FCodCondicaoPagto;
    QryCabecalho.FieldByName('COD_TABELA_PRECO').AsInteger := FCodTabelaPreco;
    QryCabecalho.FieldByName('COD_HISTORICO').AsString := FCodHistorico;
    QryCabecalho.FieldByName('COD_ZONA_VENDA').AsString := FCodZonaVenda;
    QryCabecalho.FieldByName('COD_NUMERICO').AsInteger := TLibFuncoes.ObterCodNumerico;
    QryCabecalho.FieldByName('COD_TP_COBRANCA').AsString := FCodTpCobranca;
    ;
    QryCabecalho.FieldByName('COD_VENDEDOR').AsString := FCodVendedor;
    QryCabecalho.FieldByName('SERIE').AsString := FCodSerieNF;
    QryCabecalho.FieldByName('NUM_CAIXA').AsInteger := FNumCaixa;


    // Serie
    s := ' SELECT ';
    s := s + ' S103.MODFSC FROM SINAF103 S103 ';
    s := s + ' WHERE S103.EMPGRP = ' + QuotedStr('01');
    s := s + ' AND   S103.CODLJA = ' + QuotedStr(FCodLoja);
    s := s + ' AND   S103.CODSRE = ' + QuotedStr(FCodSerieNF);
    Qry.Close;
    Qry.SQL.Text := s;
    Qry.Open;
    QryCabecalho.FieldByName('MODELO_FISCAL').AsString :=
      Qry.FieldByName('MODFSC').AsString;

    // Natureza Operacao
    s := ' SELECT ';
    s := s + ' S104.CODOPE, S104.TPOOPE, S104.DCROPE  FROM SINAF104 S104 ';
    s := s + ' WHERE S104.CODOPE = ' + QuotedStr(FCodTpOperacao);
    Qry.Close;
    Qry.SQL.Text := s;
    Qry.Open;
    QryCabecalho.FieldByName('NAT_OPERACAO').AsString :=
      Qry.FieldByName('DCROPE').AsString;
    QryCabecalho.FieldByName('STS_CFO').AsString := Qry.FieldByName('TPOOPE').AsString;

    QryCabecalho.FieldByName('ESPECIE_VOLUME').AsString := FEspecieVolume;
    QryCabecalho.FieldByName('MARCA_VOLUME').AsString := FMarcaVolume;
    QryCabecalho.FieldByName('NOME_MOTORISTA').AsString := FNomeMotorista;
    QryCabecalho.FieldByName('NUM_EMBALAGEM').AsString := FNumEmbalagem;
    QryCabecalho.FieldByName('PESO_BRUTO').AsFloat := FPesoBruto;
    QryCabecalho.FieldByName('PESO_LIQUIDO').AsFloat := FPesoLiquido;
    QryCabecalho.FieldByName('PLACA_VEICULO').AsString := FPlacaVeiculo;
    QryCabecalho.FieldByName('QTD_VOLUME').AsString := FQtdVolume;
    QryCabecalho.FieldByName('STS_CIF_FOB').AsString := FEspecieVolume;
    QryCabecalho.FieldByName('TP_EMISSAO').AsString := FEspecieVolume;
    QryCabecalho.FieldByName('TP_IMPRESSAO').AsString := FEspecieVolume;
    QryCabecalho.FieldByName('TP_NF').AsString := FEspecieVolume;
    QryCabecalho.FieldByName('UFD_PLACA').AsString := FUfdPlaca;
    QryCabecalho.FieldByName('VIA_TRANSPORTE').AsString := FViaTransporte;
    QryCabecalho.FieldByName('STS_CONSUMIDOR_FINAL').AsString := FStsConsumidorFinal;
    QryCabecalho.FieldByName('STS_PRESENCA').AsString := FStsPresenca;
    QryCabecalho.FieldByName('STS_CONVERTIDO').AsString := 'N';
    QryCabecalho.Post;
  finally
    Qry.Free;
  end;
  // Percorrer os produtos
  QryDetalhe.First;
end;

procedure TModelDmVenda.EncerrarVendaProduto;
var
  VlrDesconto, VlrFrete, PerFrete, PerDesconto, VlrBasePisCofins: currency;
  VlrProdutoMaisCaro: currency;
  Registro: TBookMark;
begin
  // Fazer o Rateio do itens
  VlrProdutoMaisCaro := 0;
  VlrDesconto := QryCabecalho.FieldByName('VLR_DESCONTO').AsCurrency;
  VlrFrete := QryCabecalho.FieldByName('VLR_FRETE').AsCurrency;
  PerFrete := QryCabecalho.FieldByName('VLR_FRETE').AsCurrency /
    QryCabecalho.FieldByName('VLR_PRODUTOS').AsCurrency * 100;
  PerDesconto := QryCabecalho.FieldByName('VLR_DESCONTO').AsCurrency /
    QryCabecalho.FieldByName('VLR_PRODUTOS').AsCurrency * 100;
  QryDetalhe.First;
  while not QryDetalhe.EOF do
  begin
    QryDetalhe.Edit;
    QryDetalhe.FieldByName('VLR_DESCONTO').AsCurrency :=
      RoundABNT(QryDetalhe.FieldByName('VLR_BRUTO').AsCurrency * PerDesconto / 100, 2);
    QryDetalhe.FieldByName('VLR_FRETE').AsCurrency :=
      RoundABNT(QryDetalhe.FieldByName('VLR_BRUTO').AsCurrency * PerFrete / 100, 2);

    VlrDesconto := VlrDesconto - QryDetalhe.FieldByName('VLR_DESCONTO').AsCurrency;
    VlrFrete := VlrFrete - QryDetalhe.FieldByName('VLR_FRETE').AsCurrency;

    if QryDetalhe.FieldByName('VLR_BRUTO').AsCurrency > VlrProdutoMaisCaro then
    begin
      VlrProdutoMaisCaro := QryDetalhe.FieldByName('VLR_BRUTO').AsCurrency;
      Registro := QryDetalhe.GetBookmark;
    end;

    // Impostos
    QryDetalhe.FieldByName('VLR_TOTAL').AsCurrency :=
      QryDetalhe.FieldByName('VLR_BRUTO').AsCurrency -
      QryDetalhe.FieldByName('VLR_DESCONTO').AsCurrency +
      QryDetalhe.FieldByName('VLR_FRETE').AsCurrency;


    AtribuirCstIcmsAndCfo(QryDetalhe, QryCabecalho);

    QryDetalhe.FieldByName('VLR_BASE_ICMS').AsCurrency :=
      QryDetalhe.FieldByName('VLR_TOTAL').AsCurrency *
      QryDetalhe.FieldByName('PER_TRIBUTACAO').AsCurrency / 100;

    QryDetalhe.FieldByName('VLR_ICMS').AsCurrency :=
      RoundABNT(QryDetalhe.FieldByName('VLR_BASE_ICMS').AsCurrency *
      QryDetalhe.FieldByName('PER_ICMS').AsCurrency / 100, 2);

    if (QryDetalhe.FieldByName('CST_ICMS').AsString = '30') or
      (QryDetalhe.FieldByName('CST_ICMS').AsString = '40') or
      (QryDetalhe.FieldByName('CST_ICMS').AsString = '41') or
      (QryDetalhe.FieldByName('CST_ICMS').AsString = '50') or
      (QryDetalhe.FieldByName('CST_ICMS').AsString = '51') or
      (QryDetalhe.FieldByName('CST_ICMS').AsString = '60') or
      (QryDetalhe.FieldByName('CST_ICMS').AsString = '90') then
    begin
      QryDetalhe.FieldByName('PER_ICMS').AsCurrency := 0;
      QryDetalhe.FieldByName('VLR_BASE_ICMS').AsCurrency := 0;
      QryDetalhe.FieldByName('VLR_ICMS').AsCurrency := 0;
    end;



    VlrBasePisCofins := QryDetalhe.FieldByName('VLR_TOTAL').AsCurrency -
      QryDetalhe.FieldByName('VLR_ICMS').AsCurrency;
    QryDetalhe.FieldByName('VLR_PIS').AsCurrency :=
      RoundABNT(VlrBasePisCofins * QryDetalhe.FieldByName('PER_PIS').AsCurrency
      / 100, 2);
    QryDetalhe.FieldByName('VLR_COFINS').AsCurrency :=
      RoundABNT(VlrBasePisCofins * QryDetalhe.FieldByName('PER_COFINS').AsCurrency
      / 100, 2);

    QryDetalhe.Next;
  end;

end;


procedure TModelDmVenda.ObterDadosPadraoParaNovaVenda;
var
  Qry: TZReadOnlyQuery;
  s: string;
begin

  ModelConfiguracaoPdv.CarregarDadosPadrao(TModelSessao.Usuario);

  CodLoja := ModelConfiguracaoPdv.CodLoja;
  CodSerieNF := ModelConfiguracaoPdv.CodSerieNFCe;
  CodVendedor := ModelConfiguracaoPdv.CodVendedor;
  CodHistorico := ModelConfiguracaoPdv.CodHistorico;
  NumCaixa := ModelConfiguracaoPdv.NumCaixa;
  CodTpOperacao := ModelConfiguracaoPdv.CodTpOperacao;
  CodCliente := ModelConfiguracaoPdv.CodCliente;
  CodZonaVenda := ModelConfiguracaoPdv.CodZonaVenda;
  CodTpEstoque := ModelConfiguracaoPdv.CodTpEstoque;
  CodTabelaPreco := ModelConfiguracaoPdv.CodTabelaPreco;
  TipoFrete := ModelConfiguracaoPdv.TipoFrete;
  CodCondicaoPagto := ModelConfiguracaoPdv.CodCondicaoPagto;
  CodTpCobranca := ModelConfiguracaoPdv.CodTpCobranca;
  ViaTransporte := ModelConfiguracaoPdv.ViaTransporte;
  TipoEntrega := ModelConfiguracaoPdv.TipoEntrega;

  // Carregar o CNPJ do Cliente
  Qry := TZReadOnlyQuery.Create(nil);
  Qry.Connection := FModelConexaoFirebird.ConexaoFirebird;
  try
    // Dados do cliente
    s := ' SELECT ';
    s := S + ' S019.CGCCPFCLI, ';
    s := S + ' s019.NOMCLI, ';
    s := S + ' s019.codzonvda, ';
    s := S + ' s019.codtpocob, ';
    s := S + ' s019.codvnd ';
    s := S + ' FROM SINAF019 S019 ';
    s := S + ' LEFT JOIN SINAF554 S554 ON S554.CODMUNIBGE = S019.CODMUNIBGE ';
    S := S + ' WHERE S019.CODCLI = ' + IntToStr(CodCliente);
    Qry.Close;
    Qry.SQL.Text := s;
    Qry.Open;
    FCnpjCpfCliente := Qry.FieldByName('CGCCPFCLI').AsString;
    FNomeCliente := Qry.FieldByName('NOMCLI').AsString;
  finally
    Qry.Free;
  end;

  {1=NF-e normal;2=NF-e complementar;3=NF-e de ajuste;4=Devolução de mercadoria.}
  FFinalidadeNFe := '1';

  {0=Operação sem intermediador (em site ou plataforma própria) 1=Operação em site ou plataforma de terceiros (intermediadores/marketplace)}
  FIndIntermediario := '0';

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

procedure TModelDmVenda.SetCnpjCpfCliente(AValue: string);
begin
  if FCnpjCpfCliente = AValue then Exit;
  FCnpjCpfCliente := AValue;
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

procedure TModelDmVenda.SetCodTabelaPreco(AValue: integer);
begin
  if FCodTabelaPreco = AValue then Exit;
  FCodTabelaPreco := AValue;
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

procedure TModelDmVenda.SetEspecieVolume(AValue: string);
begin
  if FEspecieVolume = AValue then Exit;
  FEspecieVolume := AValue;
end;

procedure TModelDmVenda.SetFinalidadeNFe(AValue: string);
begin
  if FFinalidadeNFe = AValue then Exit;
  FFinalidadeNFe := AValue;
end;

procedure TModelDmVenda.InserirCabecalhoVenda;
begin
  if FID = '' then
  begin
    if QryCabecalho.Active then
      QryCabecalho.Cancel;

    FId := TLibFuncoes.ObterGuid;
    FContador := 1;

    ObterDadosPadraoParaNovaVenda;

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
    QryCabecalho.FieldByName('COD_TP_ESTOQUE').AsInteger := FCodTpEstoque;
    QryCabecalho.FieldByName('COD_TP_OPERACAO').AsString := FCodTpOperacao;
    QryCabecalho.FieldByName('FINALIDADE_NFE').AsString := FFinalidadeNFe;
    QryCabecalho.FieldByName('IND_INTERMEDIARIO').AsString := FIndIntermediario;
    QryCabecalho.FieldByName('USUARIO_INS').AsString := TModelSessao.Usuario;
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

    QryDetalhe.FieldByName('UNIDADE').AsString :=
      pDtSrcProduto.DataSet.FieldByName('codundprd').AsString;

    QryDetalhe.FieldByName('QTDADE').AsCurrency := pQtdade;

    QryDetalhe.FieldByName('VLR_UNITARIO').AsCurrency :=
      pDtSrcProduto.DataSet.FieldByName('VLRBASVDA').AsCurrency;

    QryDetalhe.FieldByName('VLR_BRUTO').AsCurrency :=
      RoundABNT(QryDetalhe.FieldByName('VLR_UNITARIO').AsCurrency *
      QryDetalhe.FieldByName('QTDADE').AsCurrency, 2);

    QryDetalhe.FieldByName('PER_DECONTO').AsCurrency := 0;

    QryDetalhe.FieldByName('VLR_TOTAL').AsCurrency :=
      RoundABNT(QryDetalhe.FieldByName('QTDADE').AsCurrency *
      QryDetalhe.FieldByName('VLR_UNITARIO').AsCurrency, 2);

    // NCM E Cest
    QryDetalhe.FieldByName('NCM').AsString :=
      pDtSrcProduto.DataSet.FieldByName('NCM').AsString;

    QryDetalhe.FieldByName('CEST').AsString :=
      pDtSrcProduto.DataSet.FieldByName('CEST').AsString;

    QryDetalhe.FieldByName('COD_PROCEDENCIA').AsString :=
      pDtSrcProduto.DataSet.FieldByName('CODPRC').AsString;

    // Impostos ICMS
    if ModelConfiguracaoPdv.RegimeTributacao = '3' then  // Normal
    begin
      QryDetalhe.FieldByName('CST_ICMS').AsString :=
        pDtSrcProduto.DataSet.FieldByName('CODTPOTRB').AsString;
      QryDetalhe.FieldByName('CST_SIMPLES').AsString := '';
      QryDetalhe.FieldByName('PER_ICMS').AsString :=
        pDtSrcProduto.DataSet.FieldByName('PER_ICMS').AsString;

    end
    else
    begin
      QryDetalhe.FieldByName('CST_ICMS').AsString := '';

      if ModelConfiguracaoPdv.ClienteContribuinte then
        QryDetalhe.FieldByName('CST_SIMPLES').AsString :=
          pDtSrcProduto.DataSet.FieldByName('codtpotrbsimples').AsString
      else
        QryDetalhe.FieldByName('CST_SIMPLES').AsString :=
          pDtSrcProduto.DataSet.FieldByName('codcodtpotrbsimplesnaocontr').AsString;

      QryDetalhe.FieldByName('PER_SIMPLES').AsCurrency :=
        ModelConfiguracaoPdv.PerSimples;
    end;

    // Pis e Cofins
    QryDetalhe.FieldByName('PER_PIS').AsCurrency :=
      pDtSrcProduto.DataSet.FieldByName('peralipisnfe').AsCurrency;
    QryDetalhe.FieldByName('PER_COFINS').AsCurrency :=
      pDtSrcProduto.DataSet.FieldByName('peralicofinsnfe').AsCurrency;
    QryDetalhe.FieldByName('CST_PIS_COFINS').AsString :=
      pDtSrcProduto.DataSet.FieldByName('codtpopis').AsString;

    QryDetalhe.FieldByName('STS_CFO').AsString := ModelConfiguracaoPdv.StsCfo;

    // Vendedor
    QryDetalhe.FieldByName('COD_VENDEDOR').AsString := ModelConfiguracaoPdv.CodVendedor;

    QryDetalhe.Post;

    QryCabecalho.FieldByName('VLR_NF').AsCurrency :=
      QryCabecalho.FieldByName('VLR_NF').AsCurrency +
      QryDetalhe.FieldByName('VLR_TOTAL').AsCurrency;

    QryCabecalho.FieldByName('VLR_PRODUTOS').AsCurrency :=
      QryCabecalho.FieldByName('VLR_PRODUTOS').AsCurrency +
      QryDetalhe.FieldByName('VLR_BRUTO').AsCurrency;


    QryCabecalho.FieldByName('VLR_TOTAL_RECEBER').AsCurrency :=
      QryCabecalho.FieldByName('VLR_TOTAL_RECEBER').AsCurrency +
      QryDetalhe.FieldByName('VLR_TOTAL').AsCurrency;

    Inc(FContador);
  end;

end;

procedure TModelDmVenda.InserirFormaPagto(pFormaPagto: string;
  pVlrPagto: currency; pNomeBandeira, pNumAutorizacao, pDoc001, pDoc002: string);
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
    QryFormaPagto.FieldByName('DOC001').AsString := pDoc001;
    QryFormaPagto.FieldByName('DOC001').AsString := pDoc002;

    if UpperCase(QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString) =
      'DINHEIRO' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '01'

    else if UpperCase(QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString) =
      'CHEQUE' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '02'

    else if UpperCase(QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString) =
      'CRÉDITO' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '03'

    else if UpperCase(QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString) =
      'TEF CRÉDITO' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '03'

    else if UpperCase(QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString) =
      'DÉBITO' then
      QryFormaPagto.FieldByName('COD_FORMA_PAGTO').AsString := '04'

    else if UpperCase(QryFormaPagto.FieldByName('DESCRICAO_FORMA_PAGTO').AsString) =
      'TEF DÉBITO' then
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
