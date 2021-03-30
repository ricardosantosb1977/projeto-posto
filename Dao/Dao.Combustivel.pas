unit Dao.Combustivel;

interface

uses
  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Comp.UI, Model.Combustivel,
  DmConexao, System.SysUtils, System.Classes, Vcl.Dialogs, Funcoes;

type
  TDaoCombustivel = class
    function Inserir(pCombustivel: TCombustivel): Boolean;
    function Excluir(pCodigo: string): Boolean;
    function Consulta(pPesquisa: string; pTipo: string = 'C'): TCombustivel;
    function RetornaLista: TStringList;
    function RetornaProxCodigo: Integer;
  end;

implementation

{ TDaoCombustivel }

function TDaoCombustivel.Inserir(pCombustivel: TCombustivel): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := False;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('UPDATE OR INSERT INTO COMBUSTIVEL (CODIGO, DESCRICAO, VALOR)');
    vQuery.SQL.Add(' VALUES (:CODIGO, :DESCRICAO, :VALOR) ');
    vQuery.SQL.Add('MATCHING(CODIGO)');
    vQuery.ParamByName('CODIGO').Value := pCombustivel.Codigo;
    vQuery.ParamByName('DESCRICAO').Value := pCombustivel.Descricao;
    vQuery.ParamByName('VALOR').Value := pCombustivel.Valor;
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

function TDaoCombustivel.RetornaLista: TStringList;
var
  vQuery: TFDQuery;
  lista: TStringList;
begin
  Result := nil;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT DESCRICAO FROM COMBUSTIVEL');
    vQuery.Open;
    lista := TStringList.Create;
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

function TDaoCombustivel.RetornaProxCodigo: Integer;
var
  vQuery: TFDQuery;
  vCodigo: integer;
begin
  Result := 1;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT (COALESCE(MAX(CODIGO), 0) + 1) CODIGO ');
    vQuery.SQL.Add('  FROM COMBUSTIVEL');
    vQuery.Prepare;
    vQuery.Open;
    vCodigo := vQuery.FieldByName('CODIGO').AsInteger;
    Result := vCodigo;
  finally
    FreeAndNil(vQuery);
  end;
end;

function TDaoCombustivel.Excluir(pCodigo: string): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := False;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('DELETE FROM COMBUSTIVEL WHERE CODIGO = :CODIGO');
    vQuery.ParamByName('CODIGO').Value := pCodigo;
    try
      vQuery.ExecSQL;
      Result := True;
      ShowMessage(MensagemExclusao);
    except
      ShowMessage(MensagemNaoExclusao);
    end;
  finally
    FreeAndNil(vQuery);
  end;
end;

function TDaoCombustivel.Consulta(pPesquisa: string; pTipo: string = 'C'): TCombustivel;
var
  vQuery: TFDQuery;
  Combustivel: TCombustivel;
begin
  try
    Combustivel := TCombustivel.Create;
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT CODIGO, DESCRICAO, VALOR FROM COMBUSTIVEL ');
    if pTipo = 'C' then
    begin
      vQuery.SQL.Add(' WHERE CODIGO = :CODIGO ');
      vQuery.ParamByName('CODIGO').Value := pPesquisa;
    end;
    if pTipo = 'D' then
    begin
      vQuery.SQL.Add(' WHERE DESCRICAO = :DESCRICAO ');
      vQuery.ParamByName('DESCRICAO').Value := pPesquisa;
    end;
    vQuery.Open;

    Combustivel.Codigo := vQuery.FieldByName('CODIGO').AsInteger;
    Combustivel.Descricao := vQuery.FieldByName('DESCRICAO').AsString;
    Combustivel.Valor := vQuery.FieldByName('VALOR').AsCurrency;

    Result := Combustivel;
  finally
    FreeAndNil(vQuery);
  end;
end;

end.
