unit Dao.Venda;

interface

uses
  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Comp.UI, Model.Venda, DmConexao,
  System.SysUtils, Vcl.Dialogs, Funcoes, System.Classes, Control.Bomba;

type
  TDaoVenda = class
  public
    function Inserir(pVenda: TVenda): Boolean;
    function Excluir(pCodigo: string): Boolean;
    function Consulta(pPesquisa: string): TVenda;
    function RetornaLista: TStringList;
    function RetornaProxCodigo: Integer;
  end;

implementation

{ DaoVenda }

function TDaoVenda.Excluir(pCodigo: string): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := False;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('DELETE FROM VENDA WHERE CODIGO = :CODIGO');
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

function TDaoVenda.Inserir(pVenda: TVenda): Boolean;
var
  vQuery: TFDQuery;
  strData: string;
begin
  Result := False;
  try
    strData := QuotedStr(FormatDateTime('yyyy-mm-dd', pVenda.Data));
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('UPDATE OR INSERT INTO VENDA (CODIGO, BOMBA, QTDE, VALOR, VALOR_IMPOSTO, DATA)');
    vQuery.SQL.Add('VALUES (:CODIGO, :BOMBA, :QTDE, :VALOR, :VALOR_IMPOSTO, ' + strData + ')');
    vQuery.SQL.Add('MATCHING(CODIGO)');
    vQuery.ParamByName('CODIGO').Value := pVenda.Codigo;
    vQuery.ParamByName('BOMBA').Value := pVenda.Bomba.Codigo;
    vQuery.ParamByName('QTDE').Value := pVenda.Qtde;
    vQuery.ParamByName('VALOR').Value := pVenda.Valor;
    vQuery.ParamByName('VALOR_IMPOSTO').Value := pVenda.Valor_Imposto;
    try
      vQuery.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(vQuery);
  end;
end;

function TDaoVenda.RetornaLista: TStringList;
begin

end;

function TDaoVenda.RetornaProxCodigo: Integer;
var
  vQuery: TFDQuery;
  vCodigo: integer;
begin
  Result := 1;
  try
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT (COALESCE(MAX(CODIGO), 0) + 1) CODIGO ');
    vQuery.SQL.Add('  FROM VENDA ');
    vQuery.Prepare;
    vQuery.Open;
    vCodigo := vQuery.FieldByName('CODIGO').AsInteger;
    Result := vCodigo;
  finally
    FreeAndNil(vQuery);
  end;
end;

function TDaoVenda.Consulta(pPesquisa: string): TVenda;
var
  vQuery: TFDQuery;
  Venda: TVenda;
  ControlBomba: TControlBomba;
begin
  try
    Venda := TVenda.Create;
    ControlBomba := TControlBomba.Create;

    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DM.FBConexao;
    vQuery.SQL.Add('SELECT V.CODIGO, V.BOMBA, V.QTDE, V.VALOR, V.VALOR_IMPOSTO, V.DATA ');
    vQuery.SQL.Add('  FROM VENDA V ');
    vQuery.SQL.Add(' WHERE V.CODIGO = :CODIGO ');
    vQuery.ParamByName('CODIGO').Value := pPesquisa;
    vQuery.Open;

    Venda.Codigo := vQuery.FieldByName('CODIGO').AsInteger;
    Venda.Bomba := ControlBomba.Consulta(IntToStr(vQuery.FieldByName('BOMBA').AsInteger));
    Venda.Qtde := vQuery.FieldByName('QTDE').AsFloat;
    Venda.Valor := vQuery.FieldByName('VALOR').AsFloat;
    Venda.Valor_Imposto := vQuery.FieldByName('VALOR_IMPOSTO').AsFloat;
    if vQuery.FieldByName('DATA').AsString <> '' then
      Venda.Data := vQuery.FieldByName('DATA').AsDateTime;

    Result := Venda;
  finally
    ControlBomba.Destroy;
  end;
end;

end.
