unit model_nfe;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ACBrNFe, ZDataset, ACBrNFeDANFeRLClass,
  ACBrNFeDANFeESCPOS, pcnConversao, AcbrUtil,
  ACBrDFeSSL, ACBrValidador, blcksock, pcnConversaoNFe, lib_funcoes,
  model_configuracao_pdv,
  model_conexao_firebird;

type

  { TModelNFe }

  TModelNFe = class(TDataModule)
    ACBrNFe: TACBrNFe;
    ACBrNFeDANFeESCPOS: TACBrNFeDANFeESCPOS;
    ACBrNFeDANFeRL: TACBrNFeDANFeRL;
    ACBrValidador: TACBrValidador;
    ZQuery1: TZQuery;
  private
    FIndProd: integer;
    FModelConexaoFirebird: TModelConexaoFirebird;
    FQryCabecalho: TZQuery;
    FQryDetalhe: TZQuery;
    FQryFormaPagto: TZQuery;
    procedure SetIndProd(AValue: integer);
    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
    procedure SetQryCabecalho(AValue: TZQuery);
    procedure SetQryDetalhe(AValue: TZQuery);
    procedure SetQryFormaPagto(AValue: TZQuery);

    procedure ConfigurarACBRNFe;
    function obterDestinoOperacao(pCfo: string): TpcnDestinoOperacao;
    function ObterCodigoBarra(pCodigoBarra: string): string;

    procedure GerarXMLInfNFe;
    procedure GerarXMLIde;
    procedure GerarXMLContingencia;
    procedure GerarXMLDocumentoReferenciado;
    procedure GerarXMLEmitente;
    procedure gerarXMLDestinatario;
    procedure gerarXMLRetirada;
    procedure gerarXMLentrega;
    procedure gerarXMLDetalhe;
    procedure gerarXMLProduto;

    procedure GerarXMLCombustivel;

    procedure GerarXMLICM;
    procedure GerarXMLSimples;
    procedure GerarXMLPis;
    procedure GerarXMLCofins;
    procedure GerarXMLDifal;




  public

    property QryCabecalho: TZQuery read FQryCabecalho write SetQryCabecalho;
    property QryDetalhe: TZQuery read FQryDetalhe write SetQryDetalhe;
    property QryFormaPagto: TZQuery read FQryFormaPagto write SetQryFormaPagto;

    property ModelConexaoFirebird: TModelConexaoFirebird
      read FModelConexaoFirebird write SetModelConexaoFirebird;
    property IndProd: integer read FIndProd write SetIndProd;

  end;

var
  ModelNFe: TModelNFe;

implementation

{$R *.lfm}

{ TModelNFe }

procedure TModelNFe.SetQryCabecalho(AValue: TZQuery);
begin
  if FQryCabecalho = AValue then Exit;
  FQryCabecalho := AValue;
end;

procedure TModelNFe.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird = AValue then Exit;
  FModelConexaoFirebird := AValue;
end;

procedure TModelNFe.SetIndProd(AValue: integer);
begin
  if FIndProd = AValue then Exit;
  FIndProd := AValue;
end;

procedure TModelNFe.SetQryDetalhe(AValue: TZQuery);
begin
  if FQryDetalhe = AValue then Exit;
  FQryDetalhe := AValue;
end;

procedure TModelNFe.SetQryFormaPagto(AValue: TZQuery);
begin
  if FQryFormaPagto = AValue then Exit;
  FQryFormaPagto := AValue;
end;

procedure TModelNFe.ConfigurarACBRNFe;
var
  ok: boolean;
begin

  // Certificado
  ACBRNFe.Configuracoes.Certificados.ArquivoPFX :=
    ExtractFilePath(ParamStr(0)) + TLibFuncoes.OnlyNumber(
    QryCabecalho.FieldByName('CNPJ_CPF_EMITENTE').AsString) + '.pfx';
  ACBRNFe.Configuracoes.Certificados.Senha :=
    ModelConfiguracaoPdv.SenhaCertificadoDigital;
  ACBrNFe.Configuracoes.Geral.SSLXmlSignLib := xsLibXml2;

  if QryCabecalho.FieldByName('STS_TIPO_BIBLIOTECA').AsString = 'S' then
  begin
    ACBrNFe.Configuracoes.Geral.SSLLib := libOpenSSL;
    ACBrNFe.Configuracoes.Geral.SSLCryptLib := cryOpenSSL;
    ACBrNFe.Configuracoes.Geral.SSLHttpLib := httpOpenSSL;

  end
  else if QryCabecalho.FieldByName('STS_TIPO_BIBLIOTECA').AsString = 'N' then
  begin
    ACBrNFe.Configuracoes.Geral.SSLLib := libWinCrypt;
    ACBrNFe.Configuracoes.Geral.SSLCryptLib := cryWinCrypt;
    ACBrNFe.Configuracoes.Geral.SSLHttpLib := httpWinHttp;
  end;

  ACBrNFe.Configuracoes.Geral.ExibirErroSchema := True;
  ACBrNFe.Configuracoes.Geral.RetirarAcentos := True;
  ACBrNFe.Configuracoes.Geral.CSC := QryCabecalho.FieldByName('TOKEN_NFE').AsString;
  ACBrNFe.Configuracoes.Geral.IdCSC :=
    QryCabecalho.FieldByName('ID_TOKEN_NFE').AsString;
  ACBrNFe.Configuracoes.Geral.FormatoAlerta :=
    'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.';

  ACBRNfe.SSL.SSLType := LT_all;

  // TimeOut
  ACBRNfe.Configuracoes.WebServices.TimeOut := 60000;


  // Ambiente
  if StrToTpAmb(Ok, QryCabecalho.FieldByName('TP_AMBIENTE').AsString) =
    taHomologacao then
    ACBRNfe.Configuracoes.WebServices.Ambiente := taHomologacao
  else
    ACBRNfe.Configuracoes.WebServices.Ambiente := taProducao;

  ACBRNfe.Configuracoes.WebServices.UF :=
    QryCabecalho.FieldByName('UFD_EMITENTE').AsString;
  ACBRNfe.Configuracoes.WebServices.TimeOut := 60000;

  if FileExists(ExtractFilePath(ParamStr(0)) + 'ImagemLogoNfe.bmp') then
    ACBrNFeDANFeRL.Logo := ExtractFilePath(ParamStr(0)) + 'ImagemLogoNfe.bmp';
end;

function TModelNFe.obterDestinoOperacao(pCfo: string): TpcnDestinoOperacao;
var
  s: string;
begin
  s := Copy(pCfo, 1, 1);

  if (s = '1') or (s = '5') then
    Result := doInterna;

  if (s = '2') or (s = '6') then
    Result := doInterestadual;

  if (s = '3') or (s = '7') then
    Result := doExterior;
end;

function TModelNFe.ObterCodigoBarra(pCodigoBarra: string): string;
begin
  Result := 'SEM GTIN';
  if QryDetalhe.FieldByName('STS_IMPRIMIR_COD_BARRA').AsString = 'N' then
    exit;
  Result := TLibFuncoes.OnlyNumber(QryDetalhe.FieldByName('CODBAR').AsString);

  ACBrValidador.Documento := Result;
  if not ACBrValidador.Validar then
    Result := 'SEM GTIN';

  if Result = '' then
    Result := 'SEM GTIN';

end;

procedure TModelNFe.GerarXMLInfNFe;
begin
  ACbrNFe.NotasFiscais.Items[0].NFe.infNFe.Versao := 4.00;
  ACbrNFe.Configuracoes.Geral.VersaoDF := ve400;
end;

procedure TModelNFe.GerarXMLIde;
var
  Hora: string;
  ok: boolean;
begin

  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.cUF :=
    UFtoCUF(QryCabecalho.FieldByName('UFD_EMITENTE').AsString);
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.cNF :=
    QryCabecalho.FieldByName('COD_NUMERICO').AsInteger;
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.natOp :=
    UpperCase(QryCabecalho.FieldByName('NAT_OPERACAO').AsString);
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo :=
    QryCabecalho.FieldByName('MODELO_FISCAL').AsInteger;
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.serie :=
    StrToInt(QryCabecalho.FieldByName('NUM_SERIE').AsString);
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.nNF :=
    QryCabecalho.FieldByName('NUM_NF').AsInteger;
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.dEmi :=
    QryCabecalho.FieldByName('DT_EMISSAO').AsDateTime;

  // NFCe não informa o campo Dt Hr Saida
  if AcbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo <> 65 then
  begin
    AcbrNFe.NotasFiscais.Items[0].NFe.Ide.dSaiEnt :=
      QryCabecalho.FieldByName('DT_SAIDA').AsDateTime;
    AcbrNFe.NotasFiscais.Items[0].NFe.Ide.indFinal := cfConsumidorFinal;
    AcbrNFe.NotasFiscais.Items[0].NFe.Ide.indPres := pcPresencial;
    AcbrNFe.Configuracoes.Geral.ModeloDF := moNFCe;
    AcbrNFe.NotasFiscais.Items[0].NFe.ide.tpImp := tiNFCe;
  end
  else
  begin
    AcbrNFe.Configuracoes.Geral.ModeloDF := moNFe;
    AcbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo := 55;
    AcbrNFe.NotasFiscais.Items[0].NFe.ide.tpImp :=
      StrToTpImp(ok, QryCabecalho.FieldByName('TP_IMPRESSAO').AsString);
    AcbrNFe.NotasFiscais.Items[0].NFe.Ide.indFinal := cfNao;

    if QryCabecalho.FieldByName('STS_CONSUMIDOR_FINAL').AsString = 'S' then
      AcbrNFe.NotasFiscais.Items[0].NFe.Ide.indFinal := cfConsumidorFinal;
  end;

  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.tpNF :=
    StrToTpNF(Ok, QryCabecalho.FieldByName('TP_OPERACAO').AsString);

  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.tpEmis :=
    StrToTpEmis(Ok, QryCabecalho.FieldByName('TP_EMISSAO').AsString);
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.tpAmb :=
    StrToTpAmb(Ok, QryCabecalho.FieldByName('TP_AMBIENTE').AsString);
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.finNFe :=
    StrToFinNFe(Ok, QryCabecalho.FieldByName('STS_FINALIDADE_NFE').AsString);

  if QryCabecalho.FieldByName('STS_PRESENCA').AsString = 'S' then
    AcbrNFe.NotasFiscais.Items[0].NFe.Ide.indPres := pcPresencial
  else
    AcbrNFe.NotasFiscais.Items[0].NFe.Ide.indPres := pcOutros;

  if (AcbrNFe.NotasFiscais.Items[0].NFe.Ide.finNFe = fnComplementar) or
    (AcbrNFe.NotasFiscais.Items[0].NFe.Ide.finNFe = fnAjuste) then
    AcbrNFe.NotasFiscais.Items[0].NFe.Ide.indPres := pcNao;


  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.indIntermed := iiOperacaoSemIntermediador;
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.verProc := '2.0.5';
  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.procEmi := peAplicativoContribuinte;

  AcbrNFe.NotasFiscais.Items[0].NFe.Ide.idDest :=
    obterDestinoOperacao(QryDetalhe.FieldByName('CFO').AsString);

end;

procedure TModelNFe.GerarXMLContingencia;
var
  Qry: TZReadOnlyQuery;
  s: string;
  s1: TAnsiStringBuilder;
begin
  Qry := TZReadOnlyQuery.Create(self);
  Qry.Connection := ModelConexaoFirebird.ConexaoFirebird;
  try
    s1.Append(' select s018c.modfsc, ').
      Append(' s018c.motcgn, ').
      Append(' s018c.dtahrainccgn, ').
      Append(' s018c.dtahrafincgn, ').
      Append(' s018c.statpocgn ').
      Append(' from sinaf018c s018c ').
      Append(' where s018c.empgrp = :pEmpresa ').
      Append(' and s018c.codlja = :pCodLoja ').
      Append(' and s018c.modfsc = :pModeloFiscal ');
    Qry.SQL.Text := S1.ToString;
    Qry.Open;

    if Qry.IsEmpty then Exit;

    if Qry.FieldByName('dtahrafincgn').IsNull then
    begin
      AcbrNFe.NotasFiscais.Items[0].NFe.Ide.dhCont :=
        Qry.FieldByName('dtahrainccgn').AsDateTime;
      AcbrNFe.NotasFiscais.Items[0].NFe.Ide.xJust := Qry.FieldByName('motcgn').AsString;
    end;
  finally
    Qry.Free;
  end;
end;

procedure TModelNFe.GerarXMLDocumentoReferenciado;
begin
  // Implementar
end;

procedure TModelNFe.GerarXMLEmitente;

var
  s, cep: string;
  Ok: boolean;
begin

  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.CNPJCPF :=
    TLibFuncoes.OnlyNumber(QryCabecalho.FieldByName('CNPJ_CPF_EMITENTE').AsString);
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.IE :=
    TLibFuncoes.OnlyNumber(QryCabecalho.FieldByName('INSC_ESTADUAL_EMITENTE').AsString);
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.xNome :=
    QryCabecalho.FieldByName('NOME_EMITENTE').AsString;
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.xFant :=
    QryCabecalho.FieldByName('NOME_FANTASIA_EMITENTE').AsString;
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.fone :=
    QryCabecalho.FieldByName('TELEFONE_EMITENTE').AsString;

  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.CEP :=
    StrToIntDef(TLibFuncoes.OnlyNumber(QryCabecalho.FieldByName(
    'CEP_EMITENTE').AsString), 0);

  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.xLgr :=
    QryCabecalho.FieldByName('LOGRADOURO_EMITENTE').AsString;
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.nro :=
    QryCabecalho.FieldByName('NRO_EMITENTE').AsString;
  if AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.nro = '' then
    AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.nro := 'SN';

  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.xBairro :=
    QryCabecalho.FieldByName('BAIRRO_EMITENTE').AsString;
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.cMun :=
    QryCabecalho.FieldByName('COD_MUNICIPIO_EMITENTE').AsInteger;
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.xMun :=
    QryCabecalho.FieldByName('MUNICIPIO_EMITENTE').AsString;
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.EnderEmit.UF :=
    QryCabecalho.FieldByName('UFD_EMITENTE').AsString;
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.enderEmit.cPais :=
    QryCabecalho.FieldByName('COD_PAIS_EMITENTE').AsInteger;
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.enderEmit.xPais :=
    QryCabecalho.FieldByName('NOME_PAIS_EMITENTE').AsString;

  if QryCabecalho.FieldByName('CNAE_EMITENTE').AsString <> '' then
    AcbrNFe.NotasFiscais.Items[0].NFe.Emit.CNAE :=
      QryCabecalho.FieldByName('CNAE_EMITENTE').AsString;

  // Tipo do Regime Tributario
  AcbrNFe.NotasFiscais.Items[0].NFe.Emit.CRT :=
    StrToCRT(ok, QryCabecalho.FieldByName('REGIME_TRIBUTARIO').AsString);

end;

procedure TModelNFe.gerarXMLDestinatario;
var
  CEP: string;
  s, cnpjCpf: string;
  QryContador: TZReadOnlyQuery;
begin

  if ACBRNfe.Configuracoes.WebServices.Ambiente = taProducao then
  begin
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.IE :=
      TLibFuncoes.OnlyNumber(QryCabecalho.FieldByName('INSC_ESTADUAL_CLIENTE').AsString);
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.xNome :=
      QryCabecalho.FieldByName('NOME_CLIENTE').AsString;
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.CNPJCPF :=
      TLibFuncoes.OnlyNumber(QryCabecalho.FieldByName('CNPJ_CPF_CLIENTE').AsString);
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.ISUF :=
      QryCabecalho.FieldByName('SUFRAMA').AsString;

    if AcbrNFe.NotasFiscais.Items[0].NFe.Dest.IE = 'ISENTO' then
    begin
      AcbrNFe.NotasFiscais.Items[0].NFe.Dest.IE := '';
      AcbrNFe.NotasFiscais.Items[0].NFe.Dest.indIEDest := inIsento;
    end;

    if (QryCabecalho.FieldByName('STS_CONTRIBUINTE').AsString = 'S') then
    begin
      AcbrNFe.NotasFiscais.Items[0].NFe.Dest.indIEDest := inContribuinte;
    end
    else if (QryCabecalho.FieldByName('STS_CONTRIBUINTE').AsString = 'N') then
    begin
      AcbrNFe.NotasFiscais.Items[0].NFe.Dest.indIEDest := inNaoContribuinte;
      AcbrNFe.NotasFiscais.Items[0].NFe.Dest.IE := '';
    end;
  end;

  if AcbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo = 65 then
  begin
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.indIEDest := inNaoContribuinte;
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.IE := '';
  end;

  if (QryCabecalho.FieldByName('STATPOAMB').AsString = 'H') and
    (AcbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo <> 65) then
  begin
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.CNPJCPF := '99999999000191';
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.xNome :=
      'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO – SEM VALOR FISCAL';
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.IE := '';
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.indIEDest := inNaoContribuinte;
  end;

  AcbrNFe.NotasFiscais.Items[0].NFe.Dest.Email :=
    QryCabecalho.FieldByName('EMAIL_CLIENTE').AsString;

  // Atuorizar DUOTEC
  if TLibFuncoes.OnlyNumber(QryCabecalho.FieldByName('CNPJ_CPF_CLIENTE').AsString) <>
    '18379851000152' then
    AcbrNFe.NotasFiscais.Items[0].NFe.autXML.Add.CNPJCPF := '18379851000152';

  QryContador := TZReadOnlyQuery.Create(Self);
  s := ' SELECT FIRST 1 S858.CGCCTB, S858.CPFCTB, S858.EMAILCTB FROM SINAF858 S858 ';
  try
    QryContador.Connection := ModelConexaoFirebird.ConexaoFirebird;
    QryContador.SQL.Text := s;
    QryContador.Open;

    AcbrNFe.NotasFiscais.Items[0].NFe.autXML.Add.CNPJCPF :=
      TLibFuncoes.OnlyNumber(QryContador.FieldByName('CPFCTB').AsString);

    if AcbrNFe.NotasFiscais.Items[0].NFe.autXML.Add.CNPJCPF = '' then
      AcbrNFe.NotasFiscais.Items[0].NFe.autXML.Add.CNPJCPF :=
        TLibFuncoes.OnlyNumber(QryContador.FieldByName('CGCCTB').AsString);

  finally
    QryContador.Free;
  end;

  AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.Fone :=
    TLibFuncoes.OnlyNumber(QryCabecalho.FieldByName('TELEFONE_CLIENTE').AsString);
  if Length(AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.Fone) < 8 then
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.Fone := '';

  CEP := TLibFuncoes.OnlyNumber(QryCabecalho.FieldByName('CEPCLI').AsString) +
    '00000000';
  try
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.CEP := StrToInt(Copy(Cep, 1, 8));
  except
  end;

  AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xLgr :=
    QryCabecalho.FieldByName('LOGRADOURO_CLIENTE').AsString;
  if Length(AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xLgr) <= 2 then
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xLgr := 'SEM ENDERECO';

  AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.nro :=
    QryCabecalho.FieldByName('NRO_CLIENTE').AsString;
  if Length(AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.nro) <= 2 then
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.nro := 'S/N';


  AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xBairro :=
    QryCabecalho.FieldByName('BAIRRO_CLIENTE').AsString;
  if Length(AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xBairro) <= 2 then
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xBairro := 'SEM BAIRRO';

  AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xCpl :=
    QryCabecalho.FieldByName('COMPLEMENTO_CLIENTE').AsString;


  // Venda para o Exterior
  if QryCabecalho.FieldByName('CODPAISIBGE').AsInteger <> 1058 {Brasil} then
  begin
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.CNPJCPF := '';
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.cMun := 9999999;
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xMun := 'EXTERIOR';
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.UF := 'EX';
  end
  else
  begin
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.cMun :=
      QryCabecalho.FieldByName('COD_MUNICIPIO_CLIENTE').AsInteger;
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xMun :=
      QryCabecalho.FieldByName('MUNICIPIO_CLIENTE').AsString;
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.UF :=
      QryCabecalho.FieldByName('UFD_CLIENTE').AsString;
  end;

  AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.cPais :=
    QryCabecalho.FieldByName('COD_PAIS_CLIENTE').AsInteger;
  AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xPais :=
    QryCabecalho.FieldByName('NOME_PAIS_CLIENTE').AsString;

  if (Pos('CONSUMIDOR', AcbrNFe.NotasFiscais.Items[0].NFe.Dest.xNome) > 0) and
    (AcbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo = 65) then
  begin
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.xNome := 'CONSUMIDOR NAO IDENTIFICADO';
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xLgr := '';
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.nro := '';
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xCpl := '';
    AcbrNFe.NotasFiscais.Items[0].NFe.Dest.EnderDest.xBairro := '';
  end;
end;

procedure TModelNFe.gerarXMLRetirada;
begin
  // implementar Depois

end;

procedure TModelNFe.gerarXMLentrega;
begin
  // implementar Depois

end;

procedure TModelNFe.gerarXMLDetalhe;
begin
  //Adicionando Produtos
  FIndProd := 0;

  while not QryDetalhe.EOF do
  begin
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Add;
    GerarXMLProduto;
    Inc(FIndProd);
    QryDetalhe.Next;
  end;

end;

procedure TModelNFe.gerarXMLProduto;
var
  Codigo: string;
  s: string;
  LVlr: currency;
begin

  Codigo := QryDetalhe.FieldByName('CODPRD').AsString;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.nItem :=
    FIndProd + 1;

  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.cProd := Codigo;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.cBarra :=
    QryDetalhe.FieldByName('CODBAR').AsString;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.cBarraTrib :=
    QryDetalhe.FieldByName('CODBAR').AsString;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.cEAN :=
    obterCodigoBarra(QryDetalhe.FieldByName('CODBAR').AsString);
  if ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.cEAN <> '' then
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.cEANTrib :=
      ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.cEAN;


  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.cBenef :=
    QryDetalhe.FieldByName('CODBEN').AsString;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.xProd :=
    QryDetalhe.FieldByName('DCRPRD').AsString;

  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.comb.UFcons := 'MT';

  if (ACbrNFe.NotasFiscais.Items[0].NFe.Ide.tpAmb = taHomologacao) and
    (ACbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo = 65) and
    (ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.nItem = 1) then
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.xProd :=
      'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO – SEM VALOR FISCAL';

  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.NCM :=
    TLibFuncoes.OnlyNumber(QryDetalhe.FieldByName('NCM').AsString);

  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.EXTIPI :=
    QryDetalhe.FieldByName('EX_TIPI').AsString;
  if Length(ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.EXTIPI) =
    1 then
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.EXTIPI := '';

  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.CFOP :=
    QryDetalhe.FieldByName('CFO').AsString;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.uCom :=
    QryDetalhe.FieldByName('UNIDADE').AsString;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.uTrib :=
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.uCom;

  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.qCom :=
    QryDetalhe.FieldByName('QTDADE').AsCurrency;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.qTrib :=
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.qCom;

  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.vProd :=
    QryDetalhe.FieldByName('VLR_BRUTO').AsCurrency;
  try
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.vUnCom :=
      RoundABNT(QryDetalhe.FieldByName('VLR_BRUTO').AsCurrency /
      QryDetalhe.FieldByName('QTDADE').AsCurrency, 2);
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.vUnTrib :=
      ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.vUnCom;
  except
    on e: Exception do
    begin
    end;
  end;


  if (AcbrNFe.NotasFiscais.Items[0].NFe.Ide.finNFe = fnComplementar) or
    (AcbrNFe.NotasFiscais.Items[0].NFe.Ide.finNFe = fnAjuste) then
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.IndTot :=
      itNaoSomaTotalNFe
  else
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.IndTot :=
      itSomaTotalNFe;



  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.vFrete :=
    QryDetalhe.FieldByName('VLR_FRETE').AsCurrency;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.vSeg :=
    QryDetalhe.FieldByName('VLR_SEGURO').AsCurrency;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.vOutro :=
    QryDetalhe.FieldByName('VLR_OUTRA_DESPESA').AsCurrency;
  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.vDesc :=
    QryDetalhe.FieldByName('VLR_DESCONTO').AsCurrency;

  ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd :=
    QryDetalhe.FieldByName('OBS_PRODUTO').AsString;
  if (QryDetalhe.FieldByName('FCI').AsString <> '') then
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd :=
      ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd +
      ' Resolução do Senado Federal nro 13/12 ' + #13#10 +
      'Nro. da FCI : ' + QryDetalhe.FieldByName('FCI').AsString;


  if (QryDetalhe.FieldByName('NUMPEDCLI').AsString <> '') then
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.xPed :=
      QryDetalhe.FieldByName('NUM_PEDIDO_CLIENTE').AsString;


  if (QryDetalhe.FieldByName('NUMORDPEDCLI').AsInteger > 0) then
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.nItemPed :=
      QryDetalhe.FieldByName('NUM_ORDEM_PEDIDO_CLIENTE').AsString;

  if AcbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo <> 65 then
  begin
    if (QryDetalhe.FieldByName('STS_CFO').AsString = 'V') then
    begin
      ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd :=
        ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd +
        ' ** Vlr.Aproximado Imp.Federal: R$ ' +
        FormatFloat('###,###,##0.00', QryDetalhe.FieldByName(
        'VLR_IMPOSTO_FEDERAL').AsCurrency);
      ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd :=
        ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd +
        ' ** / Imp.Estadual: R$ ' + FormatFloat(
        '###,###,##0.00', QryDetalhe.FieldByName('VLR_IMPOSTO_ESTADUAL').AsCurrency);
      ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd :=
        ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd +
        ' ** / Imp.Municipal: R$ ' + FormatFloat('###,###,##0.00',
        QryDetalhe.FieldByName('VLR_IMPOSTO_ESTADUAL').AsCurrency);
    end;
  end;

  if ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd <> '' then
    ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd :=
      '[' + ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].infAdProd + ']';

  if (QryDetalhe.FieldByName('FCI').AsString <> '') then
  begin
    if (QryDetalhe.FieldByName('COD_PROCEDENCIA').AsString = '3') or
      (QryDetalhe.FieldByName('COD_PROCEDENCIA').AsString = '5') or
      (QryDetalhe.FieldByName('COD_PROCEDENCIA').AsString = '8') then
      ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.nFCI :=
        QryDetalhe.FieldByName('FCI').AsString;
  end;

  GerarXMLCombustivel;

  if AcbrNFe.NotasFiscais.Items[0].NFe.Emit.CRT = crtRegimeNormal then
  begin
    GerarXMLICM;
  end
  else
  begin
    GerarXMLSimples;
  end;

  GerarXMLPis;
  GerarXMLCofins;
  GerarXMLDifal;
end;

procedure TModelNFe.GerarXMLCombustivel;
begin

end;

procedure TModelNFe.GerarXMLICM;
var
  Ok: boolean;
  s: string;
  perReducao: currency;
  Cest: string;

begin

  PerReducao := (100 - QryDetalhe.FieldByName('PER_TRIBUTACAO').AsCurrency);

  Cest := TLibFuncoes.OnlyNumber(QryDetalhe.FieldByName('CEST').AsString);
  if length(Cest) = 7 then
    Cest := '0000000';
  with ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Imposto do
  begin
    if (QryDetalhe.FieldByName('STS_CFO').AsString = 'V') then
    begin
      vTotTrib := QryDetalhe.FieldByName('VLR_IMPOSTO_FEDERAL').AsCurrency +
        QryDetalhe.FieldByName('VLR_IMPOSTO_ESTADUAL').AsCurrency +
        QryDetalhe.FieldByName('VLR_IMPOSTO_MUNICIPAL').AsCurrency;
    end;

    ICMS.CST := StrToCSTICMS(ok, QryDetalhe.FieldByName('CST_ICMS').AsString);
    ICMS.orig := StrToOrig(ok, QryDetalhe.FieldByName('COD_PROCEDENCIA').AsString);
    ICMS.modBC := StrTomodBC(ok, QryDetalhe.FieldByName(
      'MODALIDADE_BASE_ICMS').AsString);
    ICMS.vBC := QryDetalhe.FieldByName('VLR_BASE_ICMS').AsCurrency;
    ICMS.pICMS := QryDetalhe.FieldByName('PER_ICMS').AsCurrency;
    ICMS.vICMS := QryDetalhe.FieldByName('VLR_ICMS').AsCurrency;

    // Atribuir CEST
    if (ICMS.CST = cst10) or (ICMS.CST = cst30) or (ICMS.CST = cst60) or
      (ICMS.CST = cst70) then
      ACbrNFe.NotasFiscais.Items[0].NFe.Det.Items[FIndProd].Prod.CEST := Cest;

      // Valores com ST
    if (ICMS.CST = cst10) or (ICMS.CST = cst30) or (ICMS.CST = cst70) or
      (ICMS.CST = cst90) then
    begin

      ICMS.modBCST := StrTomodBCST(Ok, QryDetalhe.FieldByName(
        'MODALIDADE_BASE_ICMS_ST').AsString);

      ICMS.pMVAST := QryDetalhe.FieldByName('PER_MVA').AsCurrency;

      ICMS.vBCST := QryDetalhe.FieldByName('VLR_BASE_ICMS_ST').AsCurrency;

      ICMS.pICMSST := QryDetalhe.FieldByName('PER_ICMS').AsCurrency;

      ICMS.vICMSST := QryDetalhe.FieldByName('VLR_ICMS_ST').AsCurrency;
    end;

    // Reducao de Base ICMS Tributada
    if (ICMS.CST = cst20) or (ICMS.CST = cst70) or (ICMS.CST = cst90) then
    begin
      ICMS.pRedBCST := PerReducao;
    end;

    // Diferido
    if (ICMS.CST = cst51) then
    begin
      ICMS.vICMSOp := 0;
      ICMS.pDif := 0;
      ICMS.vICMSDif := 0;
    end;
  end;

end;

procedure TModelNFe.GerarXMLSimples;
begin

end;

procedure TModelNFe.GerarXMLPis;
begin

end;

procedure TModelNFe.GerarXMLCofins;
begin

end;

procedure TModelNFe.GerarXMLDifal;
begin

end;


end.
