unit Funcoes;

interface

uses
  System.SysUtils, Vcl.Dialogs, System.DateUtils;

const
  MascaraMoeda = '#0.000';
  MensagemSalva = 'Salvo com sucesso!';
  MensagemNaoSalva = 'Problemas ao salvar registro!';
  PerguntaExclusao = 'Deseja excluir registro?';
  MensagemExclusao = 'Exclusão concluída!';
  MensagemNaoExclusao = 'Exclusão não concluída!';

type
  TFuncao = class
    public
      class function CampoVazio(pCampo: string; pEnviaMensagem: Boolean): Boolean;
      class function CampoValorValido(pCampo: string; pEnviaMensagem: Boolean): Boolean;
      class function FormataValor(pCampo: string; pEnviaMensagem: Boolean): String;
      class function ValidaData(pData: string; pEnviaMensagem: Boolean): Boolean;
      class function CalculaValorComImposto(pValor: Double): Double;
  end;

implementation

{ TFuncao }

class function TFuncao.CampoVazio(pCampo: string; pEnviaMensagem: Boolean): Boolean;
begin
  if Trim(pCampo) = '' then
  begin
    Result := True;
    if pEnviaMensagem then
      ShowMessage('Campo de preenchimento obrigatório não foi preenchido.');
  end
  else
    Result := False;
end;

class function TFuncao.CalculaValorComImposto(pValor: Double): Double;
begin
  Result := pValor + (pValor * 13 / 100);
end;

class function TFuncao.CampoValorValido(pCampo: string;
  pEnviaMensagem: Boolean): Boolean;
begin
  Result := False;
  try
    StrToFloat(pCampo);
    Result := True;
  except
    if pEnviaMensagem then
      ShowMessage('Verifique o preenchimento do campo.');
  end;
end;

class function TFuncao.FormataValor(pCampo: string;
  pEnviaMensagem: Boolean): String;
begin
  Result := '';
  try
    Result := FormatFloat(MascaraMoeda, StrToFloat(pCampo));
  except
    if pEnviaMensagem then
      raise Exception.Create('Verifique o preenchimento do campo.');
    Result := pCampo;
  end;
end;

class function TFuncao.ValidaData(pData: String; pEnviaMensagem: Boolean): Boolean;
begin
  Result := True;
  try
    StrToDate(pData);
  except
    if pEnviaMensagem then
      ShowMessage('Data inválida');
    Result := False;
  end;
end;

end.
