unit Dao.Tanque;

interface

uses
  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Comp.UI, Model.Tanque, DmConexao,
  System.SysUtils, Vcl.Dialogs, Funcoes, System.Classes, Control.Combustivel;

type
  TDaoTanque = class
  public
    function Inserir(pTanque: TTanque): Boolean;
    function Excluir(pCodigo: string): Boolean;
    function Consulta(pPesquisa: string; pTipo: string = 'C'): TTanque;
    function RetornaLista: TStringList;
    function TanquePermiteBomba(pPesquisa: string): Boolean;
    function RetornaProxCodigo: Integer;
  end;

implementation

{ TDaoTanque }

function TDaoTanque.Inserir(pTanque: TTanque): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := False;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('UPDATE OR INSERT INTO TANQUE (CODIGO, DESCRICAO, COMBUSTIVEL)');
    vQuery.SQL.Add(' VALUES (:CODIGO, :DESCRICAO, :COMBUSTIVEL)');
    vQuery.SQL.Add('MATCHING(CODIGO)');
    vQuery.ParamByName('CODIGO').Value := pTanque.Codigo;
    vQuery.ParamByName('DESCRICAO').Value := pTanque.Tanque;
    vQuery.ParamByName('COMBUSTIVEL').Value := pTanque.Combustivel.Codigo;
    try
      vQuery.ExecSQL;
      Result := True;
      ShowMessage(MensagemSalva);
    except
      ShowMessage(MensagemNaoSalva);
    end;
  finally
    FreeAndNil(vQuery);
  end;
end;

function TDaoTanque.RetornaLista: TStringList;
var
  vQuery: TFDQuery;
  lista: TStringList;
begin
  Result := nil;
  try
    lista := TStringList.Create;
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT DESCRICAO FROM TANQUE ');
    vQuery.Prepare;
    vQuery.Open;
    while not vQuery.Eof do
    begin
      lista.Add(vQuery.FieldByName('DESCRICAO').AsString);
      vQuery.Next;
    end;
    Result := lista;
  finally
    FreeAndNil(vQuery);
  end;
end;

function TDaoTanque.RetornaProxCodigo: Integer;
var
  vQuery: TFDQuery;
  vCodigo: integer;
begin
  Result := 1;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT (COALESCE(MAX(CODIGO), 0) + 1) CODIGO ');
    vQuery.SQL.Add('  FROM TANQUE');
    vQuery.Prepare;
    vQuery.Open;
    vCodigo := vQuery.FieldByName('CODIGO').AsInteger;
    Result := vCodigo;
  finally
    FreeAndNil(vQuery);
  end;
end;

function TDaoTanque.TanquePermiteBomba(pPesquisa: String): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := True;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT COUNT(BOMBA) BOMBAS FROM BOMBATANQUE ');
    vQuery.SQL.Add(' WHERE TANQUE = :TANQUE ');
    vQuery.ParamByName('TANQUE').Value := pPesquisa;
    vQuery.Prepare;
    vQuery.Open;
    if vQuery.FieldByName('BOMBAS').AsInteger > 1 then
      Result := False;
  finally
    FreeAndNil(vQuery);
  end;

end;

function TDaoTanque.Excluir(pCodigo: string): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := False;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('DELETE FROM TANQUE WHERE CODIGO = :CODIGO');
    vQuery.ParamByName('CODIGO').Value := pCodigo;
    try
      vQuery.ExecSQL;
      Result := True;
      ShowMessage(MensagemExclusao);
    except
      Result := False;
      ShowMessage(MensagemNaoExclusao);
    end;
  finally
    FreeAndNil(vQuery);
  end;
end;

function TDaoTanque.Consulta(pPesquisa: string; pTipo: string = 'C'): TTanque;
var
  vQuery: TFDQuery;
  Tanque: TTanque;
  Controle: TControlCombustivel;
begin
  try
    Tanque := TTanque.Create;
    Controle := TControlCombustivel.Create;
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT CODIGO, DESCRICAO, COMBUSTIVEL FROM TANQUE');
    if pTipo = 'C' then
    begin
      vQuery.SQL.Add('WHERE CODIGO = :CODIGO');
      vQuery.ParamByName('CODIGO').Value := pPesquisa;
    end;
    if pTipo = 'D' then
    begin
      vQuery.SQL.Add('WHERE DESCRICAO = :DESCRICAO');
      vQuery.ParamByName('DESCRICAO').Value := pPesquisa;
    end;
    vQuery.Open;

    Tanque.Codigo := vQuery.FieldByName('CODIGO').AsInteger;
    Tanque.Tanque := vQuery.FieldByName('DESCRICAO').AsString;
    Tanque.Combustivel := Controle.Consulta(IntToStr(vQuery.FieldByName('COMBUSTIVEL').AsInteger));

    Result := Tanque;
  finally
    FreeAndNil(vQuery);
    Controle.Destroy;
  end;
end;

end.
