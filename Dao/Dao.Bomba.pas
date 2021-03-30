unit Dao.Bomba;

interface

uses
  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Comp.UI, Model.Bomba, DmConexao,
  System.SysUtils, Vcl.Dialogs, Funcoes, System.Classes, Control.Combustivel,
  Control.Tanque;

type
  TDaoBomba = class
  public
    function Inserir(pBomba: TBomba): Boolean;
    function Excluir(pCodigo: string): Boolean;
    function ExcluirBombaTanque(pCodigo: string): Boolean;
    function Consulta(pPesquisa: string; pTipo: string = 'C'): TBomba;
    function RetornaLista: TStringList;
    function RetornaProxCodigo: Integer;
  end;

implementation

{ TDaoBomba }

function TDaoBomba.Consulta(pPesquisa, pTipo: string): TBomba;
var
  vQuery: TFDQuery;
  Bomba: TBomba;
  Controle: TControlTanque;
begin
  Result := nil;
  try
    vQuery := TFDQuery.Create(nil);
    Controle := TControlTanque.Create;
    Bomba := TBomba.Create;
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT CODIGO, DESCRICAO, TANQUE FROM BOMBA');
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
    vQuery.Prepare;
    vQuery.Open;

    Bomba.Codigo := vQuery.FieldByName('CODIGO').AsInteger;
    Bomba.Descricao := vQuery.FieldByName('DESCRICAO').AsString;
    Bomba.Tanque := Controle.Consulta(IntToStr(vQuery.FieldByName('TANQUE').AsInteger));

    Result := Bomba;
  finally
    FreeAndNil(vQuery);
    Controle.Destroy;
  end;
end;

function TDaoBomba.Excluir(pCodigo: string): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := False;
  try
    ExcluirBombaTanque(pCodigo);

    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('DELETE FROM BOMBA WHERE CODIGO = :CODIGO ');
    vQuery.ParamByName('CODIGO').Value := pCodigo;
    Try
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

function TDaoBomba.ExcluirBombaTanque(pCodigo: string): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := False;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('DELETE FROM BOMBATANQUE WHERE BOMBA = :BOMBA');
    vQuery.ParamByName('BOMBA').Value := pCodigo;
    vQuery.Prepare;
    vQuery.ExecSQL;
  finally
    FreeAndNil(vQuery);
  end;
end;

function TDaoBomba.Inserir(pBomba: TBomba): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := False;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('UPDATE OR INSERT INTO BOMBA (CODIGO, DESCRICAO, TANQUE) ');
    vQuery.SQL.Add(' VALUES (:CODIGO, :DESCRICAO, :TANQUE) ');
    vQuery.SQL.Add('MATCHING(CODIGO)');
    vQuery.ParamByName('CODIGO').Value := pBomba.Codigo;
    vQuery.ParamByName('DESCRICAO').Value := pBomba.Descricao;
    vQuery.ParamByName('TANQUE').Value := pBomba.Tanque.Codigo;
    vQuery.Prepare;
    Try
      vQuery.ExecSQL;

      vQuery.SQL.Clear;
      vQuery.SQL.Add('INSERT INTO BOMBATANQUE (BOMBA, TANQUE)');
      vQuery.SQL.Add(' VALUES (:BOMBA, :TANQUE)');
      vQuery.ParamByName('BOMBA').Value := pBomba.Codigo;
      vQuery.ParamByName('TANQUE').Value := pBomba.Tanque.Codigo;
      vQuery.Prepare;
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

function TDaoBomba.RetornaLista: TStringList;
var
  vQuery: TFDQuery;
  lista: TStringList;
begin
  Result := nil;
  try
    lista := TStringList.Create;
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT DESCRICAO FROM BOMBA ');
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

function TDaoBomba.RetornaProxCodigo: Integer;
var
  vQuery: TFDQuery;
  vCodigo: integer;
begin
  Result := 1;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT (COALESCE(MAX(CODIGO), 0) + 1) CODIGO ');
    vQuery.SQL.Add('  FROM BOMBA ');
    vQuery.Prepare;
    vQuery.Open;
    vCodigo := vQuery.FieldByName('CODIGO').AsInteger;
    Result := vCodigo;
  finally
    FreeAndNil(vQuery);
  end;
end;

end.
