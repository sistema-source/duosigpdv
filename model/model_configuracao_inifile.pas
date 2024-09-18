unit model_configuracao_inifile;

{$mode ObjFPC}{$H+}

interface

uses SysUtils, iniFiles;

type

  TAplicacaoIniFile = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    function ObterInformacoes(pArqIni: TIniFile): TIniFile;
    function GravarInformacoes(pArqIni: TIniFile): TIniFile;
  end;

  { TDatabaseIniFile }

  TDatabaseIniFile = class
  private
    FBanco_Dados: string;
    FSenha: string;
    FServidor: string;
    FUsuario_Banco: string;
    procedure SetBanco_Dados(AValue: string);
    procedure SetSenha(AValue: string);
    procedure SetServidor(AValue: string);
    procedure SetUsuario_Banco(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;

    function ObterInformacoes(pArqIni: TIniFile): TIniFile;
    function GravarInformacoes(pArqIni: TIniFile): TIniFile;

    property Banco_Dados: string read FBanco_Dados write SetBanco_Dados;
    property Usuario_Banco: string read FUsuario_Banco write SetUsuario_Banco;
    property Senha: string read FSenha write SetSenha;
    property Servidor: string read FServidor write SetServidor;
  end;

  TConfiguracaoMonitorDuosigIniFile = class
  private
    FEnviar_Email_Retorno: string;
    FImprimir_Per_Desconto: string;
    FEmitir_Nota_Fiscal_Eletronica: string;
    FImprimir_Percentual_Desconto: string;
    FMostrar_Forma_Pagamento: string;
    FUsar_Autenticacao: string;
    FMostrar_Nome_Vendedor: string;
    FEnviar_NFe_NFEc_para_a_SEFAZ: string;
    FEmitir_Nota_Fiscal_Consumidor_Eletronica: string;
    FColocar_Unidade_Tres_Caracteres: string;
    FNomeEmpresa: string;
    FDataEmpresa: string;
    FQtd_Casas_Decimais_Valor_Produto: string;
    FImprimir_Desconto_Fatura: string;
    FEnviar_Boleto_Com_NFe: string;
    FQtd_Casas_Decimais_Qtdade_Produto: string;
    FImprimir_Valor_Liquido: string;
    FEnviar_NFe_NFEc_Normal: string;
    FLargura_Bobina: string;
    FMargem_Superior: string;
    FMargem_Inferior: string;
    FMargem_Esquerda: string;
    FMargem_Direita: string;
    FPonto_de_Captura: string;
    FPonto_de_Captura_Emissao_NF: string;
    FPastaArquivo_Req_Tef: string;
    FPastaArquivo_Resp_Tef: string;
    FNumero_Certificado_Duotec_PayGo: string;
    FPastaArquivo_Sts_Tef: string;
    FPastaArquivo_Temp_Tef: string;
    FTipoTefDebito: string;
    FTipoTefPix: string;
    FTipoTefCredito: string;
    FNomeRedeTefDebito: string;
    FNomeRedeTefPix: string;
    FNomeRedeTefCredito: string;
    procedure SetColocar_Unidade_Tres_Caracteres(const Value: string);
    procedure SetDataEmpresa(const Value: string);
    procedure SetEmitir_Nota_Fiscal_Consumidor_Eletronica(const Value: string);
    procedure SetEmitir_Nota_Fiscal_Eletronica(const Value: string);
    procedure SetEnviar_Boleto_Com_NFe(const Value: string);
    procedure SetEnviar_Email_Retorno(const Value: string);
    procedure SetEnviar_NFe_NFEc_Normal(const Value: string);
    procedure SetEnviar_NFe_NFEc_para_a_SEFAZ(const Value: string);
    procedure SetImprimir_Desconto_Fatura(const Value: string);
    procedure SetImprimir_Per_Desconto(const Value: string);
    procedure SetImprimir_Percentual_Desconto(const Value: string);
    procedure SetImprimir_Valor_Liquido(const Value: string);
    procedure SetMostrar_Forma_Pagamento(const Value: string);
    procedure SetMostrar_Nome_Vendedor(const Value: string);
    procedure SetNomeEmpresa(const Value: string);
    procedure SetQtd_Casas_Decimais_Qtdade_Produto(const Value: string);
    procedure SetQtd_Casas_Decimais_Valor_Produto(const Value: string);
    procedure SetUsar_Autenticacao(const Value: string);
    procedure SetLargura_Bobina(const Value: string);
    procedure SetMargem_Direita(const Value: string);
    procedure SetMargem_Esquerda(const Value: string);
    procedure SetMargem_Inferior(const Value: string);
    procedure SetMargem_Superior(const Value: string);
    procedure SetPonto_de_Captura(const Value: string);
    procedure SetPonto_de_Captura_Emissao_NF(const Value: string);
    procedure SetPastaArquivo_Req_Tef(const Value: string);
    procedure SetPastaArquivo_Resp_Tef(const Value: string);
    procedure SetNumero_Certificado_Duotec_PayGo(const Value: string);
    procedure SetPastaArquivo_Sts_Tef(const Value: string);
    procedure SetPastaArquivo_Temp_Tef(const Value: string);
    procedure SetTipoTefCredito(const Value: string);
    procedure SetTipoTefDebito(const Value: string);
    procedure SetTipoTefPix(const Value: string);
    procedure SetNomeRedeTefCredito(const Value: string);
    procedure SetNomeRedeTefDebito(const Value: string);
    procedure SetNomeRedeTefPix(const Value: string);

  public
    constructor Create;
    destructor Destroy; override;

    function ObterInformacoes(pArqIni: TIniFile): TIniFile;
    function GravarInformacoes(pArqIni: TIniFile): TIniFile;

    property Emitir_Nota_Fiscal_Eletronica: string
      read FEmitir_Nota_Fiscal_Eletronica write SetEmitir_Nota_Fiscal_Eletronica;
    property Emitir_Nota_Fiscal_Consumidor_Eletronica: string
      read FEmitir_Nota_Fiscal_Consumidor_Eletronica
      write SetEmitir_Nota_Fiscal_Consumidor_Eletronica;
    property Colocar_Unidade_Tres_Caracteres: string
      read FColocar_Unidade_Tres_Caracteres write SetColocar_Unidade_Tres_Caracteres;
    property Mostrar_Nome_Vendedor: string read FMostrar_Nome_Vendedor
      write SetMostrar_Nome_Vendedor;
    property NomeEmpresa: string read FNomeEmpresa write SetNomeEmpresa;
    property DataEmpresa: string read FDataEmpresa write SetDataEmpresa;
    property Enviar_NFe_NFEc_para_a_SEFAZ: string
      read FEnviar_NFe_NFEc_para_a_SEFAZ write SetEnviar_NFe_NFEc_para_a_SEFAZ;
    property Enviar_NFe_NFEc_Normal: string
      read FEnviar_NFe_NFEc_Normal write SetEnviar_NFe_NFEc_Normal;
    property Mostrar_Forma_Pagamento: string
      read FMostrar_Forma_Pagamento write SetMostrar_Forma_Pagamento;
    property Imprimir_Valor_Liquido: string
      read FImprimir_Valor_Liquido write SetImprimir_Valor_Liquido;
    property Imprimir_Desconto_Fatura: string
      read FImprimir_Desconto_Fatura write SetImprimir_Desconto_Fatura;
    property Imprimir_Per_Desconto: string read FImprimir_Per_Desconto
      write SetImprimir_Per_Desconto;
    property Imprimir_Percentual_Desconto: string
      read FImprimir_Percentual_Desconto write SetImprimir_Percentual_Desconto;
    property Margem_Superior: string read FMargem_Superior write SetMargem_Superior;
    property Margem_Inferior: string read FMargem_Inferior write SetMargem_Inferior;
    property Margem_Esquerda: string read FMargem_Esquerda write SetMargem_Esquerda;
    property Margem_Direita: string read FMargem_Direita write SetMargem_Direita;
    property Largura_Bobina: string read FLargura_Bobina write SetLargura_Bobina;
    property Usar_Autenticacao: string read FUsar_Autenticacao
      write SetUsar_Autenticacao;
    property Qtd_Casas_Decimais_Valor_Produto: string
      read FQtd_Casas_Decimais_Valor_Produto write SetQtd_Casas_Decimais_Valor_Produto;
    property Qtd_Casas_Decimais_Qtdade_Produto: string
      read FQtd_Casas_Decimais_Qtdade_Produto write SetQtd_Casas_Decimais_Qtdade_Produto;
    property Enviar_Email_Retorno: string read FEnviar_Email_Retorno
      write SetEnviar_Email_Retorno;
    property Enviar_Boleto_Com_NFe: string read FEnviar_Boleto_Com_NFe
      write SetEnviar_Boleto_Com_NFe;
    property Ponto_de_Captura: string read FPonto_de_Captura write SetPonto_de_Captura;
    property Ponto_de_Captura_Emissao_NF: string
      read FPonto_de_Captura_Emissao_NF write SetPonto_de_Captura_Emissao_NF;
    property PastaArquivo_Req_Tef: string read FPastaArquivo_Req_Tef
      write SetPastaArquivo_Req_Tef;
    property PastaArquivo_Resp_Tef: string read FPastaArquivo_Resp_Tef
      write SetPastaArquivo_Resp_Tef;
    property PastaArquivo_Temp_Tef: string read FPastaArquivo_Temp_Tef
      write SetPastaArquivo_Temp_Tef;
    property PastaArquivo_Sts_Tef: string read FPastaArquivo_Sts_Tef
      write SetPastaArquivo_Sts_Tef;
    property Numero_Certificado_Duotec_PayGo: string
      read FNumero_Certificado_Duotec_PayGo write SetNumero_Certificado_Duotec_PayGo;

  end;

  TBoletoIniFile = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    function ObterInformacoes(pArqIni: TIniFile): TIniFile;
    function GravarInformacoes(pArqIni: TIniFile): TIniFile;
  end;

  TPosPrinterIniFile = class
  private
    FLinhas_Buffer: string;
    FArquivo_Log: string;
    FLinhas_Entre_Cupons: string;
    FControle_Porta: string;
    FPagina_De_Codigo: string;
    FIgnorar_Tags: string;
    FColunas_Fonte_Normal: string;
    FCorta_Papel: string;
    FModelo: string;
    FTraduzir_Tags: string;
    FUsuario_Impressao: string;
    FPorta: string;
    FEspaco_Entre_Linhas: string;
    procedure SetArquivo_Log(const Value: string);
    procedure SetColunas_Fonte_Normal(const Value: string);
    procedure SetControle_Porta(const Value: string);
    procedure SetCorta_Papel(const Value: string);
    procedure SetEspaco_Entre_Linhas(const Value: string);
    procedure SetIgnorar_Tags(const Value: string);
    procedure SetLinhas_Buffer(const Value: string);
    procedure SetLinhas_Entre_Cupons(const Value: string);
    procedure SetModelo(const Value: string);
    procedure SetPagina_De_Codigo(const Value: string);
    procedure SetPorta(const Value: string);
    procedure SetTraduzir_Tags(const Value: string);
    procedure SetUsuario_Impressao(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;

    function ObterInformacoes(pArqIni: TIniFile): TIniFile;
    function GravarInformacoes(pArqIni: TIniFile): TIniFile;

    property Porta: string read FPorta write SetPorta;
    property Modelo: string read FModelo write SetModelo;
    property Arquivo_Log: string read FArquivo_Log write SetArquivo_Log;
    property Linhas_Buffer: string read FLinhas_Buffer write SetLinhas_Buffer;
    property Linhas_Entre_Cupons: string read FLinhas_Entre_Cupons
      write SetLinhas_Entre_Cupons;
    property Espaco_Entre_Linhas: string read FEspaco_Entre_Linhas
      write SetEspaco_Entre_Linhas;
    property Colunas_Fonte_Normal: string read FColunas_Fonte_Normal
      write SetColunas_Fonte_Normal;
    property Controle_Porta: string read FControle_Porta write SetControle_Porta;
    property Corta_Papel: string read FCorta_Papel write SetCorta_Papel;
    property Traduzir_Tags: string read FTraduzir_Tags write SetTraduzir_Tags;
    property Ignorar_Tags: string read FIgnorar_Tags write SetIgnorar_Tags;
    property Pagina_De_Codigo: string read FPagina_De_Codigo write SetPagina_De_Codigo;
    property Usuario_Impressao: string read FUsuario_Impressao
      write SetUsuario_Impressao;

  end;

  IDuoSigIniFile = interface

    function AplicacaoIniFile: TAplicacaoIniFile;
    function DatabaseIniFile: TDatabaseIniFile;
    function ConfiguracaoMonitorDuosigIniFile: TConfiguracaoMonitorDuosigIniFile;
    function BoletoIniFile: TBoletoIniFile;
    function PosPrinterIniFile: TPosPrinterIniFile;

  end;

  TDuosigIniFile = class(TInterfacedObject, IDuosigIniFile)

  private
    FArqIni: TIniFile;
    FAplicacaoIniFile: TAplicacaoIniFile;
    FDatabaseIniFile: TDatabaseIniFile;
    FConfiguracaoMonitorDuosigIniFile: TConfiguracaoMonitorDuosigIniFile;
    FBoletoIniFile: TBoletoIniFile;
    FPosPrinterIniFile: TPosPrinterIniFile;
  public

    constructor Create;
    destructor Destroy; override;
    class function New: IDuoSigIniFile;

    function AplicacaoIniFile: TAplicacaoIniFile;
    function DatabaseIniFile: TDatabaseIniFile;
    function ConfiguracaoMonitorDuosigIniFile: TConfiguracaoMonitorDuosigIniFile;
    function BoletoIniFile: TBoletoIniFile;
    function PosPrinterIniFile: TPosPrinterIniFile;

  end;

implementation

{ TDuosigIniFile }

function TDuosigIniFile.AplicacaoIniFile: TAplicacaoIniFile;
begin
  Result := FAplicacaoIniFile;
end;

function TDuosigIniFile.BoletoIniFile: TBoletoIniFile;
begin
  Result := FBoletoIniFile;
end;

function TDuosigIniFile.ConfiguracaoMonitorDuosigIniFile:
TConfiguracaoMonitorDuosigIniFile;
begin
  Result := FConfiguracaoMonitorDuosigIniFile;
end;

constructor TDuosigIniFile.Create;
var
  s: string;
begin
  s := ExtractFilePath(ParamStr(0)) +
    ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');

  FArqIni := TIniFile.Create(s);

  FAplicacaoIniFile := TAplicacaoIniFile.Create;
  FDatabaseIniFile := TDatabaseIniFile.Create;
  FConfiguracaoMonitorDuosigIniFile := TConfiguracaoMonitorDuosigIniFile.Create;
  FBoletoIniFile := TBoletoIniFile.Create;
  FPosPrinterIniFile := TPosPrinterIniFile.Create;

  FArqIni := FAplicacaoIniFile.ObterInformacoes(FArqIni);
  FArqIni := FDatabaseIniFile.ObterInformacoes(FArqIni);
  FArqIni := FConfiguracaoMonitorDuosigIniFile.ObterInformacoes(FArqIni);
  FArqIni := FBoletoIniFile.ObterInformacoes(FArqIni);
  FArqIni := FPosPrinterIniFile.ObterInformacoes(FArqIni);
end;

function TDuosigIniFile.DatabaseIniFile: TDatabaseIniFile;
begin
  Result := FDatabaseIniFile;
end;

destructor TDuosigIniFile.Destroy;
begin

  FArqIni := FAplicacaoIniFile.GravarInformacoes(FArqIni);
  FArqIni := FDatabaseIniFile.GravarInformacoes(FArqIni);
  FArqIni := FConfiguracaoMonitorDuosigIniFile.GravarInformacoes(FArqIni);
  FArqIni := FBoletoIniFile.GravarInformacoes(FArqIni);
  FArqIni := FPosPrinterIniFile.GravarInformacoes(FArqIni);
  FArqIni.UpdateFile;
  FArqIni.Free;

  FAplicacaoIniFile.Free;
  FDatabaseIniFile.Free;
  FConfiguracaoMonitorDuosigIniFile.Free;
  FBoletoIniFile.Free;
  FPosPrinterIniFile.Free;
  inherited;
end;

class function TDuosigIniFile.New: IDuoSigIniFile;
begin
  Result := Self.Create;
end;

function TDuosigIniFile.PosPrinterIniFile: TPosPrinterIniFile;
begin
  Result := FPosPrinterIniFile;
end;

{ TPosPrinterIniFile }

constructor TPosPrinterIniFile.Create;
var
  LPasta: string;
  Ano, Mes, Dia: word;

begin
  LPasta := ParamStr(0) + 'LogImpressoraPosPrinter';
  if not DirectoryExists(LPasta) then
    ForceDirectories(LPasta);

  DecodeDate(Date, Ano, Mes, Dia);
  LPasta := LPasta + 'Log_' + FormatFloat('0000', Ano) + '_' +
    FormatFloat('00', Mes) + '_' + FormatFloat('00', Dia) + '.Log';

  FPorta := '';
  FModelo := 'ppEscBematech';
  FArquivo_Log := LPasta;
  FLinhas_Buffer := '0';
  FLinhas_Entre_Cupons := '1';
  FEspaco_Entre_Linhas := '1';
  FColunas_Fonte_Normal := '1';
  FControle_Porta := 'N';
  FCorta_Papel := 'S';
  FTraduzir_Tags := 'S';
  FIgnorar_Tags := 'N';
  FPagina_De_Codigo := 'pc850';
  FUsuario_Impressao := 'DUOTEC';

end;

destructor TPosPrinterIniFile.Destroy;
begin

  inherited;
end;

function TPosPrinterIniFile.GravarInformacoes(pArqIni: TIniFile): TIniFile;
begin
  pArqIni.WriteString('POSPRINTER', 'Porta', FPorta);
  pArqIni.WriteString('POSPRINTER', 'Modelo', FModelo);
  pArqIni.WriteString('POSPRINTER', 'Arquivo_Log', FArquivo_Log);
  pArqIni.WriteString('POSPRINTER', 'Linhas_Buffer', FLinhas_Buffer);
  pArqIni.WriteString('POSPRINTER', 'Linhas_Entre_Cupons', FLinhas_Entre_Cupons);
  pArqIni.WriteString('POSPRINTER', 'Espaco_Entre_Linhas', FEspaco_Entre_Linhas);
  pArqIni.WriteString('POSPRINTER', 'Colunas_Fonte_Normal', FColunas_Fonte_Normal);
  pArqIni.WriteString('POSPRINTER', 'Controle_Porta', FControle_Porta);
  pArqIni.WriteString('POSPRINTER', 'Corta_Papel', FCorta_Papel);
  pArqIni.WriteString('POSPRINTER', 'Traduzir_Tags', FTraduzir_Tags);
  pArqIni.WriteString('POSPRINTER', 'Ignorar_Tags', FIgnorar_Tags);
  pArqIni.WriteString('POSPRINTER', 'Traduzir_Tags', FTraduzir_Tags);
  pArqIni.WriteString('POSPRINTER', 'Pagina_De_Codigo', FPagina_De_Codigo);
  Result := pArqIni;
end;

function TPosPrinterIniFile.ObterInformacoes(pArqIni: TIniFile): TIniFile;
begin
  if not Assigned(pArqIni) then
    raise Exception.Create('Nao tem arquivo ini  TPosPrinterIniFile');


  FPorta := pArqIni.ReadString('POSPRINTER', 'Porta', FPorta);
  FModelo := pArqIni.ReadString('POSPRINTER', 'Modelo', FModelo);
  FArquivo_Log := pArqIni.ReadString('POSPRINTER', 'Arquivo_Log', FArquivo_Log);
  FLinhas_Buffer := pArqIni.ReadString('POSPRINTER', 'Linhas_Buffer', FLinhas_Buffer);
  FLinhas_Entre_Cupons := pArqIni.ReadString('POSPRINTER', 'Linhas_Entre_Cupons',
    FLinhas_Entre_Cupons);
  FEspaco_Entre_Linhas := pArqIni.ReadString('POSPRINTER', 'Espaco_Entre_Linhas',
    FEspaco_Entre_Linhas);
  FColunas_Fonte_Normal := pArqIni.ReadString('POSPRINTER',
    'Colunas_Fonte_Normal', FColunas_Fonte_Normal);
  FControle_Porta := pArqIni.ReadString('POSPRINTER', 'Controle_Porta', FControle_Porta);
  FCorta_Papel := pArqIni.ReadString('POSPRINTER', 'Corta_Papel', FCorta_Papel);
  FTraduzir_Tags := pArqIni.ReadString('POSPRINTER', 'Traduzir_Tags', FTraduzir_Tags);
  FIgnorar_Tags := pArqIni.ReadString('POSPRINTER', 'Ignorar_Tags', FIgnorar_Tags);
  FTraduzir_Tags := pArqIni.ReadString('POSPRINTER', 'Traduzir_Tags', FTraduzir_Tags);
  FPagina_De_Codigo := pArqIni.ReadString('POSPRINTER', 'Pagina_De_Codigo',
    FPagina_De_Codigo);
  Result := pArqIni;

end;

procedure TPosPrinterIniFile.SetArquivo_Log(const Value: string);
begin
  FArquivo_Log := Value;
end;

procedure TPosPrinterIniFile.SetColunas_Fonte_Normal(const Value: string);
begin
  FColunas_Fonte_Normal := Value;
end;

procedure TPosPrinterIniFile.SetControle_Porta(const Value: string);
begin
  FControle_Porta := Value;
end;

procedure TPosPrinterIniFile.SetCorta_Papel(const Value: string);
begin
  FCorta_Papel := Value;
end;

procedure TPosPrinterIniFile.SetEspaco_Entre_Linhas(const Value: string);
begin
  FEspaco_Entre_Linhas := Value;
end;

procedure TPosPrinterIniFile.SetIgnorar_Tags(const Value: string);
begin

end;

procedure TPosPrinterIniFile.SetLinhas_Buffer(const Value: string);
begin
  FLinhas_Buffer := Value;
end;

procedure TPosPrinterIniFile.SetLinhas_Entre_Cupons(const Value: string);
begin
  FLinhas_Entre_Cupons := Value;
end;

procedure TPosPrinterIniFile.SetModelo(const Value: string);
begin
  FModelo := Value;
end;

procedure TPosPrinterIniFile.SetPagina_De_Codigo(const Value: string);
begin
  FPagina_De_Codigo := Value;
end;

procedure TPosPrinterIniFile.SetPorta(const Value: string);
begin
  FPorta := Value;
end;

procedure TPosPrinterIniFile.SetTraduzir_Tags(const Value: string);
begin
  FTraduzir_Tags := Value;
end;

procedure TPosPrinterIniFile.SetUsuario_Impressao(const Value: string);
begin
  FUsuario_Impressao := Value;
end;

{ TDatabaseIniFile }

constructor TDatabaseIniFile.Create;
begin
  FBanco_Dados := 'DUOSIG_DADOS';
  FUsuario_Banco := 'SYSDBA';
  FSenha := 'masterkey';
  fServidor := '127.0.0.1';
end;

destructor TDatabaseIniFile.Destroy;
begin
  inherited;
end;

function TDatabaseIniFile.GravarInformacoes(pArqIni: TIniFile): TIniFile;
begin
  pArqIni.WriteString('DATABASE', 'Servidor', FServidor);
  pArqIni.WriteString('DATABASE', 'Senha', FSenha);
  pArqIni.WriteString('DATABASE', 'Banco_Dados', FBanco_Dados);
  pArqIni.WriteString('DATABASE', 'Usuario_Banco', FUsuario_Banco);
  Result := pArqIni;

end;

function TDatabaseIniFile.ObterInformacoes(pArqIni: TIniFile): TIniFile;
begin

  if not Assigned(pArqIni) then
    raise Exception.Create('Nao tem arquivo ini  TDatabaseIniFile');

  FServidor := pArqIni.ReadString('DATABASE', 'Servidor', FServidor);
  FSenha := pArqIni.ReadString('DATABASE', 'Senha', FSenha);
  FBanco_Dados := pArqIni.ReadString('DATABASE', 'Banco_Dados', FBanco_Dados);
  FUsuario_Banco := pArqIni.ReadString('DATABASE', 'Usuario_Banco', FUsuario_Banco);
  Result := pArqIni;
end;


procedure TDatabaseIniFile.SetBanco_Dados(AValue: string);
begin
  if FBanco_Dados = AValue then Exit;
  FBanco_Dados := AValue;
end;

procedure TDatabaseIniFile.SetSenha(AValue: string);
begin
  if FSenha = AValue then Exit;
  FSenha := AValue;
end;

procedure TDatabaseIniFile.SetServidor(AValue: string);
begin
  if FServidor = AValue then Exit;
  FServidor := AValue;
end;

procedure TDatabaseIniFile.SetUsuario_Banco(AValue: string);
begin
  if FUsuario_Banco = AValue then Exit;
  FUsuario_Banco := AValue;
end;


{ TConfiguracaoMonitorDuosigIniFile }

constructor TConfiguracaoMonitorDuosigIniFile.Create;
begin
  FEmitir_Nota_Fiscal_Eletronica := 'S';
  FEmitir_Nota_Fiscal_Consumidor_Eletronica := 'S';
  FColocar_Unidade_Tres_Caracteres := 'N';
  FMostrar_Nome_Vendedor := 'N';
  fNomeEmpresa := 'DUOTEC SISTEMAS';
  FDataEmpresa := '';
  FEnviar_NFe_NFEc_para_a_SEFAZ := 'S';
  FEnviar_NFe_NFEc_Normal := 'S';
  FMostrar_Forma_Pagamento := 'N';
  FImprimir_Valor_Liquido := 'N';
  FImprimir_Desconto_Fatura := 'N';
  FImprimir_Per_Desconto := 'S';
  FImprimir_Percentual_Desconto := 'N';
  FMargem_Superior := '0';
  FMargem_Inferior := '0';
  FMargem_Esquerda := '0';
  FMargem_Direita := '0';
  FLargura_Bobina := '0';
  FUsar_Autenticacao := 'S';
  FQtd_Casas_Decimais_Valor_Produto := '2';
  FQtd_Casas_Decimais_Qtdade_Produto := '2';
  FEnviar_Email_Retorno := 'S';
  FEnviar_Boleto_Com_NFe := 'S';
  FPastaArquivo_Req_Tef := 'C:\TEF\req\intpos.001';
  FPastaArquivo_Resp_Tef := 'C:\TEF\resp\intpos.001';
  FPastaArquivo_Sts_Tef := 'C:\TEF\resp\intpos.sts';
  FPastaArquivo_Temp_Tef := 'C:\TEF\req\intpos.001';

  FTipoTefPix := 'N';
  FTipoTefCredito := 'N';
  FTipoTefDebito := 'N';

  FNomeRedeTefDebito := '';
  FNomeRedeTefCredito := '';
  FNomeRedeTefPix := '';
end;

destructor TConfiguracaoMonitorDuosigIniFile.Destroy;
begin

  inherited;
end;

function TConfiguracaoMonitorDuosigIniFile.GravarInformacoes(
  pArqIni: TIniFile): TIniFile;
begin
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Enviar_Email_Retorno',
    FEnviar_Email_Retorno);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Imprimir_Per_Desconto',
    FImprimir_Per_Desconto);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Emitir_Nota_Fiscal_Eletronica',
    FEmitir_Nota_Fiscal_Eletronica);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Imprimir_Percentual_Desconto',
    FImprimir_Percentual_Desconto);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Usar_Autenticacao',
    FUsar_Autenticacao);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Enviar_NFe_NFEc_para_a_SEFAZ',
    FEnviar_NFe_NFEc_para_a_SEFAZ);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG',
    'Emitir_Nota_Fiscal_Consumidor_Eletronica',
    FEmitir_Nota_Fiscal_Consumidor_Eletronica);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Colocar_Unidade_Tres_Caracteres',
    FColocar_Unidade_Tres_Caracteres);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'NomeEmpresa', FNomeEmpresa);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'DataEmpresa', FDataEmpresa);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Qtd_Casas_Decimais_Valor_Produto',
    FQtd_Casas_Decimais_Valor_Produto);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Imprimir_Desconto_Fatura',
    FImprimir_Desconto_Fatura);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG',
    'Qtd_Casas_Decimais_Qtdade_Produto', FQtd_Casas_Decimais_Qtdade_Produto);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Imprimir_Valor_Liquido',
    FImprimir_Valor_Liquido);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Enviar_NFe_NFEc_Normal',
    FEnviar_NFe_NFEc_Normal);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Largura_Bobina', FLargura_Bobina);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Margem_Superior',
    FMargem_Superior);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Margem_Inferior',
    FMargem_Inferior);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Margem_Esquerda',
    FMargem_Esquerda);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Margem_Direita', FMargem_Direita);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Ponto_de_Captura',
    FPonto_de_Captura);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Ponto_de_Captura_Emissao_NF',
    FPonto_de_Captura_Emissao_NF);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'PastaArquivo_Req_Tef',
    FPastaArquivo_Req_Tef);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'PastaArquivo_Resp_Tef',
    FPastaArquivo_Resp_Tef);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'PastaArquivo_Temp_Tef',
    FPastaArquivo_Temp_Tef);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'PastaArquivo_Sts_Tef',
    FPastaArquivo_Sts_Tef);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Numero_Certificado_Duotec_PayGo',
    FNumero_Certificado_Duotec_PayGo);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Tipo_Tef_Debito', FTipoTefDebito);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Tipo_Tef_Credito',
    FTipoTefCredito);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Tipo_Tef_Pix', FTipoTefPix);

  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Nome_Rede_Tef_Debito',
    FNomeRedeTefDebito);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Nome_Rede_Tef_Credito',
    FNomeRedeTefCredito);
  pArqIni.WriteString('CONFIGURACAO_MONITOR_DUOSIG', 'Nome_Rede_Tef_Pix',
    FNomeRedeTefPix);
  Result := pArqIni;
end;

function TConfiguracaoMonitorDuosigIniFile.ObterInformacoes(
  pArqIni: TIniFile): TIniFile;
begin
  FEnviar_Email_Retorno := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Enviar_Email_Retorno', FEnviar_Email_Retorno);
  FImprimir_Per_Desconto := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Imprimir_Per_Desconto', FImprimir_Per_Desconto);
  FEmitir_Nota_Fiscal_Eletronica :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG', 'Emitir_Nota_Fiscal_Eletronica',
    FEmitir_Nota_Fiscal_Eletronica);
  FImprimir_Percentual_Desconto :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG', 'Imprimir_Percentual_Desconto',
    FImprimir_Percentual_Desconto);
  FUsar_Autenticacao := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Usar_Autenticacao', FUsar_Autenticacao);
  FEnviar_NFe_NFEc_para_a_SEFAZ :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG', 'Enviar_NFe_NFEc_para_a_SEFAZ',
    FEnviar_NFe_NFEc_para_a_SEFAZ);
  FEmitir_Nota_Fiscal_Consumidor_Eletronica :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Emitir_Nota_Fiscal_Consumidor_Eletronica',
    FEmitir_Nota_Fiscal_Consumidor_Eletronica);
  FColocar_Unidade_Tres_Caracteres :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG', 'Colocar_Unidade_Tres_Caracteres',
    FColocar_Unidade_Tres_Caracteres);
  FNomeEmpresa := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'NomeEmpresa', FNomeEmpresa);
  FDataEmpresa := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'DataEmpresa', FDataEmpresa);
  FQtd_Casas_Decimais_Valor_Produto :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Qtd_Casas_Decimais_Valor_Produto', FQtd_Casas_Decimais_Valor_Produto);
  FImprimir_Desconto_Fatura :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG', 'Imprimir_Desconto_Fatura',
    FImprimir_Desconto_Fatura);
  FQtd_Casas_Decimais_Qtdade_Produto :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Qtd_Casas_Decimais_Qtdade_Produto', FQtd_Casas_Decimais_Qtdade_Produto);
  FImprimir_Valor_Liquido := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Imprimir_Valor_Liquido', FImprimir_Valor_Liquido);
  FEnviar_NFe_NFEc_Normal := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Enviar_NFe_NFEc_Normal', FEnviar_NFe_NFEc_Normal);
  FLargura_Bobina := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Largura_Bobina', FLargura_Bobina);
  FMargem_Superior := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Margem_Superior', FMargem_Superior);
  FMargem_Inferior := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Margem_Inferior', FMargem_Inferior);
  FMargem_Esquerda := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Margem_Esquerda', FMargem_Esquerda);
  FMargem_Direita := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Margem_Direita', FMargem_Direita);
  FPonto_de_Captura := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Ponto_de_Captura', FPonto_de_Captura);
  FPonto_de_Captura_Emissao_NF :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG', 'Ponto_de_Captura_Emissao_NF',
    FPonto_de_Captura_Emissao_NF);
  FPastaArquivo_Req_Tef := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'PastaArquivo_Req_Tef', FPastaArquivo_Req_Tef);
  FPastaArquivo_Resp_Tef := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'PastaArquivo_Resp_Tef', FPastaArquivo_Resp_Tef);
  FPastaArquivo_Temp_Tef := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'PastaArquivo_Temp_Tef', FPastaArquivo_Temp_Tef);
  FPastaArquivo_Sts_Tef := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'PastaArquivo_Sts_Tef', FPastaArquivo_Sts_Tef);
  FNumero_Certificado_Duotec_PayGo :=
    pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG', 'Numero_Certificado_Duotec_PayGo',
    FNumero_Certificado_Duotec_PayGo);
  FTipoTefDebito := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Tipo_Tef_Debito', FTipoTefDebito);
  FTipoTefCredito := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Tipo_Tef_Credito', FTipoTefCredito);
  FTipoTefPix := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Tipo_Tef_Pix', FTipoTefPix);

  FNomeRedeTefDebito := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Nome_Rede_Tef_Debito', FNomeRedeTefDebito);
  FNomeRedeTefCredito := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Nome_Rede_Tef_Credito', FNomeRedeTefCredito);
  FNomeRedeTefPix := pArqIni.ReadString('CONFIGURACAO_MONITOR_DUOSIG',
    'Nome_Rede_Tef_Pix', FNomeRedeTefPix);
  Result := pArqIni;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetColocar_Unidade_Tres_Caracteres(
  const Value: string);
begin
  FColocar_Unidade_Tres_Caracteres := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetDataEmpresa(const Value: string);
begin
  FDataEmpresa := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetEmitir_Nota_Fiscal_Consumidor_Eletronica(
  const Value: string);
begin
  FEmitir_Nota_Fiscal_Consumidor_Eletronica := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetEmitir_Nota_Fiscal_Eletronica(
  const Value: string);
begin
  FEmitir_Nota_Fiscal_Eletronica := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetEnviar_Boleto_Com_NFe(
  const Value: string);
begin
  FEnviar_Boleto_Com_NFe := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetEnviar_Email_Retorno(
  const Value: string);
begin
  FEnviar_Email_Retorno := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetEnviar_NFe_NFEc_Normal(
  const Value: string);
begin
  FEnviar_NFe_NFEc_Normal := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetEnviar_NFe_NFEc_para_a_SEFAZ(
  const Value: string);
begin
  FEnviar_NFe_NFEc_para_a_SEFAZ := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetImprimir_Desconto_Fatura(
  const Value: string);
begin
  FImprimir_Desconto_Fatura := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetImprimir_Percentual_Desconto(
  const Value: string);
begin
  FImprimir_Percentual_Desconto := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetImprimir_Per_Desconto(
  const Value: string);
begin
  FImprimir_Per_Desconto := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetImprimir_Valor_Liquido(
  const Value: string);
begin
  FImprimir_Valor_Liquido := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetLargura_Bobina(const Value: string);
begin
  FLargura_Bobina := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetMargem_Direita(const Value: string);
begin
  FMargem_Direita := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetMargem_Esquerda(const Value: string);
begin
  FMargem_Esquerda := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetMargem_Inferior(const Value: string);
begin
  FMargem_Inferior := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetMargem_Superior(const Value: string);
begin
  FMargem_Superior := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetMostrar_Forma_Pagamento(
  const Value: string);
begin
  FMostrar_Forma_Pagamento := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetMostrar_Nome_Vendedor(
  const Value: string);
begin
  FMostrar_Nome_Vendedor := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetNomeEmpresa(const Value: string);
begin
  FNomeEmpresa := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetNumero_Certificado_Duotec_PayGo(
  const Value: string);
begin
  FNumero_Certificado_Duotec_PayGo := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetPastaArquivo_Req_Tef(
  const Value: string);
begin
  FPastaArquivo_Req_Tef := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetPastaArquivo_Sts_Tef(
  const Value: string);
begin
  FPastaArquivo_Sts_Tef := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetPastaArquivo_Resp_Tef(
  const Value: string);
begin
  FPastaArquivo_Resp_Tef := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetPastaArquivo_Temp_Tef(
  const Value: string);
begin
  FPastaArquivo_Temp_Tef := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetPonto_de_Captura(const Value: string);
begin
  FPonto_de_Captura := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetPonto_de_Captura_Emissao_NF(
  const Value: string);
begin
  FPonto_de_Captura_Emissao_NF := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetQtd_Casas_Decimais_Qtdade_Produto(
  const Value: string);
begin
  FQtd_Casas_Decimais_Qtdade_Produto := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetQtd_Casas_Decimais_Valor_Produto(
  const Value: string);
begin
  FQtd_Casas_Decimais_Valor_Produto := Value;
end;


procedure TConfiguracaoMonitorDuosigIniFile.SetUsar_Autenticacao(const Value: string);
begin
  FUsar_Autenticacao := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetTipoTefCredito(const Value: string);
begin
  FTipoTefCredito := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetTipoTefDebito(const Value: string);
begin
  FTipoTefDebito := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetTipoTefPix(const Value: string);
begin
  FTipoTefPix := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetNomeRedeTefCredito(const Value: string);
begin
  FNomeRedeTefCredito := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetNomeRedeTefDebito(const Value: string);
begin
  FNomeRedeTefDebito := Value;
end;

procedure TConfiguracaoMonitorDuosigIniFile.SetNomeRedeTefPix(const Value: string);
begin
  FNomeRedeTefPix := Value;
end;

{ TBoletoIniFile }

constructor TBoletoIniFile.Create;
begin
end;

destructor TBoletoIniFile.Destroy;
begin

  inherited;
end;

function TBoletoIniFile.GravarInformacoes(pArqIni: TIniFile): TIniFile;
begin
  Result := pArqIni;
end;

function TBoletoIniFile.ObterInformacoes(pArqIni: TIniFile): TIniFile;
begin
    Result := pArqIni;
end;


{ TAplicacaoIniFile }

constructor TAplicacaoIniFile.Create;
begin
end;

destructor TAplicacaoIniFile.Destroy;
begin
  inherited;
end;

function TAplicacaoIniFile.GravarInformacoes(pArqIni: TIniFile): TIniFile;
begin
  Result := pArqIni;
end;

function TAplicacaoIniFile.ObterInformacoes(pArqIni: TIniFile): TIniFile;
begin
  Result := pArqIni;
end;


end.
