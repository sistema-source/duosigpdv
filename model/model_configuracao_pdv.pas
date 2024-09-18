unit model_configuracao_pdv;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model_conexao_firebird, ZDataset, Dialogs;

type

  { TModelConfiguracaoPdv }

  TModelConfiguracaoPdv = class(TDataModule)
    QryPesquisa: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FClienteConsumidorFinal: Boolean;
    FClienteContribuinte: Boolean;
    FCodCliente: integer;
    FCodCondicaoPagto: integer;
    FCodHistorico: string;
    FCodLoja: string;
    FCodSerieNFCe: string;
    FCodSerieNFe: string;
    FCodTabelaPreco: integer;
    FCodTpCobranca: string;
    FCodTpEstoque: integer;
    FCodTpOperacao: string;
    FCodVendedor: string;
    FCodZonaVenda: string;
    FEspecieVolume: String;
    FMarcaVolume: String;
    FModelConexaoFirebird: TModelConexaoFirebird;
    FNumCaixa: integer;
    FPerSimples: Currency;
    FRegimeTributacao: string;
    FSenhaCertificadoDigital: String;
    FStsCfo: String;
    FTipoEntrega: string;
    FTipoFrete: string;
    FViaTransporte: string;
    procedure SetClienteConsumidorFinal(AValue: Boolean);
    procedure SetClienteContribuinte(AValue: Boolean);
    procedure SetCodCliente(AValue: integer);
    procedure SetCodCondicaoPagto(AValue: integer);
    procedure SetCodHistorico(AValue: string);
    procedure SetCodLoja(AValue: string);
    procedure SetCodSerieNFCe(AValue: string);
    procedure SetCodSerieNFe(AValue: string);
    procedure SetCodTabelaPreco(AValue: integer);
    procedure SetCodTpCobranca(AValue: string);
    procedure SetCodTpEstoque(AValue: integer);
    procedure SetCodTpOperacao(AValue: string);
    procedure SetCodVendedor(AValue: string);
    procedure SetCodZonaVenda(AValue: string);
    procedure SetEspecieVolume(AValue: String);
    procedure SetMarcaVolume(AValue: String);
    procedure SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
    procedure SetNumCaixa(AValue: integer);
    procedure SetPerSimples(AValue: Currency);
    procedure SetRegimeTributacao(AValue: string);
    procedure SetSenhaCertificadoDigital(AValue: String);
    procedure SetStsCfo(AValue: String);
    procedure SetTipoEntrega(AValue: string);
    procedure SetTipoFrete(AValue: string);
    procedure SetViaTransporte(AValue: string);

  public


    procedure CarregarDadosPadrao(pUsuario: string);

    property ModelConexaoFirebird: TModelConexaoFirebird
      read FModelConexaoFirebird write SetModelConexaoFirebird;

    property CodLoja: string read FCodLoja write SetCodLoja;
    property CodSerieNFe: string read FCodSerieNFe write SetCodSerieNFe;
    property CodSerieNFCe: string read FCodSerieNFCe write SetCodSerieNFCe;
    property CodVendedor: string read FCodVendedor write SetCodVendedor;
    property CodHistorico: string read FCodHistorico write SetCodHistorico;
    property CodTabelaPreco: integer read FCodTabelaPreco write SetCodTabelaPreco;

    property NumCaixa: integer read FNumCaixa write SetNumCaixa;
    property CodTpOperacao: string read FCodTpOperacao write SetCodTpOperacao;
    property CodCliente: integer read FCodCliente write SetCodCliente;
    property CodZonaVenda: string read FCodZonaVenda write SetCodZonaVenda;
    property CodTpEstoque: integer read FCodTpEstoque write SetCodTpEstoque;
    property TipoFrete: string read FTipoFrete write SetTipoFrete;
    property CodCondicaoPagto: integer read FCodCondicaoPagto write SetCodCondicaoPagto;
    property CodTpCobranca: string read FCodTpCobranca write SetCodTpCobranca;
    property ViaTransporte: string read FViaTransporte write SetViaTransporte;
    property TipoEntrega: string read FTipoEntrega write SetTipoEntrega;

    property EspecieVolume : String read FEspecieVolume write SetEspecieVolume;
    property MarcaVolume : String read FMarcaVolume write SetMarcaVolume;

    property StsCfo : String read FStsCfo write SetStsCfo;
    property ClienteContribuinte : Boolean read FClienteContribuinte write SetClienteContribuinte;
    property ClienteConsumidorFinal : Boolean read FClienteConsumidorFinal write SetClienteConsumidorFinal;
    property PerSimples : Currency read FPerSimples write SetPerSimples;
    property RegimeTributacao : string read FRegimeTributacao write SetRegimeTributacao;
    property SenhaCertificadoDigital : String read FSenhaCertificadoDigital write SetSenhaCertificadoDigital;




  end;

var
  ModelConfiguracaoPdv: TModelConfiguracaoPdv;

implementation

{$R *.lfm}

{ TModelConfiguracaoPdv }

procedure TModelConfiguracaoPdv.DataModuleCreate(Sender: TObject);
begin
  FcodLoja := '01';
  FCodSerieNFCe := '65';
  FCodSerieNFe := '01';
end;

procedure TModelConfiguracaoPdv.SetCodLoja(AValue: string);
begin
  if FCodLoja = AValue then Exit;
  FCodLoja := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodCliente(AValue: integer);
begin
  if FCodCliente = AValue then Exit;
  FCodCliente := AValue;
end;

procedure TModelConfiguracaoPdv.SetClienteConsumidorFinal(AValue: Boolean);
begin
  if FClienteConsumidorFinal=AValue then Exit;
  FClienteConsumidorFinal:=AValue;
end;

procedure TModelConfiguracaoPdv.SetClienteContribuinte(AValue: Boolean);
begin
  if FClienteContribuinte=AValue then Exit;
  FClienteContribuinte:=AValue;
end;

procedure TModelConfiguracaoPdv.SetCodCondicaoPagto(AValue: integer);
begin
  if FCodCondicaoPagto = AValue then Exit;
  FCodCondicaoPagto := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodHistorico(AValue: string);
begin
  if FCodHistorico = AValue then Exit;
  FCodHistorico := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodSerieNFCe(AValue: string);
begin
  if FCodSerieNFCe = AValue then Exit;
  FCodSerieNFCe := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodSerieNFe(AValue: string);
begin
  if FCodSerieNFe = AValue then Exit;
  FCodSerieNFe := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodTabelaPreco(AValue: integer);
begin
  if FCodTabelaPreco = AValue then Exit;
  FCodTabelaPreco := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodTpCobranca(AValue: string);
begin
  if FCodTpCobranca = AValue then Exit;
  FCodTpCobranca := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodTpEstoque(AValue: integer);
begin
  if FCodTpEstoque = AValue then Exit;
  FCodTpEstoque := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodTpOperacao(AValue: string);
begin
  if FCodTpOperacao = AValue then Exit;
  FCodTpOperacao := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodVendedor(AValue: string);
begin
  if FCodVendedor = AValue then Exit;
  FCodVendedor := AValue;
end;

procedure TModelConfiguracaoPdv.SetCodZonaVenda(AValue: string);
begin
  if FCodZonaVenda = AValue then Exit;
  FCodZonaVenda := AValue;
end;

procedure TModelConfiguracaoPdv.SetEspecieVolume(AValue: String);
begin
  if FEspecieVolume=AValue then Exit;
  FEspecieVolume:=AValue;
end;

procedure TModelConfiguracaoPdv.SetMarcaVolume(AValue: String);
begin
  if FMarcaVolume=AValue then Exit;
  FMarcaVolume:=AValue;
end;

procedure TModelConfiguracaoPdv.SetModelConexaoFirebird(AValue: TModelConexaoFirebird);
begin
  if FModelConexaoFirebird = AValue then Exit;
  FModelConexaoFirebird := AValue;

  QryPesquisa.Connection := FModelConexaoFirebird.ConexaoFirebird;
end;

procedure TModelConfiguracaoPdv.SetNumCaixa(AValue: integer);
begin
  if FNumCaixa = AValue then Exit;
  FNumCaixa := AValue;
end;

procedure TModelConfiguracaoPdv.SetPerSimples(AValue: Currency);
begin
  if FPerSimples=AValue then Exit;
  FPerSimples:=AValue;
end;

procedure TModelConfiguracaoPdv.SetRegimeTributacao(AValue: string);
begin
  if FRegimeTributacao=AValue then Exit;
  FRegimeTributacao:=AValue;
end;

procedure TModelConfiguracaoPdv.SetSenhaCertificadoDigital(AValue: String);
begin
  if FSenhaCertificadoDigital=AValue then Exit;
  FSenhaCertificadoDigital:=AValue;
end;

procedure TModelConfiguracaoPdv.SetStsCfo(AValue: String);
begin
  if FStsCfo=AValue then Exit;
  FStsCfo:=AValue;
end;

procedure TModelConfiguracaoPdv.SetTipoEntrega(AValue: string);
begin
  if FTipoEntrega = AValue then Exit;
  FTipoEntrega := AValue;
end;

procedure TModelConfiguracaoPdv.SetTipoFrete(AValue: string);
begin
  if FTipoFrete = AValue then Exit;
  FTipoFrete := AValue;
end;

procedure TModelConfiguracaoPdv.SetViaTransporte(AValue: string);
begin
  if FViaTransporte = AValue then Exit;
  FViaTransporte := AValue;
end;

procedure TModelConfiguracaoPdv.CarregarDadosPadrao(pUsuario: string);
var
  s: string;
begin
  pUsuario := 'DUOTEC';
  s := '';
  s := s + '   select';
  s := s + '         s501.ideusu,';
  s := s + '         s501.defcodlja,';
  s := s + '         s501.defcodsrenfe,';
  s := s + '         s501.defcodsrenfscupfsc,';
  s := s + '         s501.defcodvnd,   ';
  s := s + '         s501.defcodhisvda,';
  s := s + '         s501.defnumcxa,   ';
  s := s + '         s501.defcodtpoope,';
  s := s + '         s501.defcodtpoetq,';
  s := s + '         s501.defciffob,  ';
  s := s + '         s501.defcodcndpgt, ';
  s := s + '         s501.defcodtpocob,';
  s := s + '         s501.defviatrp, ';
  s := s + '         s501.defcodtab,';
  s := s + '         s501.defcodzonvda,';
  s := s + '         ' + QuotedStr('B') + ' as deftpoetg,';
  s := s + '         s501.defcodcliorc, ';
  s := s + '         s501.defespvol, ';
  s := s + '          s501.defmrcvol,  ';
  s := s + '          s018.s018.persimples,  ';
  s := s + '          s018.statporeg,  ';
  s := s + '          s019.staclicon, ,  ';
  s := s + '          s019.stacliconfin,  ';
  s := s + '     from sinaf501 s501';
  s := s + '     left join sinaf498 s498 on s498.ideusu = s501.ideusu';
  s := s + '     left join sinaf018 s018 on s018.empgrp = '+QuotedStr('01') + ' and s018.codlja = S501.defcodlja';
  s := s + '     left join sinaf019 s019 on s019.codcli =  S501.defcodcli';
  s := s + '     left join sinaf104 s104 on s104.codope =  S501.defcodtpoope';
  s := s + '     where s501.ideusu = :pUsuario';

  QryPesquisa.Close;
  QryPesquisa.SQL.Text := s;
  QryPesquisa.ParamByName('pUsuario').AsString := pUsuario;
  QryPesquisa.Open;

  if QryPesquisa.IsEmpty then
    raise Exception.Create('Usuário [' + pUsuario + '] não cadastrado ');

  CodLoja := QryPesquisa.FieldByName('defcodlja').AsString;
  CodSerieNFe := QryPesquisa.FieldByName('defcodsrenfe').AsString;
  CodSerieNFCe := QryPesquisa.FieldByName('defcodsrenfscupfsc').AsString;
  CodVendedor := QryPesquisa.FieldByName('defcodvnd').AsString;
  CodHistorico := QryPesquisa.FieldByName('defcodhisvda').AsString;
  CodTabelaPreco := QryPesquisa.FieldByName('defcodtab').AsInteger;
  NumCaixa := QryPesquisa.FieldByName('defnumcxa').AsInteger;
  CodTpOperacao := QryPesquisa.FieldByName('defcodtpoope').AsString;
  CodCliente := QryPesquisa.FieldByName('defcodcliorc').AsInteger;
  CodZonaVenda := QryPesquisa.FieldByName('defcodzonvda').AsString;
  CodTpEstoque := QryPesquisa.FieldByName('defcodtpoetq').AsInteger;
  TipoFrete := QryPesquisa.FieldByName('defciffob').AsString;
  CodCondicaoPagto := QryPesquisa.FieldByName('defcodcndpgt').AsInteger;
  CodTpCobranca := QryPesquisa.FieldByName('defcodtpocob').AsString;
  ViaTransporte := QryPesquisa.FieldByName('defviatrp').AsString;
  TipoEntrega := QryPesquisa.FieldByName('deftpoetg').AsString;
  EspecieVolume := QryPesquisa.FieldByName('defespvol').AsString;
  MarcaVolume := QryPesquisa.FieldByName('defmrcvol').AsString;

   StsCfo := QryPesquisa.FieldByName('tpoope').AsString;
   ClienteContribuinte :=  QryPesquisa.FieldByName('staclicon').AsString = 'S';
   ClienteConsumidorFinal := QryPesquisa.FieldByName('stacliconfin').AsString = 'S';
   PerSimples := QryPesquisa.FieldByName('persimples').AsCurrency;
   RegimeTributacao := QryPesquisa.FieldByName('statporeg').AsString;





end;


end.
