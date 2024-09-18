unit model_paygo_tef1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ACBrTEFD, ACBrPosPrinter, ACBrTEFDClass, Forms, Dialogs,
  Controls, ExtCtrls, DateUtils, StdCtrls,
  model_configuracao_inifile,
  ACBrTEFPayGoComum,
  ACBrTEFPayGoWebComum,
  ACBrTEFComum;

type


  TStatusVenda = (stsLivre, stsIniciada, stsEmPagamento, stsCancelada,
    stsAguardandoTEF, stsOperacaoTEF, stsFinalizada);

  { TModelPayGoTef1 }

  TModelPayGoTef1 = class(TDataModule)
    ACBrPosPrinter: TACBrPosPrinter;
    ACBrTEFD: TACBrTEFD;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure ACBrTEFDAguardaResp(Arquivo: string; SegundosTimeOut: integer;
      var Interromper: boolean);
    procedure ACBrTEFDAntesFinalizarRequisicao(Req: TACBrTEFDReq);
    procedure ACBrTEFDBloqueiaMouseTeclado(Bloqueia: boolean; var Tratado: boolean);
    procedure ACBrTEFDComandaECF(Operacao: TACBrTEFDOperacaoECF;
      Resp: TACBrTEFDResp; var RetornoECF: integer);
    procedure ACBrTEFDComandaECFAbreVinculado(COO, IndiceECF: string;
      Valor: double; var RetornoECF: integer);
    procedure ACBrTEFDComandaECFImprimeVia(TipoRelatorio: TACBrTEFDTipoRelatorio;
      Via: integer; ImagemComprovante: TStringList; var RetornoECF: integer);
    procedure ACBrTEFDComandaECFPagamento(IndiceECF: string; Valor: double;
      var RetornoECF: integer);
    procedure ACBrTEFDDepoisConfirmarTransacoes(RespostasPendentes:
      TACBrTEFDRespostasPendentes);
    procedure ACBrTEFDExibeMsg(Operacao: TACBrTEFDOperacaoMensagem;
      Mensagem: string; var AModalResult: TModalResult);
    procedure ACBrTEFDGravarLog(const GP: TACBrTEFDTipo; ALogLine: string;
      var Tratado: boolean);
    procedure ACBrTEFDInfoECF(Operacao: TACBrTEFDInfoECF; var RetornoECF: string);
  private
    FMmLog: TMemo;
    Ok: boolean;
    FCanceladoPeloOperador: boolean;
    FIndicePagto: string;
    FPnlMsgCliente: TPanel;
    FPnlMsgOperador: TPanel;
    FTempoDeEspera: TDateTime;
    StatusVenda: TStatusVenda;
    FBandeira: string;
    FCnpjAdquirente: string;
    FCodAutorizacao: string;
    FDoc001: string;
    FDoc002: string;
    FIdTransacao: string;
    FMensagemFoiMostrada: boolean;
    FModeloFiscal: string;
    FNSU: string;
    FPrimeiraVia: string;
    FQtdParcelas: integer;
    FRede: string;
    FVlrVenda: currency;

    procedure SetBandeira(AValue: string);
    procedure SetCnpjAdquirente(AValue: string);
    procedure SetCodAutorizacao(AValue: string);
    procedure SetDoc001(AValue: string);
    procedure SetDoc002(AValue: string);
    procedure SetIdTransacao(AValue: string);
    procedure SetMensagemFoiMostrada(AValue: boolean);
    procedure SetMmLog(AValue: TMemo);
    procedure SetModeloFiscal(AValue: string);
    procedure SetNSU(AValue: string);
    procedure SetPnlMsgCliente(AValue: TPanel);
    procedure SetPnlMsgOperador(AValue: TPanel);
    procedure SetPrimeiraVia(AValue: string);
    procedure SetQtdParcelas(AValue: integer);
    procedure SetRede(AValue: string);
    procedure SetVlrVenda(AValue: currency);


    procedure MensagemTEF(const MsgOperador, MsgCliente: string);
    function ObterEnum(pNome: string): integer;
    function ObterEnumPaginaCodigo(pNome: string): integer;

  public
    procedure ViewLog(pString: string);
    procedure AtivarTef;
    procedure ConfigurarTef;
    procedure ConfigurarImpressora;
    procedure Administrativo;
    procedure ImprimirDoc(pValue: string);
    function VenderCartaoCredito(pAdquirente: string; pVlrVenda: currency): boolean;
    function VenderCartaoDebito(pAdquirente: string; pVlrVenda: currency): boolean;
    procedure AdicionarLinhaLog(AMensagem: string);
    property VlrVenda: currency read FVlrVenda write SetVlrVenda;
    property PrimeiraVia: string read FPrimeiraVia write SetPrimeiraVia;
    property MensagemFoiMostrada: boolean read FMensagemFoiMostrada
      write SetMensagemFoiMostrada;
    property Doc001: string read FDoc001 write SetDoc001;
    property Doc002: string read FDoc002 write SetDoc002;
    property NSU: string read FNSU write SetNSU;
    property CodAutorizacao: string read FCodAutorizacao write SetCodAutorizacao;
    property IdTransacao: string read FIdTransacao write SetIdTransacao;
    property Rede: string read FRede write SetRede;
    property Bandeira: string read FBandeira write SetBandeira;
    property QtdParcelas: integer read FQtdParcelas write SetQtdParcelas;
    property CnpjAdquirente: string read FCnpjAdquirente write SetCnpjAdquirente;
    property ModeloFiscal: string read FModeloFiscal write SetModeloFiscal;

    property PnlMsgOperador: TPanel read FPnlMsgOperador write SetPnlMsgOperador;
    property PnlMsgCliente: TPanel read FPnlMsgCliente write SetPnlMsgCliente;
    property MmLog: TMemo read FMmLog write SetMmLog;



  end;

var
  ModelPayGoTef1: TModelPayGoTef1;

implementation

{$R *.lfm}

{ TModelPayGoTef1 }

procedure TModelPayGoTef1.ACBrTEFDAguardaResp(Arquivo: string;
  SegundosTimeOut: integer; var Interromper: boolean);
var
  Msg: string;
begin
  if FCanceladoPeloOperador then
  begin
    FCanceladoPeloOperador := False;
    Interromper := True;
    Exit;
  end;

  Msg := '';
  if FTempoDeEspera <> SegundosTimeOut then
  begin
    Msg := 'Aguardando: ' + Arquivo + ' ' + IntToStr(SegundosTimeOut);
    FTempoDeEspera := SegundosTimeOut;
  end;

  if Msg <> '' then
    AdicionarLinhaLog(Msg);

  Application.ProcessMessages;
end;

procedure TModelPayGoTef1.ACBrTEFDAntesFinalizarRequisicao(Req: TACBrTEFDReq);
begin
  AdicionarLinhaLog('Enviando: ' + Req.Header + ' ID: ' + IntToStr(Req.ID));

  FCanceladoPeloOperador := False;
  FTempoDeEspera := 0;

  if (ACBrTEFD.GPAtual = gpPayGo) then
  begin
    if (Req.Header = 'CRT') then
    begin
      if (FIndicePagto = '03') then
      begin
        Req.GravaInformacao(730, 000, '1'); // 1: venda (pagamento com cartão)
        Req.GravaInformacao(731, 000, '1'); // 1: crédito
      end

      else if (FIndicePagto = '04') then
      begin
        Req.GravaInformacao(730, 000, '1'); // 1: venda (pagamento com cartão)
        Req.GravaInformacao(731, 000, '2'); // 2: débito
      end;

      FIndicePagto := '';
    end;
  end;
end;

procedure TModelPayGoTef1.ACBrTEFDBloqueiaMouseTeclado(Bloqueia: boolean;
  var Tratado: boolean);
begin
  //  Self.Enabled := not Bloqueia;
  //  AdicionarLinhaLog('BloqueiaMouseTeclado = ' + IfThen(Bloqueia, 'SIM', 'NAO'));
  //  Tratado := False;  { Deixa executar o código de Bloqueio do ACBrTEFD }
end;

procedure TModelPayGoTef1.ACBrTEFDComandaECF(Operacao: TACBrTEFDOperacaoECF;
  Resp: TACBrTEFDResp; var RetornoECF: integer);
begin
  AdicionarLinhaLog('Codigo Autorizacao: ' + REsp.CodigoAutorizacaoTransacao);
  AdicionarLinhaLog(ACBrTEFD.RespostasPendentes[ACBrTEFD.RespostasPendentes.Count -
    1].Conteudo.LeInformacao(013, 000).AsString);

  Application.ProcessMessages;
  RetornoECF := 1;
end;

procedure TModelPayGoTef1.ACBrTEFDComandaECFAbreVinculado(COO, IndiceECF: string;
  Valor: double; var RetornoECF: integer);
begin
  RetornoECF := 1;
  AdicionarLinhaLog('Indice ECF ' + IndiceECF);
  Application.ProcessMessages;
end;

procedure TModelPayGoTef1.ACBrTEFDComandaECFImprimeVia(TipoRelatorio:
  TACBrTEFDTipoRelatorio; Via: integer; ImagemComprovante: TStringList;
  var RetornoECF: integer);
var
  LDocImpresso: string;
begin

  LDocImpresso := ImagemComprovante.Text;
  if FDoc001 = '' then
    FDoc001 := ImagemComprovante.Text
  else
    FDoc002 := ImagemComprovante.Text;

  if ImagemComprovante.Text <> FPrimeiraVia then
    FPrimeiraVia := ImagemComprovante.Text
  else
    LDocImpresso := '';

  AdicionarLinhaLog(ImagemComprovante.Text);
  AdicionarLinhaLog('======================================================================');
  if LDocImpresso <> '' then
    ImprimirDoc(LDocImpresso);

  ImprimirDoc('</lf>');
  ImprimirDoc('</lf>');
  ImprimirDoc('</corte_parcial>');
  Application.ProcessMessages;
  RetornoECF := 1;
end;

procedure TModelPayGoTef1.ACBrTEFDComandaECFPagamento(IndiceECF: string;
  Valor: double; var RetornoECF: integer);
begin
  AdicionarLinhaLog('ACBrTEFDComandaECFPagamento Fpagamento');
  RetornoECF := 1;
end;

procedure TModelPayGoTef1.ACBrTEFDDepoisConfirmarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);

var
  i: integer;
begin
  AdicionarLinhaLog('ACBrTEFDDepoisConfirmarTransacoes Fpagamento');
  for i := 0 to RespostasPendentes.Count - 1 do
  begin
    with RespostasPendentes[i] do
    begin
      FNSU := RespostasPendentes[i].NSU;
      FCodAutorizacao := RespostasPendentes[i].CodigoAutorizacaoTransacao;
      FRede := RespostasPendentes[i].Rede;
      FIdTransacao := RespostasPendentes[i].Finalizacao;
      FBandeira := RespostasPendentes[i].NFCeSAT.Bandeira;
      FQtdParcelas := RespostasPendentes[i].QtdParcelas;
      FCnpjAdquirente := RespostasPendentes[i].NFCeSAT.CNPJCredenciadora;
      FRede := RespostasPendentes[i].Rede;
      AdicionarLinhaLog('Confirmado: ' + Header + ' ID: ' + IntToStr(ID));
    end;
  end;

end;

procedure TModelPayGoTef1.ACBrTEFDExibeMsg(Operacao: TACBrTEFDOperacaoMensagem;
  Mensagem: string; var AModalResult: TModalResult);
var
  Fim: TDateTime;
  OldMensagem: string;
begin
  fMensagemFoiMostrada := False;
  AdicionarLinhaLog(Mensagem);
  Application.ProcessMessages;

  case Operacao of
    opmOK:
    begin
      AModalResult := MessageDlg(Mensagem, mtInformation, [mbOK], 0);
      fMensagemFoiMostrada := True;
    end;

    opmYesNo:
      AModalResult := MessageDlg(Mensagem, mtConfirmation, [mbYes, mbNo], 0);

    opmExibirMsgOperador:
      MensagemTEF(Mensagem, '');

    opmRemoverMsgOperador:
      MensagemTEF(' ', '');

    opmExibirMsgCliente:
      MensagemTEF('', Mensagem);

    opmRemoverMsgCliente:
      MensagemTEF('', ' ');

    opmDestaqueVia:
    begin
      OldMensagem := PnlMsgOperador.Caption;
      try
        { Aguardando 3 segundos }
        Fim := IncSecond(now, 3);
        repeat
          MensagemTEF(Mensagem + ' Mensagem ' + IntToStr(SecondsBetween(Fim, now)), '');
          Sleep(200);
        until (now > Fim);
      finally
        MensagemTEF(OldMensagem, '');
      end;
    end;
  end;
end;

procedure TModelPayGoTef1.ACBrTEFDGravarLog(const GP: TACBrTEFDTipo;
  ALogLine: string; var Tratado: boolean);
begin
  AdicionarLinhaLog(ALogLine);
  Tratado := False;
end;

procedure TModelPayGoTef1.ACBrTEFDInfoECF(Operacao: TACBrTEFDInfoECF;
  var RetornoECF: string);
begin
  AdicionarLinhaLog('InfoECF ');
  Application.ProcessMessages;
  case Operacao of
    ineSubTotal:
      RetornoECF := FloatToStr(fVlrVenda);

    ineTotalAPagar:
    begin
      RetornoECF := FloatToStr(fVlrVenda);
    end;

    ineEstadoECF:
    begin
      //"L" - Livre
      //"V" - Venda de Itens
      //"P" - Pagamento (ou SubTotal efetuado)
      //"C" ou "R" - CDC ou Cupom Vinculado
      //"G" ou "R" - Relatório Gerencial
      //"N" - Recebimento Não Fiscal
      //"O" - Outro
      case StatusVenda of
        stsIniciada:
          RetornoECF := 'V';
        stsEmPagamento:
          RetornoECF := 'P';
        stsLivre, stsFinalizada, stsCancelada, stsAguardandoTEF, stsOperacaoTEF:
          RetornoECF := 'L';
        else
          RetornoECF := 'O';
      end;
    end;
  end;
end;

procedure TModelPayGoTef1.SetBandeira(AValue: string);
begin
  if FBandeira = AValue then Exit;
  FBandeira := AValue;
end;

procedure TModelPayGoTef1.SetCnpjAdquirente(AValue: string);
begin
  if FCnpjAdquirente = AValue then Exit;
  FCnpjAdquirente := AValue;
end;

procedure TModelPayGoTef1.SetCodAutorizacao(AValue: string);
begin
  if FCodAutorizacao = AValue then Exit;
  FCodAutorizacao := AValue;
end;

procedure TModelPayGoTef1.SetDoc001(AValue: string);
begin
  if FDoc001 = AValue then Exit;
  FDoc001 := AValue;
end;

procedure TModelPayGoTef1.SetDoc002(AValue: string);
begin
  if FDoc002 = AValue then Exit;
  FDoc002 := AValue;
end;


procedure TModelPayGoTef1.SetIdTransacao(AValue: string);
begin
  if FIdTransacao = AValue then Exit;
  FIdTransacao := AValue;
end;

procedure TModelPayGoTef1.SetMensagemFoiMostrada(AValue: boolean);
begin
  if FMensagemFoiMostrada = AValue then Exit;
  FMensagemFoiMostrada := AValue;
end;

procedure TModelPayGoTef1.SetMmLog(AValue: TMemo);
begin
  if FMmLog = AValue then Exit;
  FMmLog := AValue;
end;

procedure TModelPayGoTef1.SetModeloFiscal(AValue: string);
begin
  if FModeloFiscal = AValue then Exit;
  FModeloFiscal := AValue;
end;

procedure TModelPayGoTef1.SetNSU(AValue: string);
begin
  if FNSU = AValue then Exit;
  FNSU := AValue;
end;

procedure TModelPayGoTef1.SetPnlMsgCliente(AValue: TPanel);
begin
  if FPnlMsgCliente = AValue then Exit;
  FPnlMsgCliente := AValue;
end;

procedure TModelPayGoTef1.SetPnlMsgOperador(AValue: TPanel);
begin
  if FPnlMsgOperador = AValue then Exit;
  FPnlMsgOperador := AValue;
end;

procedure TModelPayGoTef1.SetPrimeiraVia(AValue: string);
begin
  if FPrimeiraVia = AValue then Exit;
  FPrimeiraVia := AValue;
end;

procedure TModelPayGoTef1.SetQtdParcelas(AValue: integer);
begin
  if FQtdParcelas = AValue then Exit;
  FQtdParcelas := AValue;
end;

procedure TModelPayGoTef1.SetRede(AValue: string);
begin
  if FRede = AValue then Exit;
  FRede := AValue;
end;

procedure TModelPayGoTef1.SetVlrVenda(AValue: currency);
begin
  if FVlrVenda = AValue then Exit;
  FVlrVenda := AValue;
end;

procedure TModelPayGoTef1.ConfigurarImpressora;
begin
  // Comfigurar o PosPrinter
  AdicionarLinhaLog('- ConfigurarPosPrinter');
  ACBrPosPrinter.Desativar;

  if TDuosigIniFile.new.PosPrinterIniFile.Porta <> '' then
  begin
    ACBrPosPrinter.Porta := TDuosigIniFile.new.PosPrinterIniFile.Porta;
    ACBrPosPrinter.Modelo :=
      TACBrPosPrinterModelo(ObterEnum(TDuosigIniFile.new.PosPrinterIniFile.Modelo));
    ACBrPosPrinter.ArqLOG := TDuosigIniFile.new.PosPrinterIniFile.Arquivo_Log;
    ACBrPosPrinter.LinhasBuffer :=
      StrToIntDef(TDuosigIniFile.new.PosPrinterIniFile.Linhas_Buffer, 1);
    ACBrPosPrinter.LinhasEntreCupons :=
      StrToIntDef(TDuosigIniFile.new.PosPrinterIniFile.Linhas_Entre_Cupons, 1);
    ACBrPosPrinter.EspacoEntreLinhas :=
      StrToIntDef(TDuosigIniFile.new.PosPrinterIniFile.Espaco_Entre_Linhas, 1);
    ACBrPosPrinter.ColunasFonteNormal :=
      StrToIntDef(TDuosigIniFile.new.PosPrinterIniFile.Colunas_Fonte_Normal, 1);
    ACBrPosPrinter.ControlePorta :=
      TDuosigIniFile.new.PosPrinterIniFile.Controle_Porta = 'S';
    ACBrPosPrinter.CortaPapel :=
      TDuosigIniFile.new.PosPrinterIniFile.Corta_Papel = 'S';
    ACBrPosPrinter.TraduzirTags :=
      TDuosigIniFile.new.PosPrinterIniFile.Traduzir_Tags = 'S';
    ACBrPosPrinter.IgnorarTags :=
      TDuosigIniFile.new.PosPrinterIniFile.Ignorar_Tags = 'S';
    ACBrPosPrinter.PaginaDeCodigo :=
      TACBrPosPaginaCodigo(ObterEnumPaginaCodigo(
      TDuosigIniFile.new.PosPrinterIniFile.Pagina_De_Codigo));
    ACBrPosPrinter.Ativar;
  end;

end;

procedure TModelPayGoTef1.MensagemTEF(const MsgOperador, MsgCliente: string);
begin
  if (MsgOperador <> '') then
  begin
    AdicionarLinhaLog('mensgemOperador ' + MsgOperador);
    if Assigned(PnlMsgOperador) then
      PnlMsgOperador.Caption := MsgOperador;
  end;

  if (MsgCliente <> '') then
  begin
    AdicionarLinhaLog('mensgemCliente ' + MsgOperador);
    if Assigned(PnlMsgCliente) then

      PnlMsgCliente.Caption := MsgCliente;
  end;


  PnlMsgOperador.Visible := (Trim(PnlMsgOperador.Caption) <> '');
  PnlMsgCliente.Visible := (Trim(PnlMsgCliente.Caption) <> '');
  Application.ProcessMessages;

end;

function TModelPayGoTef1.ObterEnum(pNome: string): integer;
begin
  if pNome = 'ppTexto' then
    Result := 0
  else if pNome = 'ppEscPosEpson' then
    Result := 1
  else if pNome = 'ppEscBematech' then
    Result := 2
  else if pNome = 'ppEscDaruma' then
    Result := 3
  else if pNome = 'ppEscVox' then
    Result := 4
  else if pNome = 'ppEscDiebold' then
    Result := 5
  else if pNome = 'ppEscEpsonP2' then
    Result := 6
  else if pNome = 'ppCustomPos' then
    Result := 7
  else if pNome = 'ppEscPosStar' then
    Result := 8
  else if pNome = 'ppEscZJiang' then
    Result := 9
  else if pNome = 'ppEscGPrinter' then
    Result := 10
  else if pNome = 'ppEscDatecs' then
    Result := 11
  else if pNome = 'ppEscSunmi' then
    Result := 12
  else if pNome = 'ppExterno' then
    Result := 13;
end;

function TModelPayGoTef1.ObterEnumPaginaCodigo(pNome: string): integer;
begin
  if pNome = 'pcNone' then
    Result := 0
  else if pNome = 'pc437' then
    Result := 1
  else if pNome = 'pc850' then
    Result := 2
  else if pNome = 'pc852' then
    Result := 3
  else if pNome = 'pc860' then
    Result := 4
  else if pNome = 'pcUTF8' then
    Result := 5
  else if pNome = 'pc1252' then
    Result := 6;
end;


procedure TModelPayGoTef1.ViewLog(pString: string);
begin
  //  showMessage(pString);
end;

procedure TModelPayGoTef1.AtivarTef;
begin
  ViewLog('Ativando TEF');
  ConfigurarTef;
  ViewLog('Configurado TEF');

  ACBrTEFD.Inicializar(TACBrTEFDTipo(17)); // PayGo usar o numero 17
  ViewLog('Tef Inicializado');
  ACBrTEFD.ATV;
  ViewLog('Tef ATivo');
end;

procedure TModelPayGoTef1.ConfigurarTef;

var
  Ano, Mes, Dia, Hra, Min, Seg, mil: word;
begin
  DecodeDateTime(now, Ano, Mes, Dia, Hra, Min, Seg, Mil);

  ACBrTEFD.ArqLOG := ExtractFilePath(ParamStr(0)) + 'LogTef';
  if not DirectoryExists(ACBrTEFD.ArqLOG) then
    ForceDirectories(ACBrTEFD.ArqLOG);
  ACBrTEFD.ArqLOG := ACBrTEFD.ArqLOG + '\LogTef_' + IntToStr(Ano) +
    '_' + IntToStr(Mes) + '_' + IntToStr(Dia) + '_' + IntToStr(Hra) +
    '_' + IntToStr(Min) + '_' + IntToStr(Seg) + '_' + IntToStr(mil) + '.log';

  ACBrTEFD.TrocoMaximo := 24;
  ACBrTEFD.ImprimirViaClienteReduzida := False;
  ACBrTEFD.MultiplosCartoes := False;
  ACBrTEFD.ConfirmarAntesDosComprovantes := True;
  ACBrTEFD.NumeroMaximoCartoes := 1;
  ACBrTEFD.SuportaDesconto := False;
  ACBrTEFD.SuportaDesconto := False;
  ACBrTEFD.SuportaSaque := False;

  ACBrTEFD.Identificacao.SoftwareHouse := 'Doutec Sistemas';
  ACBrTEFD.Identificacao.RegistroCertificacao :=
    TDuosigIniFile.New.ConfiguracaoMonitorDuosigIniFile.Numero_Certificado_Duotec_PayGo;
  { #todo : Colocar o numero do registro }
  ACBrTEFD.Identificacao.NomeAplicacao := 'Duosig';
  ACBrTEFD.Identificacao.VersaoAplicacao := '6.37';

  ACBrTEFD.TEFPayGo.SuportaReajusteValor := False;
  ACBrTEFD.TEFPayGo.SuportaNSUEstendido := True;
  ACBrTEFD.TEFPayGo.SuportaViasDiferenciadas := True;

  ACBrTEFD.TEFPayGoWeb.ExibicaoQRCode := qreAuto;

  // Configurações abaixo são obrigatórios, para funcionamento de Não Fiscal //
  ACBrTEFD.AutoEfetuarPagamento := False;
  ACBrTEFD.AutoFinalizarCupom := False;
  ACBrTEFD.TEFPayGo.ArqReq :=
    TDuosigIniFile.New.ConfiguracaoMonitorDuosigIniFile.PastaArquivo_Req_Tef;
  ACBrTEFD.TEFPayGo.ArqResp :=
    TDuosigIniFile.New.ConfiguracaoMonitorDuosigIniFile.PastaArquivo_Resp_Tef;
  ACBrTEFD.TEFPayGo.ArqSTS :=
    TDuosigIniFile.New.ConfiguracaoMonitorDuosigIniFile.PastaArquivo_Sts_Tef;
  ACBrTEFD.TEFPayGo.ArqTemp :=
    TDuosigIniFile.New.ConfiguracaoMonitorDuosigIniFile.PastaArquivo_Temp_Tef;

end;

procedure TModelPayGoTef1.Administrativo;
begin
  try
    FPrimeiraVia := '';
    FModeloFiscal := '99';
    ACBrTEFD.ADM;
    StatusVenda := stsFinalizada;
  finally
  end;
end;

procedure TModelPayGoTef1.ImprimirDoc(pValue: string);
begin
  if FModeloFiscal = '99' then
    // Não vai imprimir cupom nesse momento, somente no mommento da emissao da NFe
  begin
    if not ACBrPosPrinter.Ativo then
      ACBrPosPrinter.Ativar;
    ACBrPosPrinter.Imprimir(pValue);
    ACBrPosPrinter.Desativar;
  end;
end;

function TModelPayGoTef1.VenderCartaoCredito(pAdquirente: string;
  pVlrVenda: currency): boolean;
begin
  ACBrTEFD.TEFPayGoWeb.ParametrosAdicionais.Clear;
  ACBrTEFD.TEFPayGoWeb.ParametrosAdicionais.ValueInfo[PWINFO_CARDTYPE] := '01';
  ACBrTEFD.TrocoMaximo := pVlrVenda;
  FPrimeiraVia := '';
  StatusVenda := stsEmPagamento;
  FIndicePagto := '03';
  fVlrVenda := pVlrVenda;
  Ok := ACBrTEFD.CRT(pVlrVenda, '01');

  if Ok then
  begin
    StatusVenda := stsLivre;
    ACBrTEFD.ImprimirTransacoesPendentes();
  end;

end;

function TModelPayGoTef1.VenderCartaoDebito(pAdquirente: string;
  pVlrVenda: currency): boolean;
begin
  ACBrTEFD.TEFPayGoWeb.ParametrosAdicionais.Clear;
  ViewLog('Vendedndo Debito');
  FPrimeiraVia := '';
  StatusVenda := stsEmPagamento;
  FIndicePagto := '04';
  ACBrTEFD.TrocoMaximo := pVlrVenda;
  fVlrVenda := pVlrVenda;
  ViewLog('Vendedndo Vlr Venda' + FloattoStr(pVlrVenda));
  Ok := ACBrTEFD.CRT(pVlrVenda, FIndicePagto);
  if Ok then
  begin
    StatusVenda := stsLivre;
    ACBrTEFD.ImprimirTransacoesPendentes();
  end;

end;

procedure TModelPayGoTef1.AdicionarLinhaLog(AMensagem: string);
begin
  MmLog.Lines.Add(aMensagem);
end;

end.
